# Helpers
src() { [[ -r "$1" ]] && source "$1"; }
path_add() {
  [[ -d "$1" ]] || return
  case ":$PATH:" in *":$1:"*) ;; *) PATH="$1:$PATH" ;; esac
}

# Fixes `gpg failed to sign the data fatal`
export GPG_TTY=$(tty)

export LANG=en_US.UTF-8

# Powerlevel10k instant prompt — keep near top.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Brew (arch-aware)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Go
export GOPATH="$HOME/go"
path_add "$GOPATH/bin"
path_add "/usr/local/go/bin"

# Home binaries
path_add "$HOME/.local/bin"
path_add "$HOME/.cargo/bin"

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
    git
    node
    tmux
    zsh-autosuggestions
)
src "$ZSH/oh-my-zsh.sh"

# User configuration
DISABLE_AUTO_TITLE="true"
export EDITOR='nvim'

# True color + italics
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export TERM=xterm-256color

# Aliases
alias ls="lsd -l -hA --group-dirs first -a"
alias stop='docker stop $(docker ps -aq)'
alias claude='claude --allow-dangerously-skip-permissions'

# Headroom — reduce output tokens (verbosity steering + effort routing)
export HEADROOM_OUTPUT_SHAPER=1

# nvm
export NVM_DIR="$HOME/.nvm"
src "$NVM_DIR/nvm.sh"
src "$NVM_DIR/bash_completion"

# powerlevel10k user config (theme itself is loaded via ZSH_THEME above)
src "$HOME/.p10k.zsh"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
path_add "$PNPM_HOME"

# curl (brew override — only if installed)
if [[ -d /opt/homebrew/opt/curl ]]; then
  path_add /opt/homebrew/opt/curl/bin
  export PKG_CONFIG_PATH="/opt/homebrew/opt/curl/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
  export CPPFLAGS="-I/opt/homebrew/opt/curl/include"
  export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
fi

# zsh completion
fpath+=~/.zfunc
autoload -Uz compinit && compinit -C

# Local, uncommitted overrides (secrets, machine-specific tweaks)
src "$HOME/.zshrc.local"
