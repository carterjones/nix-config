;; Trim trailing whitespaces.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Enable fci-mode when changing major modes.
(add-hook 'after-change-major-mode-hook 'fci-mode)
