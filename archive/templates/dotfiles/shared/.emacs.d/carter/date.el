;; Date shortcut.
(defun insert-date (prefix)
  "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%Y-%m-%d")                ;; C-c d
                 ((equal prefix '(4)) "%d.%m.%Y")         ;; C-u C-c d
                 ((equal prefix '(16)) "%A, %d. %B %Y"))) ;; C-u C-u C-c d
        (system-time-locale "en_US"))
    (insert (format-time-string format))))

;; Time shortcut.
(defun insert-time ()
  (interactive)
  (insert (format-time-string "[%H:%M]")))

;; Set up a shortcut.
(global-set-key (kbd "C-c d") 'insert-date)
(global-set-key (kbd "C-c t") 'insert-time)

(provide 'date)
