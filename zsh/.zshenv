# non-interactive shells (ssh host cmd, Orca SSH agents) never read .zshrc
[[ -o interactive ]] && return
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"
