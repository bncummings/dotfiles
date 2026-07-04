SHELL := /bin/bash
DOTFILES_DIR := $(shell pwd)
OS := $(shell uname -s)
XDG_CONFIG_HOME ?= $(HOME)/.config

.PHONY: all clean help install bash git ghostty

all: bash git ghostty

install:
	@if [ "$(OS)" = "Darwin" ]; then \
		brew bundle --file=$(DOTFILES_DIR)/Brewfile; \
	elif [ "$(OS)" = "Linux" ]; then \
		sudo apt-get update; \
		xargs -a $(DOTFILES_DIR)/Aptfile sudo apt-get install -y; \
	else \
		echo "Unsupported OS"; \
	fi

bash:
	ln -sfn $(DOTFILES_DIR)/bash/.bashrc $(HOME)/.bashrc
	ln -sfn $(DOTFILES_DIR)/bash/.bash_profile $(HOME)/.bash_profile

ghostty:
	ln -sfn $(DOTFILES_DIR)/ghostty/config $(XDG_CONFIG_HOME)/ghostty/config
	
git:
	ln -sfn $(DOTFILES_DIR)/git/gitconfig $(HOME)/.gitconfig

clean:
	rm -f $(HOME)/.bashrc $(HOME)/.bash_profile $(HOME)/.gitconfig $(HOME)/.tmux.conf
	rm -f $(XDG_CONFIG_HOME)/ghostty/config

verify:
	echo LINUX_BASH_PROFILE_LOADED: $$LINUX_BASH_PROFILE_LOADED
	echo MACOS_BASH_PROFILE_LOADED: $$MACOS_BASH_PROFILE_LOADED
	echo BASH_RC_LOADED: $$BASH_RC_LOADED

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all      - Link all configurations (default)"
	@echo "  install  - Install packages (uses Brewfile on macOS, Aptfile on Linux)"
	@echo "  bash     - Link bash files"
	@echo "  git      - Link git configuration"
	@echo "  tmux     - Link tmux configuration"
	@echo "  clean    - Remove symlinks"
