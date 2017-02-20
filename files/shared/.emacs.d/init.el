;; Set up the load path.
(add-to-list 'load-path "~/.emacs.d/site-init/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/carter/")
(add-to-list 'load-path "/usr/share/emacs24/site-lisp/git/")
(add-to-list 'load-path (concat (getenv "GOPATH")
                                "/src/github.com/golang/lint/misc/emacs"))

;; Set up theme.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)

;; Load/install packages.
(package-initialize)
(load-library "packages")

;; Load miscelaneous defaults.
(load-library "defaults")

;; Load all plugins.
(load-library "plugins")

;; Set up hooks.
(load-library "hooks")

;; Add keyboard shortcuts.
(load-library "keyboard-shortcuts")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(org-indent-mode-turns-on-hiding-stars t)
 '(package-selected-packages
   (quote
    (window-number buffer-move smooth-scroll project-explorer json-mode markdown-mode go-autocomplete go-eldoc go-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-header-face ((t (:inherit (nil font-lock-function-name-face) :family "variable-pitch" :weight bold))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.8))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.2)))))
