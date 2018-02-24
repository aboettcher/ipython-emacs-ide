(require 'package)
(setq package-user-dir "/usr/share/emacs/site-lisp/elpa")
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(package-initialize)



(setq jpk-packages
      '(
	pallet
	org
	org-plus-contrib
	ox-reveal
	jedi
	virtualenvwrapper
	magit
	pytest
	flycheck
	swiper
	ivy
	counsel
	python-docstring
	flycheck-mypy
	sphinx-doc
	yaml-mode
	yasnippet
	))

;; install any packages in jpk-packages, if they are not installed already
(let ((refreshed nil))
  (when (not package-archive-contents)
    (package-refresh-contents)
    (setq refreshed t))
  (dolist (pkg jpk-packages)
    (when (and (not (package-installed-p pkg))
	       (assoc pkg package-archive-contents))
      (unless refreshed
	(package-refresh-contents)
	(setq refreshed t))
      (package-install pkg))))
