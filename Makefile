#
# ansible-role-mode-el/Makefile ---
#

_default: _precommit

#####
EMACS:=emacs
SHELL:=bash
.SUFFIXES:

#####

_compile_el:
	${EMACS} -Q --batch --eval '(byte-compile-file "./ansible-role-mode.el")'

_tests:
	${EMACS} -Q --batch -l tests.el -f ert-run-tests-batch-and-exit

# not in 24.4.1
_checkdoc:
	${EMACS} --batch --eval "(if (fboundp 'checkdoc-file) (checkdoc-file \"./ansible-role-mode.el\"))"

_precommit: _compile_el _tests _checkdoc
