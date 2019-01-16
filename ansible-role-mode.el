;;; ansible-role-mode.el --- helps edit an ansible role.
;;
;; ansible-role-mode-el/ansible-role-mode.el ---
;;

;; not really, but needed for the hook.
;; (require 'yaml-mode)

;;; Commentary:

;;; Code:

(defvar ansible-role-mode-lighter
  " ARM"
  "What to show in the mode line when active.")

(defvar ansible-role-mode-add-hook t
  "Automaticly add our hook to ‘yaml-mode’.")

;;;;;

(defun ansible-role-mode-find-top ()
  "Find the top of the role directory.
It has a 'tasks' directory."
  (let ((d (cond
            ((file-directory-p "./tasks")
             ".")
            ((file-directory-p "./../tasks")
             "..")
            ((file-directory-p "./../../tasks")
             "../..")
            (t
             nil))))
    (if d
      (expand-file-name d))))
  
(defun ansible-role-mode-dired-role ()
  "Dired the yaml files in this role."
  (interactive)
  (let ((top (ansible-role-mode-find-top)))
    (if top
      ;; @todo: generate a better list
      (dired (concat top "/*/*.yml")))))

(defun ansible-role-mode-dired-templates ()
  "Dired the templates of the current role."
  (interactive)
  (let ((top (ansible-role-mode-find-top)))
    (if top
      (let ((ttop (concat top "/templates")))
        (make-directory ttop t)
        (dired ttop)))))

(defun ansible-role-mode-edit (path)
  "Edit the file at PATH of the current role."
  (let ((top (ansible-role-mode-find-top)))
    (if top
      (find-file (concat top "/" path)))))
  
(defun ansible-role-mode-edit-defaults-main-yml ()
  "Edit ./defaults/main.yml of the current role."
  (interactive)
  (ansible-role-mode-edit "defaults/main.yml"))

(defun ansible-role-mode-edit-tasks-main-yml ()
  "Edit ./tasks/main.yml of the current role."
  (interactive)
  (ansible-role-mode-edit "tasks/main.yml"))

(easy-mmode-define-minor-mode ansible-role-mode
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
    ("\C-cr" . ansible-role-mode-dired-role)
    ("\C-ct" . ansible-role-mode-edit-tasks-main-yml)
    ))

(defun ansible-role-mode-maybe-enable ()
  "Enable ‘ansible-role-mode’ if this yaml file is in an ansible role."
  (if (ansible-role-mode-find-top)
    (ansible-role-mode t)))


(if ansible-role-mode-add-hook
  (add-hook 'yaml-mode-hook 'ansible-role-mode-maybe-enable))

;; (eval-buffer)
;; (checkdoc)
;; (find-file "./ansible/roles/test_role")

(provide 'ansible-role-mode)

;;; ansible-role-mode.el ends here
