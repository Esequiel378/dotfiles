# This fixes the the problem `gpg failed to sign the data fatal`
export GPG_TTY=$(tty)

# Add go to path
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# Add home binaries to path
export PATH=$PATH:$HOME/.local/bin

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    node
    tmux
    zsh-autosuggestions
)

# User configuration

# Set default editor to nvim
export EDITOR='nvim'

# Enabled true color support for terminals
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias ls="lsd -l -hA --group-dirs first"

# Load `.profile` config if exists
[[ ! -f ~/.profile ]] || source ~/.profile

