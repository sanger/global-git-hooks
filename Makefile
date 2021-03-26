GIT_SUPPORT_PATH=  ${HOME}/.git-support
HOOKS=${GIT_SUPPORT_PATH}/hooks
PRECOMMIT=${GIT_SUPPORT_PATH}/hooks/pre-commit
PATTERNS=${GIT_SUPPORT_PATH}/gitleaks.toml
GITLEAKS= /usr/local/bin/gitleaks

INSTALL_TARGETS= ${PATTERNS} ${PRECOMMIT} ${GITLEAKS}

.PHONY: clean audit global_hooks

install: $(INSTALL_TARGETS) global_hooks

global_hooks:
	git config --global hooks.gitleaks true
	git config --global core.hooksPath ${GIT_SUPPORT_PATH}/hooks

${PATTERNS}: local.toml ${GIT_SUPPORT_PATH}
	cat $< > $@

${PRECOMMIT}: pre-commit.sh ${HOOKS}
	install -m 0755 -cv $< $@

${GIT_SUPPORT_PATH} ${HOOKS}:
	mkdir -p $@

/usr/local/bin/%:
	brew install $(@F)
