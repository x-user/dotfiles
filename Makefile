SHELL = /bin/bash
PACKAGES=$(patsubst packages/%/,%,$(filter %/, $(wildcard packages/*/)))

default: help

.PHONY: packages
packages: ## list all packages
	@echo $(PACKAGES)

.PHONY: command-%
command-%:
	$(if $(shell command -v "$*"),,$(error "ERROR: '$*' command not found"))

.PHONY: update-submodules
update-submodules: command-git ## update submodules
	@git submodule update --init --recursive --remote

.PHONY: install
install: $(addprefix install-,$(PACKAGES)) ## install all config packages

.PHONY: uninstall
uninstall: $(addprefix uninstall-,$(PACKAGES)) ## uninstall all config packages

.PHONY: install-%
install-%: command-stow update-submodules packages/%/ ## install configs package by name, ex: install-git
	@stow -v -t "$$HOME" -d packages -R '$*'

.PHONY: uninstall-%
uninstall-%: command-stow update-submodules packages/%/ ## uninstall configs package by name, ex: uninstall-git
	@stow -v -t "$$HOME" -d packages -D '$*'

.PHONY: help
help: ## show this help
	@awk -F':.*## ' '/^[a-zA-Z_%-]+:.*## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' '$(MAKEFILE_LIST)'
