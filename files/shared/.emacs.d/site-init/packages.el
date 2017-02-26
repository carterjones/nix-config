(defvar my-packages
  '(;; Go
    go-mode
    go-eldoc
    go-autocomplete

    ;; Markdown
    markdown-mode

    ;; Javascript
    json-mode

    ;; Env
    project-explorer
    smooth-scroll
    buffer-move
    window-number

    ;; Git
    git
    magit

    ;; persp-mode
    persp-mode

    ;; Fuzzy find
    fiplr

    ;; Go
    golint
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
