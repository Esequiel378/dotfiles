# dotfiles

Personal macOS dotfiles for zsh, tmux, kitty, Neovim, Claude Code, and Rectangle.

## Layout

```
.
├── zsh/
│   ├── .zshrc          # symlink target for ~/.zshrc
│   └── .p10k.zsh       # symlink target for ~/.p10k.zsh
├── .tmux.conf          # symlink target for ~/.tmux.conf
├── kitty/
│   └── kitty.conf      # symlink target for ~/.config/kitty/kitty.conf
├── nvim/               # symlink target for ~/.config/nvim
├── claude/             # global Claude Code config -> ~/.claude/
│   ├── settings.json   #   model, hooks, enabled plugins
│   ├── CLAUDE.md       #   global instructions (sources RTK.md)
│   ├── RTK.md          #   rtk command reference
│   ├── hooks/notify.sh #   desktop notification hook (Stop/Notification)
│   └── hooks/statusline.sh # status line: dir, git branch, model, ponytail tag
└── RectangleConfig.json # imported via Rectangle's UI
```

## Prerequisites

Install these before linking the configs — the shell, tmux, and editor configs reference them directly and will warn or break without them.

### 1. Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Core packages

```sh
brew install zsh tmux neovim kitty lsd git make gnupg
brew install --cask rectangle
```

| Tool | Used by |
|------|---------|
| `tmux` | `.tmux.conf` |
| `neovim` | `nvim/` config (with Lazy.nvim) |
| `kitty` | `kitty/kitty.conf` |
| `lsd` | `ls` alias in `.zshrc` |
| `gnupg` | `GPG_TTY` export for signed commits |
| `git`, `make` | telescope-fzf-native build inside Neovim |
| `rectangle` | `RectangleConfig.json` |

### 3. JetBrainsMono Nerd Font

Required by `kitty.conf` and the Neovim UI icons.

```sh
brew install --cask font-jetbrains-mono-nerd-font
```

### 4. oh-my-zsh

`.zshrc` sets `export ZSH="$HOME/.oh-my-zsh"` and sources `$ZSH/oh-my-zsh.sh`. Without it, the shell will start but the theme and plugins below won't load.

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

The `plugins=(...)` array in `.zshrc` enables these oh-my-zsh built-ins (no extra install needed): `git`, `node`, `tmux`. They ship with oh-my-zsh itself.

### 5. Powerlevel10k (zsh theme)

`.zshrc` sets `ZSH_THEME="powerlevel10k/powerlevel10k"` and sources `~/.p10k.zsh` (which is symlinked from `zsh/.p10k.zsh` in this repo). The instant-prompt block at the top of `.zshrc` also depends on it.

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

### 6. zsh-autosuggestions

Listed in the `plugins=(...)` array in `.zshrc`. Provides fish-style "ghost text" suggestions from history as you type.

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
```

### 7. zsh completion

`.zshrc` runs `autoload -Uz compinit && compinit -C` and adds `~/.zfunc` to `fpath`. `compinit` is built into zsh — nothing to install — but if you have custom completion functions, drop them in `~/.zfunc`.

### 8. tmux plugin manager (TPM)

`.tmux.conf` ends with `run '~/.tmux/plugins/tpm/tpm'` and uses `tmux-sensible`, `tmux-yank`, `tmux-resurrect`, and `tmux-gruvbox`.

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

After linking the config, install plugins from inside tmux with `prefix + I` (prefix is `Ctrl-a`).

### 9. Node version manager (nvm)

`.zshrc` sources `$HOME/.nvm/nvm.sh`.

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

### Optional

These are referenced in `.zshrc` only when present — install only what you actually use:

- **Go** — `brew install go` (config exports `GOPATH=$HOME/go`)
- **Rust / cargo** — `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
- **pnpm** — `curl -fsSL https://get.pnpm.io/install.sh | sh -`

## Linking the configs

From the repo root, `make` symlinks everything (existing files are overwritten — back them up first):

```sh
make          # link all configs + apply macOS tweaks
make zsh      # or run one group: zsh / tmux / kitty / nvim / claude / macos / keyswap
```

`make macos` sets a fast key repeat (`KeyRepeat 2`, `InitialKeyRepeat 15`, and disables press-and-hold accents). Log out and back in for it to take effect.

`make keyswap` swaps the left **Ctrl** and **Fn** keys. It installs a LaunchAgent (`macos/keyswap.plist`) that reapplies the `hidutil` mapping at every login, since the mapping is otherwise lost on reboot. Takes effect immediately.

The targets just wrap the `ln -sf` commands below if you'd rather run them by hand:

```sh
# zsh
ln -sf "$PWD/zsh/.zshrc"   ~/.zshrc
ln -sf "$PWD/zsh/.p10k.zsh" ~/.p10k.zsh

# tmux
ln -sf "$PWD/.tmux.conf" ~/.tmux.conf

# kitty
mkdir -p ~/.config/kitty
ln -sf "$PWD/kitty/kitty.conf" ~/.config/kitty/kitty.conf

# Neovim
ln -sf "$PWD/nvim" ~/.config/nvim

# Claude Code (global config — link the files, leave runtime state untracked)
mkdir -p ~/.claude/hooks
ln -sf "$PWD/claude/settings.json"   ~/.claude/settings.json
ln -sf "$PWD/claude/CLAUDE.md"       ~/.claude/CLAUDE.md
ln -sf "$PWD/claude/RTK.md"          ~/.claude/RTK.md
ln -sf "$PWD/claude/hooks/notify.sh"     ~/.claude/hooks/notify.sh
ln -sf "$PWD/claude/hooks/statusline.sh" ~/.claude/hooks/statusline.sh
```

`settings.json` references the `rtk` and `ponytail` plugins plus the notify hook;
the rest of `~/.claude/` (cache, sessions, history, plugins) is runtime state and
stays out of the repo.

Back up any pre-existing files first if you want to keep them.

### Rectangle

Open Rectangle → preferences → **Import** → select `RectangleConfig.json`.

## First launch

1. **zsh**: open a new terminal. Powerlevel10k will start its config wizard on first run; settings are written to `~/.p10k.zsh` (already symlinked to this repo, so they'll persist).
2. **tmux**: start `tmux`, then press `Ctrl-a` then `I` to install plugins via TPM.
3. **Neovim**: launch `nvim`. Lazy.nvim bootstraps itself, then installs all plugins listed under `nvim/lua/plugins/`. Mason auto-installs the language servers listed in `nvim/CLAUDE.md`.
4. **kitty**: quit and relaunch so the font and key bindings take effect.

## Notes

- The `tmux` and `kitty` configs include a workaround that maps `Shift+Enter` to `ESC [13;2u` so apps like Claude Code receive a literal newline instead of submitting.
- `kitty.conf` remaps `Ctrl+Shift+6` to `Ctrl+^` for Neovim alternate-buffer switching on Corne keyboards.
- tmux prefix is `Ctrl-a` (not the default `Ctrl-b`).
