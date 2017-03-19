;; Figure out what key combos look like with "C-h k".

;; Keyboard shortcuts.
(global-set-key (kbd "M-e") 'project-explorer-toggle)

;; Reindent, followed by newline and indent.
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)

;; Open URL.
(global-set-key (kbd "C-c o") 'browse-url-at-point)

;; Move-text.
(global-set-key (kbd "ESC <up>") 'move-text-up)
(global-set-key (kbd "ESC <down>") 'move-text-down)
(global-set-key (kbd "M-S-<up>") 'move-text-up)
(global-set-key (kbd "M-S-<down>") 'move-text-down)

;; Scrolling.
(global-set-key (kbd "M-<down>") 'scroll-up-line)
(global-set-key (kbd "M-<up>") 'scroll-down-line)

;; Magit.
(global-set-key (kbd "C-x g") 'magit-status)

;; Use this when testing lisp code.
(global-set-key (kbd "C-c C-b") 'eval-buffer)

;; Multiple Cursors.
(global-set-key (kbd "C-S-l") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-d") 'mc/mark-next-like-this)
(global-set-key (kbd "C-S-d") 'mc/mark-all-like-this)

;; Helm shortcuts.
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; Set shortcuts like Sublime Text.
(global-set-key (kbd "s-p") 'helm-projectile-find-file)
(global-set-key (kbd "s-P") 'helm-M-x)

;; Helm-related settings.
(require 'helm-git-grep) ;; Not necessary if installed by package.el
(global-set-key (kbd "C-c g") 'helm-git-grep)
;; Invoke `helm-git-grep' from isearch.
(define-key isearch-mode-map (kbd "C-c g") 'helm-git-grep-from-isearch)
;; Invoke `helm-git-grep' from other helm.
(eval-after-load 'helm
  '(define-key helm-map (kbd "C-c g") 'helm-git-grep-from-helm))

;; Winner mode shortcuts.
(global-unset-key (kbd "C-j"))
(global-set-key (kbd "C-j <left>") 'winner-undo)
(global-set-key (kbd "C-j <right>") 'winner-redo)
