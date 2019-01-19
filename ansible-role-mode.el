;;; ansible-role-mode.el --- helps edit an ansible role. -*- lexical-binding: t -*-
;;
;; ansible-role-mode-el/ansible-role-mode.el ---
;;
;; Author:      Harley Gorrell <harley@panix.com>
;; Homepage:    https://github.com/jhgorrell/ansible-role-mode-el
;; Keywords:    ansible roles
;; License:     GPL-v3
;; Melpa:       https://melpa.org/#/ansible-role-mode
;; Version:     0.0.1
;; Package-Requires: ((f) (s))

;;; Commentary:
;;
;; (autoload 'ansible-role-mode "ansible-role-mode" t)
;;
;;
;; not really, but needed for the hook.
;; (require 'yaml-mode)

;;; Code:

(require 'f)
(require 's)

;;;;;

(defvar ansible-role-mode-lighter
  " ARM"
  "What to show in the mode line when active.")

(defvar ansible-role-mode-add-yaml-mode-hook t
  "Automaticly add a hook to enable variable ‘ansible-role-mode’ to ‘yaml-mode’.")

;;;;;

(defun ansible-role-mode-find-top (&optional path)
  "Find the top of the role directory starting from PATH.
The role dir has a 'tasks' directory and is at most two above PATH."
  (let ((path (or path default-directory)))
    (let ((role-top
           (cond
            ((f-directory-p (f-join path "tasks"))
             path)
            ((f-directory-p (f-join path "../tasks"))
             (f-join path ".."))
            ((f-directory-p (f-join path "../../tasks"))
             (f-join path ".." ".."))
            (t
             nil))))
      (if role-top
        (expand-file-name role-top)))))

;; (let ((default-directory test-role-path)) (ansible-role-mode-find-top))

(defun ansible-role-mode-include-file-p (path)
  "Return t if PATH should be included in the list of role files."
  (cond
   ((s-suffix? "~" path)
    nil)
   (t
    t)))

(defun ansible-role-mode-list-files (role-top)
  "List the files of this role, returning paths relative to ROLE-TOP."
  (sort
   (mapcar
    (lambda (path)
      (f-relative path role-top))
    (f-files role-top
             'ansible-role-mode-include-file-p
             t))
   'string-lessp))

;; (ansible-role-mode-list-files test-role-top)

(defun ansible-role-mode-dired ()
  "Dired the files in this role."
  (interactive)
  (let ((role-top (ansible-role-mode-find-top)))
    (if role-top
      (let ((default-directory role-top))
        ;; @todo: generate a better list
        (dired (append (list role-top) (ansible-role-mode-list-files role-top)))))))

(defun ansible-role-mode-dired-templates ()
  "Dired the templates of the current role."
  (interactive)
  (let ((role-top (ansible-role-mode-find-top)))
    (if role-top
      (let ((template-dir (f-join role-top "templates")))
        (make-directory template-dir t)
        (dired template-dir)))))

(defun ansible-role-mode-edit (path)
  "Edit the file at PATH of the current role."
  (let ((role-top (ansible-role-mode-find-top)))
    (if role-top
      (find-file (f-join role-top path)))))

(defun ansible-role-mode-edit-defaults-main-yml ()
  "Edit ./defaults/main.yml of the current role."
  (interactive)
  (ansible-role-mode-edit "defaults/main.yml"))

(defun ansible-role-mode-edit-tasks-main-yml ()
  "Edit ./tasks/main.yml of the current role."
  (interactive)
  (ansible-role-mode-edit "tasks/main.yml"))

(easy-mmode-define-minor-mode
 ansible-role-mode
 "Toggle ansible-role mode.

With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode."
 ;; The initial value.
 :init-value nil
 ;; The indicator for the mode line.
 :lighter ansible-role-mode-lighter
 ;; The minor mode bindings.
 :keymap
 '(
   ("\C-cT" . ansible-role-mode-dired-templates)
   ("\C-cd" . ansible-role-mode-edit-defaults-main-yml)
   ("\C-cf" . ansible-role-mode-dired)
   ("\C-ct" . ansible-role-mode-edit-tasks-main-yml)
   ))

;;;;;

(defun ansible-role-mode-maybe-enable ()
  "Enable ‘ansible-role-mode’ if this yaml file is in an ansible role."
  (if (ansible-role-mode-find-top)
    (ansible-role-mode t)))

(if ansible-role-mode-add-yaml-mode-hook
  (add-hook 'yaml-mode-hook 'ansible-role-mode-maybe-enable))

;;
;; (progn (indent-buffer) (eval-buffer) (checkdoc))
;; (find-file "./tests.el")
;; (find-file "./ansible/roles/test_role/tasks/main-Debian.yml")

(provide 'ansible-role-mode)

;;; ansible-role-mode.el ends here
