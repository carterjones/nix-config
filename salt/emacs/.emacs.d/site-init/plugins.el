;; auto-complete
(ac-config-default)
(require 'auto-complete-config)
(require 'go-autocomplete)
(require 'golint)

;; fill column indicator
(require 'fill-column-indicator)
(setq-default fci-rule-column 80)
(setq-default fci-rule-width 1)
(setq-default fci-rule-color "grey80")
(setq-default fci-rule-character-color "green")

;; yaml mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

;; go mode
(defun go-mode-setup ()
  (setq compile-command "go build -v && go test -v && go vet && golint && errcheck")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-setup)

;; project explorer
(require 'project-explorer)

;; my personal todo plugin
(require 'standup)

;; git-related plugins
(require 'git-timemachine)
(require 'egit)
(require 'magit)

;; unfill
(require 'unfill)

;; make buffers behave
(load-library "quiet-buffers")

;; load markdown-toc
(require 'markdown-toc)

;; Helm
(require 'helm)
(require 'helm-config)

(helm-mode 1)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; Add in a workaround for a projectile issue:
;; https://github.com/bbatsov/projectile/issues/1183
(setq projectile-mode-line
      '(:eval (format " Projectile[%s]"
                      (projectile-project-name))))

;; Bar cursor works better with multiple cursors than the stock bar cursor face.
(require 'bar-cursor)

;; Multiple cursors
(require 'multiple-cursors)

;; Enable winner mode.
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; Enable Do Re Mi.
(require 'doremi)
(defalias 'resize-window 'doremi-window-height+)

;; Enable date shortcuts.
(require 'date)

;; Change Alt-Backspace to delete rather than kill.
(load-library "backward-delete-word")

;; Load yet another folding plugin.
(require 'yafolding)

;; Load the Dynaflowy plugin.
(load-library "dynaflowy")
