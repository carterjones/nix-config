;; Set up the load path.
(add-to-list 'load-path "~/.emacs.d/site-init/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/carter/")
(add-to-list 'load-path "/usr/share/emacs24/site-lisp/git/")
(add-to-list 'load-path (concat (getenv "GOPATH")
                                "/src/github.com/golang/lint/misc/emacs"))

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
 '(package-selected-packages
   (quote (window-number
           buffer-move
           smooth-scroll
           project-explorer
           json-mode
           markdown-mode
           go-autocomplete
           go-eldoc
           go-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
