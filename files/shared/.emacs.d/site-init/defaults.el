;; Disable backup files.
(setq-default make-backup-files nil)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

;; Set the fill column (for wrapping) to 72.
(setq-default fill-column 72)

;; Show the current column.
(setq-default column-number-mode t)

;; Hide menu bar.
(menu-bar-mode -1)

;; Set the default browser to Chrome.
(setq browse-url-browser-function 'browse-url-chrome)

;; Load changes from disk into buffer if changes are made outside of Emacs.
(global-auto-revert-mode t)
