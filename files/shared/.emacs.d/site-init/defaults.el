;; Disable backup files.
(setq-default make-backup-files nil)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

;; Set the fill column (for wrapping).
(setq-default fill-column 80)

;; Show the current column.
(setq-default column-number-mode t)

;; Hide menu bar.
(menu-bar-mode -1)

;; Set the default browser to Chrome.
(if (eq system-type 'darwin)
    (setq browse-url-generic-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
          browse-url-browser-function 'browse-url-generic)
  (setq browse-url-browser-function 'browse-url-chrome))

;; Load changes from disk into buffer if changes are made outside of Emacs.
(global-auto-revert-mode t)
