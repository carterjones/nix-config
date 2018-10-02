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

;; From https://emacs.stackexchange.com/a/22589
(defun my/org-mode-hook ()
  "Stop the org-level headers from increasing in height relative to the other text."
  (dolist (face '(org-level-1
                  org-level-2
                  org-level-3
                  org-level-4
                  org-level-5))
    (set-face-attribute face nil :weight 'semi-bold :height 1.0)))
(add-hook 'org-mode-hook 'my/org-mode-hook)

;; Treate HCL and TF files as JSON.
(add-to-list 'auto-mode-alist '("\\.hcl\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\.tf\\'" . json-mode))

;; Use special settings for Markdown.
(add-hook 'markdown-mode-hook 'visual-line-mode)
