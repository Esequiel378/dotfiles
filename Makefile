DOTFILES := $(CURDIR)

.PHONY: all install zsh tmux kitty nvim claude git serena linear headroom macos keyswap keyswap-undo

all: zsh tmux kitty nvim claude git serena linear macos keyswap

# Install all brew packages, casks, and fonts at once (needs Homebrew).
install:
	brew bundle --file="$(DOTFILES)/Brewfile"

zsh:
	ln -sf "$(DOTFILES)/zsh/.zshrc"    ~/.zshrc
	ln -sf "$(DOTFILES)/zsh/.p10k.zsh" ~/.p10k.zsh

git:
	mkdir -p ~/.config/git
	ln -sf "$(DOTFILES)/git/ignore" ~/.config/git/ignore

tmux:
	ln -sf "$(DOTFILES)/.tmux.conf" ~/.tmux.conf

kitty:
	mkdir -p ~/.config/kitty
	ln -sf "$(DOTFILES)/kitty/kitty.conf" ~/.config/kitty/kitty.conf

nvim:
	mkdir -p ~/.config
	ln -sfn "$(DOTFILES)/nvim" ~/.config/nvim

claude:
	mkdir -p ~/.claude/hooks
	ln -sf "$(DOTFILES)/claude/settings.json"      ~/.claude/settings.json
	ln -sf "$(DOTFILES)/claude/CLAUDE.md"          ~/.claude/CLAUDE.md
	ln -sf "$(DOTFILES)/claude/RTK.md"             ~/.claude/RTK.md
	ln -sf "$(DOTFILES)/claude/hooks/notify.sh"    ~/.claude/hooks/notify.sh
	ln -sf "$(DOTFILES)/claude/hooks/statusline.sh" ~/.claude/hooks/statusline.sh

# Register the Serena coding-agent toolkit as a user-scope MCP server (needs uv).
# Re-runnable: the leading '-' ignores the remove failing when it isn't registered yet.
serena:
	-claude mcp remove serena -s user 2>/dev/null
	claude mcp add serena -s user -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --project-from-cwd --context claude-code --open-web-dashboard False

# Register Linear's hosted MCP server (user scope, HTTP transport). Re-runnable.
linear:
	-claude mcp remove linear-server -s user 2>/dev/null
	claude mcp add --transport http linear-server https://mcp.linear.app/mcp -s user

# Install Headroom (context compressor) for the `claude-wrap` alias in .zshrc.
# Bootstraps its own deps so it works without a full `make install`. --force makes it re-runnable.
headroom:
	brew install pipx python@3.13
	pipx install --force --python python3.13 "headroom-ai[all]"

# Fast key repeat. Log out and back in for it to take effect.
macos:
	defaults write -g KeyRepeat -int 2
	defaults write -g InitialKeyRepeat -int 15
	defaults write -g ApplePressAndHoldEnabled -bool false

# Swap left Ctrl <-> Fn. LaunchAgent reapplies the hidutil mapping at every login
# (hidutil mappings are otherwise lost on reboot). Takes effect immediately.
keyswap:
	mkdir -p ~/Library/LaunchAgents
	ln -sf "$(DOTFILES)/macos/keyswap.plist" ~/Library/LaunchAgents/com.dotfiles.keyswap.plist
	launchctl unload ~/Library/LaunchAgents/com.dotfiles.keyswap.plist 2>/dev/null || true
	launchctl load ~/Library/LaunchAgents/com.dotfiles.keyswap.plist

# Undo the swap: stop the LaunchAgent and reset hidutil to defaults. Takes effect immediately.
keyswap-undo:
	launchctl unload ~/Library/LaunchAgents/com.dotfiles.keyswap.plist 2>/dev/null || true
	rm -f ~/Library/LaunchAgents/com.dotfiles.keyswap.plist
	hidutil property --set '{"UserKeyMapping":[]}'
