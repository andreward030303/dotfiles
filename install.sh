#!/bin/bash

# 必要なパッケージのインストール
apt update
apt install -y \
  wget curl ninja-build gettext cmake unzip build-essential git ripgrep fd-find neovim tmux\
  locales

# ======================
# 最新版 fd & ripgrep インストール
# ======================
FD_VERSION=9.0.0
RG_VERSION=14.1.0

echo "🚀 Installing fd ${FD_VERSION}..."
curl -L "https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
  | tar xz
cp -f "fd-v${FD_VERSION}-x86_64-unknown-linux-gnu/fd" /usr/local/bin/
rm -rf "fd-v${FD_VERSION}-x86_64-unknown-linux-gnu"

echo "🚀 Installing ripgrep ${RG_VERSION}..."
curl -L "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz" \
  | tar xz
cp -f "ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg" /usr/local/bin/
rm -rf "ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl"

fd --version
rg --version

# fd を fd として使えるようにリンク（fdfind → fd）
if [ ! -e /usr/local/bin/fd ]; then
  ln -s "$(command -v fdfind)" /usr/local/bin/fd
fi

# ======================
# ロケール設定 (ja_JP.UTF-8)
# ======================
. /etc/os-release

# Ubuntu 系
apt-get update
apt-get install -y language-pack-ja

update-locale LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8

# .bashrc に LANG/LC_ALL を追加して永続化
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

