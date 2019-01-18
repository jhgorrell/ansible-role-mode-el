#
# ansible-role-mode-el/Makefile ---
#

_default: _precommit

#####
EMACS:=emacs
SHELL:=bash
.SUFFIXES:

#####

_emacs_version:
	emacs --version

#####

_rm_elc:
	-rm -f *.elc

_cask_build:
	cask build

_cask_install:
	cask install

_cask_update:
	cask update

_tests:
	cask exec ${EMACS} --script tests.el

# not in 24.4.1
_checkdoc:
	cask exec ${EMACS} --batch --eval "(if (fboundp 'checkdoc-file) (checkdoc-file \"./ansible-role-mode.el\"))"

#####

_precommit: _rm_elc _cask_build _tests _checkdoc
