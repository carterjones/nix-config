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

;; org-mode
(define-key global-map "\C-cc" 'org-capture)
(setq org-directory
      (if (f-directory? "~/Dropbox")
          "~/Dropbox/org/"
        "~/"))
(setq org-capture-templates
      '(("t" "Todo"
         entry (file+headline (concat org-directory "todo.org") "ToDo list")
         "* TODO %?\n  %i")
        ("l" "Log Entry"
         entry (file+headline (concat org-directory "log.org") "Log")
         "* %<%Y-%m-%d %I:%M:%S %p>\n%i%?")))

;; unfill
(require 'unfill)

;; make buffers behave
(load-library "quiet-buffers")

;; load markdown-toc
(require 'markdown-toc)

;; Helm
(require 'helm)
(require 'helm-config)

(projectile-global-mode)

;; Set indexing method based on OS.
(if (or
     (string= system-type "cygwin")
     (string= system-type "windows-nt"))
    (setq projectile-indexing-method 'alien)
  (setq projectile-indexing-method 'native))

(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; Bar cursor works better with multiple cursors than the stock bar cursor face.
(require 'bar-cursor)

;; Multiple cursors
(require 'multiple-cursors)
