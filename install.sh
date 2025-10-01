#!/bin/bash

# 必要なパッケージのインストール
apt update
apt install -y \
  wget curl ninja-build gettext cmake unzip build-essential git ripgrep fd-find \
  locales

# fd を fd として使えるようにリンク（fdfind → fd）
if [ ! -e /usr/local/bin/fd ]; then
  ln -s "$(command -v fdfind)" /usr/local/bin/fd
fi

# ======================
# ロケール設定 (ja_JP.UTF-8)
# ======================
. /etc/os-release

if [ "$ID" = "ubuntu" ]; then
  # Ubuntu 系
  apt-get update
  apt-get install -y language-pack-ja
elif [ "$ID" = "debian" ]; then
  # Debian 系
  apt-get update
  apt-get install -y locales
  sed -i '/ja_JP.UTF-8/s/^# //g' /etc/locale.gen
  locale-gen
fi

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
apt install -y git build-essential automake bison pkg-config \
  libevent-dev libncurses5-dev libncursesw5-dev

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
# Neovim 設定リンク
# ======================
mkdir -p ~/.config
ln -sfn "/home/dotfiles/nvim" ~/.config/nvim

echo "✅ Setup complete. Run 'source ~/.bashrc' to apply changes."


