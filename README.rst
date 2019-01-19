ansible-role-mode-el/README
==================================================

.. image::  https://melpa.org/packages/ansible-role-mode.svg
   :target: https://melpa.org/#/ansible-role-mode

.. image::  https://travis-ci.org/jhgorrell/ansible-role-mode-el.svg?branch=master
   :target: https://travis-ci.org/jhgorrell/ansible-role-mode-el

Provides a minor mode for use with ansible roles.

yaml-mode does and ok job for editing the file.
``ansible-role-mode`` helps navigate between the files,
which all seemed to be named ``main.yml``.

Keybindings:

::

    "\C-cT"  ansible-role-mode-dired-templates
    "\C-cd"  ansible-role-mode-edit-defaults-main-yml
    "\C-cf"  ansible-role-mode-dired
    "\C-ct"  ansible-role-mode-edit-tasks-main-yml

You may also want to bind ``ansible-role-mode-dired`` to a function key.

::

    (global-set-key [f9] 'ansible-role-mode-dired)


Quickstart:
----------------------------------------

::

    git clone git@github.com:jhgorrell/ansible-role-mode-el.git
    cd ansible-role-mode-el
    make


Links:
----------------------------------------

- Github: https://github.com/jhgorrell/ansible-role-mode-el
- Travis: https://travis-ci.org/jhgorrell/ansible-role-mode-el
- Melpa: https://melpa.org/#/ansible-role-mode
