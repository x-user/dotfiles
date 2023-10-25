SHELL = /bin/bash
PACKAGES=$(patsubst packages/%/,%,$(filter %/, $(wildcard packages/*/)))

default: help

.PHONY: packages
packages: ## list all packages
	@echo $(PACKAGES)

.PHONY: command-%
command-%:
	$(if $(shell command -v "$*"),,$(error "ERROR: '$*' command not found"))

.PHONY: command-stow install-%
install-%: packages/%/ ## install configs package by name, ex: install-git
	@stow -v -t "$$HOME" -d packages -R '$*'

.PHONY: command-stow uninstall-%
uninstall-%: packages/%/ ## uninstall configs package by name, ex: uninstall-git
	@stow -v -t "$$HOME" -d packages -D '$*'

.PHONY: install
install: $(addprefix install-,$(PACKAGES)) ## install all config packages

.PHONY: uninstall
uninstall: $(addprefix uninstall-,$(PACKAGES)) ## uninstall all config packages

.PHONY: help
help: ## show this help
	@awk -F':.*## ' '/^[a-zA-Z_%-]+:.*## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' '$(MAKEFILE_LIST)'
