(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

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
    window-number)
  "My packages!")

;; Fetch the list of packages available.
(unless package-archive-contents
  (package-refresh-contents))

;; Install the missing packages.
(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))
