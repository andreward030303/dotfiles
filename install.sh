#!/bin/bash
set -euo pipefail
trap 'echo "❌ Error on line $LINENO: $BASH_COMMAND" >&2' ERR

# ======================
# 環境情報取得
# ======================
. /etc/os-release

ARCH=$(uname -m)
LIBC="gnu"
if ldd --version 2>&1 | grep -qi musl; then
  LIBC="musl"
fi

echo "🧱 Detected architecture: $ARCH (libc: $LIBC, distro: $ID)"

# ======================
# 基本パッケージ
# ======================
apt update
apt install -y wget curl gettext unzip locales software-properties-common

# ======================
# 最新 cmake / ninja / git / gcc セットアップ
# ======================

# --- CMake ---
CMAKE_VERSION="3.29.6"
if command -v cmake >/dev/null 2>&1; then
  CUR_CMAKE=$(cmake --version | head -n1 | awk '{print $3}')
  echo "ℹ️ Found CMake $CUR_CMAKE"
else
  CUR_CMAKE="0.0.0"
fi

if [ "$(printf '%s\n' "$CUR_CMAKE" "3.16.0" | sort -V | head -n1)" = "$CUR_CMAKE" ]; then
  echo "🚀 Installing CMake ${CMAKE_VERSION}..."
  if [ "$ARCH" = "x86_64" ]; then
    CMAKE_FILE="cmake-${CMAKE_VERSION}-linux-x86_64.sh"
  elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    CMAKE_FILE="cmake-${CMAKE_VERSION}-linux-aarch64.sh"
  else
    echo "❌ Unsupported architecture for CMake: $ARCH"
    exit 1
  fi
  curl -LO "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_FILE}"
  sh "$CMAKE_FILE" --skip-license --prefix=/usr/local
  rm -f "$CMAKE_FILE"
  cmake --version
fi

# --- Ninja ---
NINJA_VERSION="1.12.1"
if ! command -v ninja >/dev/null 2>&1 || [ "$(ninja --version 2>/dev/null || echo 0)" \< "1.10" ]; then
  echo "🚀 Installing Ninja ${NINJA_VERSION}..."
  if [ "$ARCH" = "x86_64" ]; then
    NINJA_URL="https://github.com/ninja-build/ninja/releases/download/v${NINJA_VERSION}/ninja-linux.zip"
    curl -LO "$NINJA_URL"
    unzip ninja-linux*.zip
    mv ninja /usr/local/bin/
    chmod +x /usr/local/bin/ninja
    rm -f ninja-linux*.zip
  elif [ "$ARCH" = "aarch64" ]; then
    echo "⚠️ No prebuilt Ninja for aarch64 — building from source..."
    git clone https://github.com/ninja-build/ninja.git
    cd ninja && cmake -Bbuild-cmake && cmake --build build-cmake
    cp build-cmake/ninja /usr/local/bin/
    cd .. && rm -rf ninja
  else
    echo "❌ Unsupported architecture for Ninja: $ARCH"
    exit 1
  fi
  ninja --version
fi

# --- Git ---
echo "🚀 Ensuring latest Git..."
if [ "$ID" = "ubuntu" ]; then
  apt install -y software-properties-common
  add-apt-repository ppa:git-core/ppa -y
  apt update -y && apt install -y git
elif [ "$ID" = "debian" ]; then
  echo "⚠️ DebianではPPAは無効。公式レポジトリのgitを使用。"
  apt install -y git
else
  echo "⚠️ Git installation skipped for unsupported distro ($ID)"
fi
git --version

# --- GCC / build-essential ---
echo "🚀 Ensuring modern GCC (>=10)..."
apt install -y build-essential
if gcc --version | grep -q ' 8\.'; then
  echo "⚠️ GCC is old. Trying to upgrade..."
  if [ "$ID" = "debian" ]; then
    if ! grep -q "buster-backports" /etc/apt/sources.list; then
      echo "⚙️ Adding buster-backports repo..."
      echo "deb http://deb.debian.org/debian buster-backports main contrib non-free" >> /etc/apt/sources.list
      apt update
    fi

    apt -t buster-backports install -y gcc-10 g++-10 || true

    if [ -x /usr/bin/gcc-10 ]; then
      update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100 || true
      update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 100 || true
    else
      echo "⚠️ gcc-10 not found after installation attempt. Keeping existing GCC."
    fi
  fi
fi

# ======================
# fd & ripgrep
# ======================
FD_VERSION=9.0.0
RG_VERSION=14.1.0

if [ "$ARCH" = "x86_64" ]; then
  FD_ARCH="x86_64-unknown-linux-${LIBC}"
  RG_ARCH="x86_64-unknown-linux-${LIBC}"
elif [ "$ARCH" = "aarch64" ]; then
  FD_ARCH="aarch64-unknown-linux-${LIBC}"
  RG_ARCH="aarch64-unknown-linux-${LIBC}"
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi

echo "🚀 Installing fd ${FD_VERSION} for ${FD_ARCH}..."
curl -L "https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-${FD_ARCH}.tar.gz" \
  | tar xz
cp -f "fd-v${FD_VERSION}-${FD_ARCH}/fd" /usr/local/bin/
rm -rf "fd-v${FD_VERSION}-${FD_ARCH}"

echo "🚀 Installing ripgrep ${RG_VERSION} for ${RG_ARCH}..."
RG_FILE="ripgrep-${RG_VERSION}-${RG_ARCH}.tar.xz"
RG_URL="https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/${RG_FILE}"

curl -LO "$RG_URL"

if [ -f "$RG_FILE" ]; then
  tar xf "$RG_FILE"
  cp -f "ripgrep-${RG_VERSION}-${RG_ARCH}/rg" /usr/local/bin/
  rm -rf "ripgrep-${RG_VERSION}-${RG_ARCH}" "$RG_FILE"
else
  echo "❌ Failed to download ripgrep from $RG_URL"
  exit 1
fi

fd --version
rg --version

# ======================
# ロケール設定
# ======================
if [ "$ID" = "ubuntu" ]; then
  apt-get install -y language-pack-ja
elif [ "$ID" = "debian" ]; then
  apt-get install -y locales
  sed -i '/ja_JP.UTF-8/s/^# //g' /etc/locale.gen
  locale-gen
fi

update-locale LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8

if ! grep -q "ja_JP.UTF-8" "$HOME/.bashrc"; then
  cat <<'EOF' >> "$HOME/.bashrc"

# locale
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
EOF
fi

# ======================
# Node.js (nvm)
# ======================
if ! command -v node >/dev/null 2>&1; then
  echo "🚀 Installing Node.js (latest LTS) via nvm..."
  export NVM_DIR="$HOME/.nvm"
  mkdir -p "$NVM_DIR"

  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
  fi

  . "$NVM_DIR/nvm.sh"
  nvm install --lts
  nvm alias default 'lts/*'

  if ! grep -q 'NVM_DIR' "$HOME/.bashrc"; then
    cat <<'EOF' >> "$HOME/.bashrc"

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
EOF
  fi
fi

# ======================
# Neovim ビルド
# ======================
cd ~
if [ ! -d "neovim" ]; then
  git clone https://github.com/neovim/neovim.git
fi

cd neovim
git fetch --all
git checkout v0.11.4
make CMAKE_BUILD_TYPE=Release
make install
cd ~

# ======================
# tmux ビルド
# ======================
apt install -y pkg-config libncurses5-dev libncursesw5-dev libevent-dev m4 texinfo autoconf flex

# --- automake ---
AUTOMAKE_VERSION="1.16.5"
if ! command -v automake >/dev/null 2>&1 || [[ "$(automake --version | head -n1 | awk '{print $4}')" < "1.16" ]]; then
  echo "🚀 Installing automake ${AUTOMAKE_VERSION} from GNU..."
  if [ "$ARCH" = "x86_64" ]; then
    curl -LO "https://ftp.gnu.org/gnu/automake/automake-${AUTOMAKE_VERSION}.tar.gz"
    tar xf automake-${AUTOMAKE_VERSION}.tar.gz
    cd automake-${AUTOMAKE_VERSION}
    ./configure && make && make install
    cd .. && rm -rf automake-${AUTOMAKE_VERSION}*
  else
    echo "⚠️ Skipping automake source build on non-x86_64"
  fi
fi

# --- bison ---
BISON_VERSION="3.8.2"
if ! command -v bison >/dev/null 2>&1 || [[ "$(bison --version | head -n1 | awk '{print $4}')" < "3.5" ]]; then
  echo "🚀 Installing bison ${BISON_VERSION} from GNU..."
  if [ "$ARCH" = "x86_64" ]; then
    curl -LO "https://ftp.gnu.org/gnu/bison/bison-${BISON_VERSION}.tar.gz"
    tar xf bison-${BISON_VERSION}.tar.gz
    cd bison-${BISON_VERSION}
    ./configure && make && make install
    cd .. && rm -rf bison-${BISON_VERSION}*
  else
    echo "⚠️ Skipping bison source build on non-x86_64"
  fi
fi

if [ ! -d "tmux" ]; then
  git clone https://github.com/tmux/tmux.git
fi
cd tmux
git fetch --all
git checkout 3.5a
sh autogen.sh
./configure
make
make install
cd ~

# ======================
# Neovim PATH / alias
# ======================
if ! grep -q 'nvim/mason/bin' "$HOME/.bashrc"; then
  echo 'export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"' >> "$HOME/.bashrc"
fi

if ! grep -q "alias v=" "$HOME/.bashrc"; then
  echo "alias v='nvim .'" >> "$HOME/.bashrc"
  echo "alias t='tmux -2 a'" >> "$HOME/.bashrc"
  echo "alias nt='tmux -2'" >> "$HOME/.bashrc"
fi

# ======================
# Stylua
# ======================
if ! command -v stylua >/dev/null 2>&1; then
  echo "🚀 Installing Stylua from source..."
  if ! command -v cargo >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env" || true
    export PATH="$HOME/.cargo/bin:$PATH"
    if ! grep -q ".cargo/bin" "$HOME/.bashrc"; then
      echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "$HOME/.bashrc"
    fi
  fi
  cargo install stylua --locked
  stylua --version
fi

# ======================
# Prettier
# ======================
if ! command -v prettier >/dev/null 2>&1; then
  echo "🚀 Installing Prettier (via npm)..."
  npm install -g prettier
  prettier --version
fi

# ======================
# Neovim 設定リンク
# ======================
mkdir -p "$HOME/.config"
ln -sfn "$HOME/dotfiles/nvim" "$HOME/.config/nvim"

echo "✅ Setup complete. Run 'source ~/.bashrc' to apply changes."