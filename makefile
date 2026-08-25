SHELL := /bin/bash
DOTFILES_DIR := $(shell pwd)
OS := $(shell uname -s)
XDG_CONFIG_HOME ?= $(HOME)/.config

.PHONY: all help install apt-install brew-install bash git ghostty claude vscode

ifeq ($(OS),Darwin)
VSCODE_USER_DIR := $(HOME)/Library/Application Support/Code/User
else
VSCODE_USER_DIR := $(XDG_CONFIG_HOME)/Code/User
endif

all: install bash git ghostty claude vscode verify done

install:
	-@if [ "$(OS)" = "Darwin" ]; then \
		$(MAKE) brew-install; \
	elif [ "$(OS)" = "Linux" ]; then \
		$(MAKE) apt-install; \
	else \
		echo "Unsupported OS"; \
	fi

brew-install:
	-brew install git tmux bash gcc
	-brew install --cask temurin@21 temurin@17

apt-install:
	-sudo bash -c 'apt-get update && apt-get install -y git tmux bash net-tools'

bash:
	rm -f $(HOME)/.bashrc
	ln -sfn $(DOTFILES_DIR)/common/bash/.bashrc $(HOME)/.bashrc
	rm -f $(HOME)/.bash_profile
	ln -sfn $(DOTFILES_DIR)/common/bash/.bash_profile $(HOME)/.bash_profile

ghostty:
	rm -f $(XDG_CONFIG_HOME)/ghostty/config
	ln -sfn $(DOTFILES_DIR)/common/ghostty/config $(XDG_CONFIG_HOME)/ghostty/config

git:
	rm -f $(HOME)/.gitconfig
	ln -sfn $(DOTFILES_DIR)/common/git/gitconfig $(HOME)/.gitconfig

claude:
	rm -f $(HOME)/.claude/settings.json
	ln -sfn $(DOTFILES_DIR)/.claude/settings.json $(HOME)/.claude/settings.json

vscode:
	mkdir -p "$(VSCODE_USER_DIR)"
	rm -f "$(VSCODE_USER_DIR)/settings.json"
	ln -sfn $(DOTFILES_DIR)/common/vscode/settings.json "$(VSCODE_USER_DIR)/settings.json"

verify:
	@[ -n "$$LINUX_BASH_PROFILE_LOADED" ] && printf "Linux Bash Profile Loaded Succesfully\n" || true
	@[ -n "$$MACOS_BASH_PROFILE_LOADED" ] && printf "MacOS Bash Profile Loaded Succesfully\n" || true
	@[ -n "$$BASH_RC_LOADED" ]			  && printf "Bash RC Loaded Succesfully\n" 			  || true

done: 
	@echo "Done :P"

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all           - Install packages and link all configurations (default)"
	@echo "  install       - Install packages (dispatches to brew-install or apt-install)"
	@echo "  brew-install  - Install packages via brew (macOS)"
	@echo "  apt-install   - Install packages via apt-get (Linux)"
	@echo "  bash          - Link bash files"
	@echo "  git           - Link git configuration"
	@echo "  ghostty       - Link ghostty configuration"
	@echo "  claude        - Link Claude settings"
	@echo "  vscode        - Link VSCode settings"
