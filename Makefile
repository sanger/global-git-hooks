GIT_SUPPORT_PATH=  ${HOME}/.git-support
HOOKS=${GIT_SUPPORT_PATH}/hooks
PRECOMMIT=${GIT_SUPPORT_PATH}/hooks/pre-commit
PREPUSH=${GIT_SUPPORT_PATH}/hooks/pre-push

INSTALL_TARGETS= ${PRECOMMIT} ${PREPUSH}

.PHONY: global_hooks

install: $(INSTALL_TARGETS) global_hooks

global_hooks:
	git config --global core.hooksPath ${GIT_SUPPORT_PATH}/hooks

${PRECOMMIT}: pre-commit.sh ${HOOKS}
	install -m 0755 -cv $< $@

${PREPUSH}: pre-push.sh ${HOOKS}
	install -m 0755 -cv $< $@

${GIT_SUPPORT_PATH} ${HOOKS}:
	mkdir -p $@
