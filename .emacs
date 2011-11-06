;; Set the load path for emacs.
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; Show line numbers and column numbers.
(setq line-number-mode t)
(setq column-number-mode t)

;; Reindent, followed by newline and indent.
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)

;; Disable backup.
(setq backup-inhibited t)

;; Disable auto save.
(setq auto-save-default nil)

;; Set the default tab width to 2. Uses both ways of setting it.
(setq default-tab-width 2)
(setq-default tab-width 2)

;; Set the basic offset and indentation scheme for various common filetypes.
(setq sh-basic-offset 2)
(setq sh-indentation 2)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

;; Use the fill-column-indicator module.
(setq-default fill-column 80)
(require 'fill-column-indicator)
(add-hook 'sh-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'c-mode-hook 'fci-mode)
