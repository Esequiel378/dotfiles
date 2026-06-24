DOTFILES := $(CURDIR)

.PHONY: all zsh tmux kitty nvim claude macos keyswap keyswap-undo

all: zsh tmux kitty nvim claude macos keyswap

zsh:
	ln -sf "$(DOTFILES)/zsh/.zshrc"    ~/.zshrc
	ln -sf "$(DOTFILES)/zsh/.p10k.zsh" ~/.p10k.zsh

tmux:
	ln -sf "$(DOTFILES)/.tmux.conf" ~/.tmux.conf

kitty:
	mkdir -p ~/.config/kitty
	ln -sf "$(DOTFILES)/kitty/kitty.conf" ~/.config/kitty/kitty.conf

nvim:
	ln -sf "$(DOTFILES)/nvim" ~/.config/nvim

claude:
	mkdir -p ~/.claude/hooks
	ln -sf "$(DOTFILES)/claude/settings.json"      ~/.claude/settings.json
	ln -sf "$(DOTFILES)/claude/CLAUDE.md"          ~/.claude/CLAUDE.md
	ln -sf "$(DOTFILES)/claude/RTK.md"             ~/.claude/RTK.md
	ln -sf "$(DOTFILES)/claude/hooks/notify.sh"    ~/.claude/hooks/notify.sh
	ln -sf "$(DOTFILES)/claude/hooks/statusline.sh" ~/.claude/hooks/statusline.sh

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
