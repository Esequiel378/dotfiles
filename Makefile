DOTFILES := $(CURDIR)
OMZ := $(HOME)/.oh-my-zsh

.PHONY: all install zsh tmux kitty nvim claude git serena linear headroom macos keyswap keyswap-undo
.SILENT:

# Colour only on a terminal. stderr, because $(shell) captures stdout.
# NO_COLOR turns it off: https://no-color.org
ifeq ($(shell test -t 2 && test -z "$$NO_COLOR" && echo y),y)
  BOLD := \033[1m
  BLUE := \033[1;34m
  GREEN := \033[32m
  YELLOW := \033[33m
  RED := \033[1;31m
  RESET := \033[0m
endif

tilde = $(patsubst $(HOME)/%,~/%,$(1))
step = printf '$(BLUE)==>$(RESET) $(BOLD)%s$(RESET)\n' '$(1)'
ok = printf '  $(GREEN)✓$(RESET) %s\n' '$(call tilde,$(1))'
warn = printf '  $(YELLOW)! %s$(RESET)\n' '$(1)'
# $(3) = n for ln -sfn, which replaces a directory link instead of nesting in it
link = ln -sf$(3) "$(1)" "$(2)" && $(call ok,$(2))
# Hides the command's chatter on success, prints it in red on failure.
# No commas in the command: $(call) splits arguments on them.
run = out=$$($(1) 2>&1) && $(call ok,$(2)) || { printf '  $(RED)✗ %s$(RESET)\n' '$(2)'; printf '%s\n' "$$out" | sed 's/^/    /'; exit 1; }

all: zsh tmux kitty nvim claude git serena linear macos keyswap

# Install all brew packages, casks, and fonts at once (needs Homebrew).
install:
	$(call step,brew bundle)
	brew bundle --file="$(DOTFILES)/Brewfile"

zsh: $(OMZ) $(OMZ)/custom/themes/powerlevel10k $(OMZ)/custom/plugins/zsh-autosuggestions
	$(call step,zsh)
	$(call link,$(DOTFILES)/zsh/.zshrc,$(HOME)/.zshrc)
	$(call link,$(DOTFILES)/zsh/.zshenv,$(HOME)/.zshenv)
	$(call link,$(DOTFILES)/zsh/.p10k.zsh,$(HOME)/.p10k.zsh)

# .zshrc loads the theme and the plugin through oh-my-zsh, and these are the
# paths it looks in. directory targets, so make skips a clone that is already
# there and `make zsh` stays re-runnable
$(OMZ):
	$(call step,clone oh-my-zsh)
	$(call run,git clone -q --depth 1 https://github.com/ohmyzsh/ohmyzsh.git $@,$@)

$(OMZ)/custom/themes/powerlevel10k: | $(OMZ)
	$(call step,clone powerlevel10k)
	$(call run,git clone -q --depth 1 https://github.com/romkatv/powerlevel10k.git $@,$@)

$(OMZ)/custom/plugins/zsh-autosuggestions: | $(OMZ)
	$(call step,clone zsh-autosuggestions)
	$(call run,git clone -q --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git $@,$@)

git:
	$(call step,git)
	mkdir -p $(HOME)/.config/git
	$(call link,$(DOTFILES)/git/ignore,$(HOME)/.config/git/ignore)

tmux:
	$(call step,tmux)
	$(call link,$(DOTFILES)/.tmux.conf,$(HOME)/.tmux.conf)

kitty:
	$(call step,kitty)
	mkdir -p $(HOME)/.config/kitty
	$(call link,$(DOTFILES)/kitty/kitty.conf,$(HOME)/.config/kitty/kitty.conf)

nvim:
	$(call step,nvim)
	mkdir -p $(HOME)/.config
	$(call link,$(DOTFILES)/nvim,$(HOME)/.config/nvim,n)

# Also runs without make on Windows: `bash claude/install.sh` from Git Bash.
claude:
	$(call step,claude)
	"$(DOTFILES)/claude/install.sh"

# Register the Serena coding-agent toolkit as a user-scope MCP server (needs uv).
# Re-runnable: the remove fails when it isn't registered yet, and that's fine.
serena:
	$(call step,serena mcp)
	claude mcp remove serena -s user >/dev/null 2>&1 || true
	$(call run,claude mcp add serena -s user -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --project-from-cwd --context claude-code --open-web-dashboard False,serena (user scope))

# Register Linear's hosted MCP server (user scope, HTTP transport). Re-runnable.
linear:
	$(call step,linear mcp)
	claude mcp remove linear-server -s user >/dev/null 2>&1 || true
	$(call run,claude mcp add --transport http linear-server https://mcp.linear.app/mcp -s user,linear-server (user scope))

# Install Headroom (context compressor) for the `claude-wrap` alias in .zshrc.
# Bootstraps its own deps so it works without a full `make install`. --force makes it re-runnable.
headroom:
	$(call step,headroom)
	brew install pipx python@3.13
	pipx install --force --python python3.13 "headroom-ai[all]"

# Fast key repeat.
macos:
	$(call step,macos)
	$(call run,defaults write -g KeyRepeat -int 2,KeyRepeat 2)
	$(call run,defaults write -g InitialKeyRepeat -int 15,InitialKeyRepeat 15)
	$(call run,defaults write -g ApplePressAndHoldEnabled -bool false,ApplePressAndHoldEnabled false)
	$(call warn,log out and back in for key repeat to take effect)

# Swap left Ctrl <-> Fn. LaunchAgent reapplies the hidutil mapping at every login
# (hidutil mappings are otherwise lost on reboot). Takes effect immediately.
keyswap:
	$(call step,keyswap)
	mkdir -p $(HOME)/Library/LaunchAgents
	$(call link,$(DOTFILES)/macos/keyswap.plist,$(HOME)/Library/LaunchAgents/com.dotfiles.keyswap.plist)
	launchctl unload $(HOME)/Library/LaunchAgents/com.dotfiles.keyswap.plist 2>/dev/null || true
	$(call run,launchctl load $(HOME)/Library/LaunchAgents/com.dotfiles.keyswap.plist,LaunchAgent loaded)

# Undo the swap: stop the LaunchAgent and reset hidutil to defaults. Takes effect immediately.
keyswap-undo:
	$(call step,keyswap-undo)
	launchctl unload $(HOME)/Library/LaunchAgents/com.dotfiles.keyswap.plist 2>/dev/null || true
	rm -f $(HOME)/Library/LaunchAgents/com.dotfiles.keyswap.plist
	$(call run,hidutil property --set '{"UserKeyMapping":[]}',key mapping reset)
