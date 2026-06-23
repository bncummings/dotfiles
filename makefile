SHELL := /bin/bash
DOTFILES_DIR := $(shell pwd)
XDG_CONFIG_HOME ?= $(HOME)/.config

.PHONY: all clean help

all: bash git tmux ghostty

bash:
	ln -sfn $(DOTFILES_DIR)/bash/bashrc $(HOME)/.bashrc
	ln -sfn $(DOTFILES_DIR)/bash/bash_profile $(HOME)/.bash_profile

ghostty:
	ln -sfn $(DOTFILES_DIR)/ghostty/config $(XDG_CONFIG_HOME)/ghostty/config
	
git:
	ln -sfn $(DOTFILES_DIR)/git/gitconfig $(HOME)/.gitconfig

tmux:
	ln -sfn $(DOTFILES_DIR)/tmux/tmux.conf $(HOME)/.tmux.conf

clean:
	rm -f $(HOME)/.bashrc $(HOME)/.bash_profile $(HOME)/.gitconfig $(HOME)/.tmux.conf
	rm -f $(XDG_CONFIG_HOME)/ghostty/config

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all      - Link all configurations (default)"
	@echo "  bash     - Link bash files"
	@echo "  git      - Link git configuration"
	@echo "  tmux     - Link tmux configuration"
	@echo "  clean    - Remove symlinks"
