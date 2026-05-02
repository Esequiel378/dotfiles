# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using Lazy.nvim for plugin management. The configuration is modular, with plugins organized into separate files under `lua/plugins/`.

## Architecture

```
init.lua              # Entry point, bootstraps Lazy.nvim
lua/
  option.lua          # Vim options (leader=Space, 2-space indent, relative numbers)
  keymaps.lua         # Global keybindings
  autocmd.lua         # Autocommands (yank highlight, cursor restore, etc.)
  plugins/            # Plugin specs (one concern per file)
    lsp.lua           # LSP + Mason configuration
    completion.lua    # blink.cmp completion
    telescope.lua     # Fuzzy finder
    treesitter.lua    # Syntax/parsing
    git.lua           # fugitive + gitsigns
    go.lua            # Go tooling (go.nvim, coverage)
    editor.lua        # Theme, surround, comment, venv-selector
    oil.lua           # File explorer
    daddob.lua        # Database client
lazy-lock.json        # Plugin version lock file
```

## Key Patterns

- **Plugin specs**: Each file in `lua/plugins/` returns a table of Lazy.nvim plugin specs
- **LSP keymaps**: Attached via `LspAttach` autocmd in `lsp.lua`
- **Augroup helper**: `Augroup(name)` function in `autocmd.lua` creates groups prefixed with "nde_"

## Installed Language Servers

Managed by Mason, auto-installed: `lua_ls`, `pyright`, `ruff`, `typescript-language-server`, `gopls`, `golangci-lint`, `eslint-lsp`, `html-lsp`, `css-lsp`, `tailwindcss-language-server`, `svelte-language-server`, `dockerfile-language-server`, `docker-compose-language-service`

## Important Keymaps

| Key | Mode | Action |
|-----|------|--------|
| `<Space>` | - | Leader key |
| `gd` | n | Go to definition |
| `gr` | n | Go to references |
| `gi` | n | Go to implementation |
| `<leader>rn` | n | Rename symbol |
| `<leader>ca` | n | Code action |
| `<leader>sf` | n | Find files |
| `<leader>sg` | n | Live grep |
| `<leader>gs` | n | Git status (fugitive) |
| `-` | n | Open parent dir (oil) |

## Build Requirements

- Nerd font for icons
- `git` and `make` (for telescope-fzf-native compilation)
