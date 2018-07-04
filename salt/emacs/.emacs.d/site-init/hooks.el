;; Trim trailing whitespaces, except for when editing diffs since that causes
;; issues after + and - characters.
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'diff-mode-hook
          '(lambda ()
             (remove-hook 'before-save-hook 'delete-trailing-whitespace)))

;; Enable fci-mode for certain major modes.
(add-hook 'sh-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'c-mode-hook 'fci-mode)

;; Activate org-indent-mode.
;; Based on http://stackoverflow.com/a/1775652
(add-hook 'org-mode-hook (lambda () (org-indent-mode t)) t)

;; Treate HCL and TF files as JSON.
(add-to-list 'auto-mode-alist '("\\.hcl\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\.tf\\'" . json-mode))

;; Use special settings for Markdown.
(add-hook 'markdown-mode-hook 'visual-line-mode)
