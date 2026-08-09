SHELL := /bin/bash
DOTFILES_DIR := $(shell pwd)
OS := $(shell uname -s)
XDG_CONFIG_HOME ?= $(HOME)/.config

.PHONY: all help install install-macos install-linux bash git ghostty claude

all: install bash git ghostty claude verify done

install:
	@if [ "$(OS)" = "Darwin" ]; then \
		$(MAKE) install-macos; \
	elif [ "$(OS)" = "Linux" ]; then \
		$(MAKE) install-linux; \
	else \
		echo "Unsupported OS"; \
	fi

install-macos:
	brew install git tmux bash

install-linux:
	sudo bash -c 'apt-get update && apt-get install -y git tmux bash net-tools'

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

verify:
	@[ -n "$$LINUX_BASH_PROFILE_LOADED" ] && printf "Linux Bash Profile Loaded Succesfully\n" || true
	@[ -n "$$MACOS_BASH_PROFILE_LOADED" ] && printf "MacOS Bash Profile Loaded Succesfully\n" || true
	@[ -n "$$BASH_RC_LOADED" ]			  && printf "Bash RC Loaded Succesfully\n" 			  || true

done: 
	@echo "Done :P"

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all      - Link all configurations (default)"
	@echo "  install  - Install packages (dispatches to install-macos or install-linux)"
	@echo "  install-macos - Install packages via brew"
	@echo "  install-linux - Install packages via apt-get"
	@echo "  bash     - Link bash files"
	@echo "  git      - Link git configuration"
	@echo "  tmux     - Link tmux configuration"
