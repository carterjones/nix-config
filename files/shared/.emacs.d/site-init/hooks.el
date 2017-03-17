;; Trim trailing whitespaces.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Enable fci-mode for certain major modes.
(add-hook 'sh-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'c-mode-hook 'fci-mode)

;; Activate org-indent-mode.
;; Based on http://stackoverflow.com/a/1775652
(add-hook 'org-mode-hook (lambda () (org-indent-mode t)) t)

;; Treate HCL files as JSON.
(add-to-list 'auto-mode-alist '("\\.hcl\\'" . json-mode))
