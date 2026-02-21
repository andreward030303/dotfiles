#!/bin/bash
#set -euo pipefail
#trap 'echo "❌ Error on line $LINENO: $BASH_COMMAND" >&2' ERR

export DEBIAN_FRONTEND=noninteractive
ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

. /etc/os-release

is_ubuntu_like() {
  [ "${ID:-}" = "ubuntu" ] || echo "${ID_LIKE:-}" | grep -qiE 'debian|ubuntu'
}
is_amzn2023() {
  [ "${ID:-}" = "amzn" ] && [ "${VERSION_ID:-}" = "2023" ]
}

# ======================
# 必要なパッケージのインストール
# ======================
if is_ubuntu_like; then
  # ---- Ubuntu: 元の挙動そのまま ----
  apt update
  apt install -y \
    wget curl ninja-build gettext cmake unzip build-essential git ripgrep fd-find tmux\
    locales
elif is_amzn2023; then
  # ---- Amazon Linux 2023: dnf で代替 ----
  dnf -y makecache
  dnf -y install \
    wget curl ninja-build gettext cmake unzip git ripgrep tmux \
    glibc-langpack-ja \
    gcc gcc-c++ make \
    fd-find
else
  echo "Unsupported OS: ID=${ID} VERSION_ID=${VERSION_ID} ID_LIKE=${ID_LIKE}" >&2
  exit 1
fi

# fd-find は Ubuntu だと fdfind という名前になる → fd として使えるようにシンボリックリンク
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  ln -sf "$(which fdfind)" /usr/local/bin/fd
fi

# ======================
# ロケール設定 (ja_JP.UTF-8)
# ======================

# Ubuntu 系
if is_ubuntu_like; then
  # ---- Ubuntu: 元の挙動そのまま ----
  apt-get update
  apt-get install -y language-pack-ja

  update-locale LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8
elif is_amzn2023; then
  # ---- Amazon Linux 2023: 相当処理 ----
  # glibc-langpack-ja は上で入れてる想定。念のため locale を system-wide へ。
  localectl set-locale LANG=ja_JP.UTF-8
  # Ubuntu の update-locale で LC_ALL も設定してるので、AL2023でも近づける
  if [ -w /etc/locale.conf ]; then
    # 既存を壊したくないなら追記ではなく置換が近い（update-locale相当）
    # ただし既に他の設定がある環境では上書きになる点に注意
    cat > /etc/locale.conf <<'EOF'
LANG=ja_JP.UTF-8
LC_ALL=ja_JP.UTF-8
EOF
  fi
fi

# .bashrc に LANG/LC_ALL を追加して永続化（ここは元のまま）
if ! grep -q "ja_JP.UTF-8" "$HOME/.bashrc"; then
  cat <<'EOF' >> "$HOME/.bashrc"

# locale
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
EOF
fi

# ======================
# Node.js (nvm 経由)
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
  nvm use --lts
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
# Neovim 関連 PATH / alias
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
# Stylua (Rust/Cargo ビルド)
# ======================
if ! command -v stylua >/dev/null 2>&1; then
  echo "🚀 Installing Stylua from source..."
  # Rust がなければインストール
  if ! command -v cargo >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    export PATH="$HOME/.cargo/bin:$PATH"
    if ! grep -q ".cargo/bin" "$HOME/.bashrc"; then
      echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "$HOME/.bashrc"
    fi
  fi
  cargo install stylua --locked
  echo "✅ Stylua installed: $(which stylua)"
  stylua --version
fi

# ======================
# Prettier (npm 経由)
# ======================
if ! command -v prettier >/dev/null 2>&1; then
  echo "🚀 Installing Prettier (via npm)..."
  npm install -g prettier
  echo "✅ Prettier installed: $(which prettier)"
  prettier --version
fi

# ======================
# Neovim 設定リンク
# ======================
mkdir -p ~/.config
ln -sfn "/home/dotfiles/nvim" ~/.config/nvim

echo "✅ Setup complete. Run 'source ~/.bashrc' to apply changes."


