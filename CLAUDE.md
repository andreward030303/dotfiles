# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Dotfiles repository for a Docker-based development environment. Contains a Neovim configuration and an `install.sh` bootstrap script that sets up a full dev environment inside a Docker container (Ubuntu-based).

## Setup

`install.sh` is meant to run inside a Docker container. It:
- Installs system dependencies (ripgrep, fd, tmux, cmake, etc.)
- Sets up ja_JP.UTF-8 locale
- Installs Node.js via nvm, Rust/Cargo, Stylua, Prettier
- Builds Neovim v0.11.4 from source
- Symlinks `nvim/` to `~/.config/nvim` (assumes repo is mounted at `/code/dotfiles/`)

## Neovim Config Architecture

Entry point: `nvim/init.lua` loads modules in order:
1. `config/options.lua` — base Vim options (4-space tabs, no swap, dark background)
2. `config/keymaps.lua` — leader is `<Space>`, custom keybindings (tab navigation with `t`/`f`/`;`, netrw with `<leader>e`)
3. `config/autocmds.lua` — restore cursor position, `*.blade.php` filetype, diagnostics config
4. `config/lazy.lua` — bootstraps lazy.nvim, auto-loads all files under `lua/plugins/`

Plugin specs live in `lua/plugins/`:
- `lsp/init.lua` — Mason + mason-lspconfig + none-ls (null-ls) setup; loads language-specific configs from `lsp/{php,rust,typescript,go,dart,lua}.lua`
- `lsp/common.lua` — shared LSP on_attach/capabilities used by language configs
- `cmp.lua`, `telescope.lua`, `treesitter.lua`, `editor.lua`, `ui.lua`, `colorscheme.lua`

## Formatting

Lua files are formatted with **Stylua** (2-space indent, spaces not tabs — see `nvim/stylua.toml`). Run:
```
stylua nvim/
```

## Key Conventions

- Comments and variable descriptions are in Japanese
- Uses Neovim 0.11+ LSP API (`vim.lsp.config`)
- Plugin manager: lazy.nvim with auto-discovery of `lua/plugins/*.lua`
- LSP servers managed via Mason; formatters via none-ls
- Default colorscheme: tokyonight (storm, transparent)
