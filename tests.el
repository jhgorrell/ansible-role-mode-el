;;; -*- lexical-binding: t -*-
;;
;; ansible-role-mode-el/tests.el ---
;;

(let ((current-directory (file-name-directory (or load-file-name ""))))
  (setq pkg-path (expand-file-name "." current-directory)))

(add-to-list 'load-path pkg-path)

;;;;;

(require 'ert)
(require 'ansible-role-mode)

;;;;;

(defvar test-role-top (expand-file-name "./ansible/roles/test_role"))

(princ "tests.el\n")

;; check we get an error reported
;; (ert-deftest test-0 ()
;;   (should nil))

(ert-deftest test-1 ()
  (should (= 1 1)))

;;;;;

(ert-deftest test-find-top-1 ()
  ;; shouldnt find a role in these dirs.
  (should-not (ansible-role-mode-find-top "."))
  (should-not (ansible-role-mode-find-top "./ansible"))
  (should-not (ansible-role-mode-find-top (f-join test-role-top "..")))
  nil)

(ert-deftest test-find-top-2 ()
  ;; should find a role here.
  (should (ansible-role-mode-find-top test-role-top))

  (let ((default-directory test-role-top))
    (should (stringp (ansible-role-mode-find-top)))
    (should (stringp (ansible-role-mode-find-top ".")))
    nil)
  nil)


(ert-deftest test-include-file-p ()
  (should (ansible-role-mode-include-file-p "true"))
  (should-not (ansible-role-mode-include-file-p "backup~"))
  nil)

(ert-deftest test-list-files-1 ()
  (should (ansible-role-mode-list-files test-role-top))
  (should 
   (equal
    '("README.rst" "defaults/main.yml" "tasks/main-Debian.yml" "tasks/main-Fedora.yml" "tasks/main.yml")
    (ansible-role-mode-list-files test-role-top)))
  nil)

;;;;;

(ert t)

;; (progn  (eval-buffer (get-buffer "ansible-role-mode.el")) (eval-buffer) nil)
