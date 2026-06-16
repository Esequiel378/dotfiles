DOTFILES := $(CURDIR)

.PHONY: all zsh tmux kitty nvim claude

all: zsh tmux kitty nvim claude

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
