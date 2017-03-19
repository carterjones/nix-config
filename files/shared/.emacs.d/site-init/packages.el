(defvar my-packages
  '(bar-cursor
    buffer-move
    fiplr
    git
    go-autocomplete
    go-eldoc
    go-mode
    golint
    helm-git-grep
    helm-projectile
    json-mode
    magit
    markdown-mode
    multiple-cursors
    persp-mode
    project-explorer
    projectile
    request
    smooth-scroll
    window-number
    ))

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")))

;; Fetch the list of packages available.
;; Taken from http://stackoverflow.com/a/22296680
(setq n 0)                                  ; set n as 0
(dolist (pkg my-packages)                   ; for each pkg in list
  (unless (or                               ; unless
           (package-installed-p pkg)        ; pkg is installed or
           (assoc pkg                       ; pkg is in the archive list
                  package-archive-contents))
    (setq n (+ n 1))))                      ; add one to n
(when (> n 0)                               ; if n > 0,
  (package-refresh-contents))               ; refresh packages

;; Install the missing packages.
(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))
