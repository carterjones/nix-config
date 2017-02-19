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
(require 'todo)

;; git-related plugins
(require 'git-timemachine)
(require 'egit)

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
