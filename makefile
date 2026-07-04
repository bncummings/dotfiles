SHELL := /bin/bash
DOTFILES_DIR := $(shell pwd)
OS := $(shell uname -s)
XDG_CONFIG_HOME ?= $(HOME)/.config

.PHONY: all clean help install bash git ghostty

all: bash git ghostty done

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
	@rm -f $(HOME)/.bashrc $(HOME)/.bash_profile $(HOME)/.gitconfig $(HOME)/.tmux.conf
	@rm -f $(XDG_CONFIG_HOME)/ghostty/config

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
	@echo "  install  - Install packages (uses Brewfile on macOS, Aptfile on Linux)"
	@echo "  bash     - Link bash files"
	@echo "  git      - Link git configuration"
	@echo "  tmux     - Link tmux configuration"
	@echo "  clean    - Remove symlinks"
