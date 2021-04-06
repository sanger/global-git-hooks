GIT_SUPPORT_PATH=  ${HOME}/.git-support
HOOKS=${GIT_SUPPORT_PATH}/hooks
PRECOMMIT=${GIT_SUPPORT_PATH}/hooks/pre-commit
PREPUSH=${GIT_SUPPORT_PATH}/hooks/pre-push

INSTALL_TARGETS= ${PRECOMMIT} ${PREPUSH}

.PHONY: global_hooks talisman_install

install: $(INSTALL_TARGETS) global_hooks talisman_install

global_hooks:
	git config --global core.hooksPath ${GIT_SUPPORT_PATH}/hooks

${PRECOMMIT}: pre-commit.sh ${HOOKS}
	install -m 0755 -cv $< $@

${PREPUSH}: pre-push.sh ${HOOKS}
	install -m 0755 -cv $< $@

${GIT_SUPPORT_PATH} ${HOOKS}:
	mkdir -p $@

# TODO: can we get it to answer the prompt with 'dummy-folder' automatically?
# TODO: and automatically respond 'No' to interactive mode
# TODO: let it ask for user input when it asks where to add the $PATH / bash profile stuff
# TODO: delete the global git template it creates (~/.git-template/hooks/pre-commit), but only if it's a talisman one
talisman_install:
	@echo "talisman_install"
	mkdir dummy-folder
	@echo "****************************************************************************************************************************"
	@echo "When the installation asks 'Please enter root directory to search for git repos', enter dummy-folder"
	@echo "When the installation asks whether to install interactive mode, choose no"
	@echo "****************************************************************************************************************************"
	curl --silent  https://raw.githubusercontent.com/thoughtworks/talisman/master/global_install_scripts/install.bash > /tmp/install_talisman.bash && /bin/bash /tmp/install_talisman.bash
	rmdir dummy-folder