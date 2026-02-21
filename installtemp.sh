#!/bin/bash
#set -euo pipefail
#trap 'echo "❌ Error on line $LINENO: $BASH_COMMAND" >&2' ERR

export DEBIAN_FRONTEND=noninteractive

. /etc/os-release

is_ubuntu_like() {
  [ "${ID:-}" = "ubuntu" ] || echo "${ID_LIKE:-}" | grep -qiE 'debian|ubuntu'
}
is_amzn2023() {
  [ "${ID:-}" = "amzn" ] && [ "${VERSION_ID:-}" = "2023" ]
}

# Amazon Linux 2023 の時だけ sudo を使う（Ubuntu の挙動は変えない）
_sudo() {
  if is_amzn2023; then
    sudo "$@"
  else
    "$@"
  fi
}

# --- AL2023: sudo前提を満たさないなら即終了（静かに壊れない） ---
if is_amzn2023; then
  if ! command -v sudo >/dev/null 2>&1; then
    echo "❌ sudo が見つかりません。AL2023ではroot権限が必要です。" >&2
    exit 1
  fi
  if ! sudo -n true 2>/dev/null; then
    echo "❌ AL2023では sudo が必要ですが、このユーザは sudo を実行できません。" >&2
    echo "   対処: ec2-userで実行 / sudo権限付与 / rootで実行" >&2
    exit 1
  fi
fi

# タイムゾーン
_sudo ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

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
  # ---- Amazon Linux 2023: dnf で代替（必ずsudo） ----
  _sudo dnf -y makecache

  # まずは基本セットを入れる（失敗しても後で補完する）
  if ! _sudo dnf -y install \
      wget curl ninja-build gettext cmake unzip git ripgrep tmux \
      glibc-langpack-ja \
      gcc gcc-c++ make \
      ; then
    echo "⚠️ dnf install (base) failed. Retrying makecache..." >&2
    _sudo dnf -y makecache
    _sudo dnf -y install gcc gcc-c++ make glibc-langpack-ja || true
  fi

  # fd を確実に入れる（環境により fd-find / fd の揺れを吸収）
  if ! command -v fd >/dev/null 2>&1 && ! command -v fdfind >/dev/null 2>&1; then
    _sudo dnf -y install fd-find || _sudo dnf -y install fd || true
  fi

  # cc を確実に用意（styluaビルドに必須）
  if ! command -v cc >/dev/null 2>&1; then
    _sudo dnf -y install gcc gcc-c++ make
  fi
  if ! command -v cc >/dev/null 2>&1; then
    echo "❌ linker 'cc' が見つかりません。gcc導入に失敗しました。" >&2
    echo "   手動で: sudo dnf -y install gcc gcc-c++ make" >&2
    exit 1
  fi
else
  echo "Unsupported OS: ID=${ID} VERSION_ID=${VERSION_ID} ID_LIKE=${ID_LIKE}" >&2
  exit 1
fi

# fd-find は Ubuntu だと fdfind という名前になる → fd として使えるようにシンボリックリンク
# /usr/local/bin は AL2023 では root 必要なので sudo。Ubuntu は元挙動のまま。
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  _sudo ln -sf "$(which fdfind)" /usr/local/bin/fd
fi

# ======================
# ロケール設定 (ja_JP.UTF-8)
# ======================
if is_ubuntu_like; then
  # ---- Ubuntu: 元の挙動そのまま ----
  apt-get update
  apt-get install -y language-pack-ja

  update-locale LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8

elif is_amzn2023; then
  # ---- Amazon Linux 2023: 相当処理（必ずsudo） ----
  _sudo localectl set-locale LANG=ja_JP.UTF-8

  # update-locale 相当として /etc/locale.conf を確実に設定
  _sudo tee /etc/locale.conf >/dev/null <<'EOF'
LANG=ja_JP.UTF-8
LC_ALL=ja_JP.UTF-8
EOF

  # 念のため locale が存在するか（通常 glibc-langpack-ja でOK）
  if ! locale -a 2>/dev/null | grep -qi '^ja_JP\.utf8$'; then
    _sudo localedef -i ja_JP -f UTF-8 ja_JP.UTF-8 >/dev/null 2>&1 || true
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
_sudo make install
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

  # AL2023は cc 必須
  if is_amzn2023 && ! command -v cc >/dev/null 2>&1; then
    echo "❌ linker 'cc' が見つかりません（gcc未導入）。" >&2
    echo "   実行: sudo dnf -y install gcc gcc-c++ make" >&2
    exit 1
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



