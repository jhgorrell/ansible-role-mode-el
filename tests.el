;;; -*- lexical-binding: t -*-
;;
;; ansible-role-mode-el/tests.el ---
;;

(require 'ert)

(require 'package)
(package-initialize)

(let ((load-path (append (".") load-path)))
  (load "ansible-role-mode"))

;;;;;

(ert-deftest test-1 ()
  (should (= 1 1)))

(null (ansible-role-mode-find-top "."))

(ert-deftest test-find-top-1 ()
  ;;
  (let ((default-directory "."))
    (let ((top (ansible-role-mode-find-top)))
      (print top)
      ;;(should-not top))
    ;;(progn (ansible-role-mode-find-top)))
    ;;(should-not (progn (ansible-role-mode-find-top ".")))
    ;;(should-not nil)
    )
  )
;;  ;;
;;  (if nil
;;  (let ((default-directory "./ansible/roles/test_role"))
;;    (should (stringp (ansible-role-mode-find-top)))
;;    (should (stringp (ansible-role-mode-find-top ".")))))
;;  )


  
;; (ansible-role-mode-find-top ".")
;; (ansible-role-mode-find-top "./ansible/roles/test_role")
;; (ansible-role-mode-find-top "./ansible/roles/test_role/tasks")

;; (progn (eval-buffer) (ert t) nil)
