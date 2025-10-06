#!/bin/bash
set -euo pipefail
trap 'echo "❌ Error on line $LINENO: $BASH_COMMAND" >&2' ERR

# ======================
# OS / アーキ情報
# ======================
. /etc/os-release

ARCH=$(uname -m)
LIBC="gnu"
if ldd --version 2>&1 | grep -qi musl; then
  LIBC="musl"
fi

echo "🧱 Detected architecture: $ARCH (libc: $LIBC, distro: $ID)"

# ======================
# Debian oldrelease対応（archive.debian.org）
# ======================
if [ "$ID" = "debian" ]; then
  echo "🧹 Cleaning old sources and configuring archive mirror..."
  cat <<'EOF' > /etc/apt/sources.list
deb [check-valid-until=no trusted=yes] http://archive.debian.org/debian buster main contrib non-free
deb [check-valid-until=no trusted=yes] http://archive.debian.org/debian-security buster/updates main contrib non-free
deb [check-valid-until=no trusted=yes] http://archive.debian.org/debian buster-backports main contrib non-free
EOF
  echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid
fi

# ======================
# 基本パッケージ
# ======================
apt update -y
apt install -y wget curl gettext unzip locales software-properties-common ca-certificates gnupg

# ======================
# CMake / Ninja / Git / GCC 最新化
# ======================

# --- CMake ---
CMAKE_VERSION="3.29.6"
if command -v cmake >/dev/null 2>&1; then
  CUR_CMAKE=$(cmake --version | head -n1 | awk '{print $3}')
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
  curl -fsSLO "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_FILE}"
  sh "$CMAKE_FILE" --skip-license --prefix=/usr/local
  rm -f "$CMAKE_FILE"
fi
cmake --version

# --- Ninja ---
NINJA_VERSION="1.12.1"
if ! command -v ninja >/dev/null 2>&1 || [ "$(ninja --version 2>/dev/null || echo 0)" \< "1.10" ]; then
  echo "🚀 Installing Ninja ${NINJA_VERSION}..."
  if [ "$ARCH" = "x86_64" ]; then
    curl -fsSLO "https://github.com/ninja-build/ninja/releases/download/v${NINJA_VERSION}/ninja-linux.zip"
    unzip -q ninja-linux.zip
    mv ninja /usr/local/bin/
    chmod +x /usr/local/bin/ninja
    rm -f ninja-linux.zip
  elif [ "$ARCH" = "aarch64" ]; then
    echo "⚙️ Building Ninja from source for aarch64..."
    git clone --depth=1 https://github.com/ninja-build/ninja.git
    cd ninja
    cmake -Bbuild && cmake --build build
    mv build/ninja /usr/local/bin/
    cd .. && rm -rf ninja
  fi
fi
ninja --version

# --- Git ---
echo "🚀 Ensuring latest Git..."
if [ "$ID" = "ubuntu" ]; then
  add-apt-repository -y ppa:git-core/ppa
  apt update -y && apt install -y git
elif [ "$ID" = "debian" ]; then
  apt install -y git
else
  echo "⚠️ Skipping Git install on unknown distro ($ID)"
fi
git --version

# --- GCC ---
echo "🚀 Ensuring modern GCC..."
apt install -y build-essential
if gcc --version | grep -q ' 8\.'; then
  echo "⚙️ Upgrading GCC via archive backports..."
  apt -t buster-backports install -y gcc-10 g++-10 || true
  if [ -x /usr/bin/gcc-10 ]; then
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 100
  else
    echo "⚠️ gcc-10 not available; keeping GCC 8."
  fi
fi
gcc --version

# ======================
# fd / ripgrep
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
  echo "❌ Unsupported architecture: $ARCH"
  exit 1
fi

echo "🚀 Installing fd ${FD_VERSION}..."
curl -fsSL "https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-${FD_ARCH}.tar.gz" | tar xz
cp "fd-v${FD_VERSION}-${FD_ARCH}/fd" /usr/local/bin/
rm -rf "fd-v${FD_VERSION}-${FD_ARCH}"
fd --version

echo "🚀 Installing ripgrep ${RG_VERSION}..."
RG_FILE="ripgrep-${RG_VERSION}-${RG_ARCH}.tar.xz"
RG_URL="https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/${RG_FILE}"
curl -fsSLO "$RG_URL"
tar xf "$RG_FILE"
cp "ripgrep-${RG_VERSION}-${RG_ARCH}/rg" /usr/local/bin/
rm -rf "ripgrep-${RG_VERSION}-${RG_ARCH}" "$RG_FILE"
rg --version

# ======================
# ロケール設定
# ======================
if [ "$ID" = "ubuntu" ]; then
  apt install -y language-pack-ja
else
  apt install -y locales
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
# Node.js via nvm
# ======================
if ! command -v node >/dev/null 2>&1; then
  echo "🚀 Installing Node.js (LTS)..."
  export NVM_DIR="$HOME/.nvm"
  mkdir -p "$NVM_DIR"
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
  . "$NVM_DIR/nvm.sh"
  nvm install --lts
  nvm alias default 'lts/*'
fi
node -v

# ======================
# Neovim ビルド
# ======================
cd ~
if [ ! -d "neovim" ]; then
  git clone --depth=1 https://github.com/neovim/neovim.git
fi
cd neovim
make CMAKE_BUILD_TYPE=Release
make install
cd ~

# ======================
# tmux ビルド
# ======================
apt install -y pkg-config libncurses5-dev libncursesw5-dev libevent-dev m4 texinfo autoconf flex
AUTOMAKE_VERSION="1.16.5"
BISON_VERSION="3.8.2"

if ! command -v automake >/dev/null 2>&1; then
  curl -fsSLO "https://ftp.gnu.org/gnu/automake/automake-${AUTOMAKE_VERSION}.tar.gz"
  tar xf automake-${AUTOMAKE_VERSION}.tar.gz
  cd automake-${AUTOMAKE_VERSION} && ./configure && make && make install
  cd .. && rm -rf automake-${AUTOMAKE_VERSION}*
fi

if ! command -v bison >/dev/null 2>&1; then
  curl -fsSLO "https://ftp.gnu.org/gnu/bison/bison-${BISON_VERSION}.tar.gz"
  tar xf bison-${BISON_VERSION}.tar.gz
  cd bison-${BISON_VERSION} && ./configure && make && make install
  cd .. && rm -rf bison-${BISON_VERSION}*
fi

if [ ! -d "tmux" ]; then
  git clone --depth=1 https://github.com/tmux/tmux.git
fi
cd tmux
sh autogen.sh
./configure
make
make install
cd ~

# ======================
# PATH / alias
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
# Stylua (Rust)
# ======================
if ! command -v stylua >/dev/null 2>&1; then
  echo "🚀 Installing Stylua..."
  if ! command -v cargo >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env" || true
    export PATH="$HOME/.cargo/bin:$PATH"
  fi
  cargo install stylua --locked
fi
stylua --version

# ======================
# Prettier
# ======================
if ! command -v prettier >/dev/null 2>&1; then
  npm install -g prettier
fi
prettier --version

# ======================
# Neovim config link
# ======================
mkdir -p "$HOME/.config"
ln -sfn "$HOME/dotfiles/nvim" "$HOME/.config/nvim"

echo "✅ Setup complete. Run 'source ~/.bashrc' to apply changes."
