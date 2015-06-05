(require 'cask "/root/.cask/cask.el")
(cask-initialize)

;; python virtual env setup
(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location "/root/.virtualenvs/")
(setq python-environment-directory venv-location)
(venv-workon "py34")

;; jedi setup
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; python environmnt information in the mode line
(setq-default mode-line-format (cons '(:exec venv-current-name) mode-line-format))

;; no splash screen
(setq inhibit-splash-screen t)

;; remove menubar
(menu-bar-mode 0)

;; remove toolbar
(tool-bar-mode -1)

;; remove scrollbar
(scroll-bar-mode -1)

;; column number
(column-number-mode 1)

;; mini buffer completion
;;(icomplete-mode t)
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-confirm-unique-completion nil)
;; (setq ido-enable-tramp-completion nil)

;; visual beeping
(setq visible-bell t)

;; show matching paren
(show-paren-mode 1)

;; Turn off blinking cursor
(blink-cursor-mode nil)

;; Enable font lock mode globally
(global-font-lock-mode 1)
