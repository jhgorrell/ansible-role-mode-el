#
# ansible-role-mode-el/Makefile ---
#

SHELL:=bash
.SUFFIXES:

_default: _precommit

#####

_compile_el:
	emacs --batch --eval '(byte-compile-file "./ansible-role-mode.el")'

_checkdoc:
	emacs --batch --eval '(checkdoc-file "./ansible-role-mode.el")'

_precommit: _compile_el _checkdoc
