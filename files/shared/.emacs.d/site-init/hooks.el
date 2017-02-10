;; Trim trailing whitespaces.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Enable fci-mode for certain major modes.
(add-hook 'sh-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'c-mode-hook 'fci-mode)
