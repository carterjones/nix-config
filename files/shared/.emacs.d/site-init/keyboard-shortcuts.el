;; Keyboard shortcuts.
(global-set-key (kbd "M-e") 'project-explorer-toggle)

;; Reindent, followed by newline and indent.
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)

;; Open URL.
(global-set-key (kbd "C-c o") 'browse-url-at-point)

;; Move-text.
(global-set-key (kbd "ESC <up>") 'move-text-up)
(global-set-key (kbd "ESC <down>") 'move-text-down)


(global-set-key (kbd "M-<down>") (quote scroll-up-line))
(global-set-key (kbd "M-<up>") (quote scroll-down-line))

;; Magit.
(global-set-key (kbd "C-x g") 'magit-status)
