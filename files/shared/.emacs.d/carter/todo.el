(defun add-todo ()
  "Create a new TODO entry."
  (interactive)
  (let ((beg (progn (search-backward "###")
                    (search-forward "blocker")
                    (move-beginning-of-line nil)))
        (end (progn (next-line)
                    (search-forward "###")
                    (move-beginning-of-line nil))))
    (kill-ring-save beg end)
    (search-backward "###")
    (insert "### ")
    (insert (format-time-string "%Y-%m-%d"
                                (time-add (current-time)
                                          (days-to-time 1))))
    (insert "\n\nDone:\n- \n\nKudos:\n- \n\n")
    (yank)
    (search-backward "Done")
    (next-line)
    (move-end-of-line nil)))

(defun add-pivotal-tasks ()
  (interactive)
  (save-excursion
    (progn
      (search-forward "###")
      (previous-line)
      (insert (shell-command-to-string "p todo")))))

(defun mark-as-done ()
  (interactive)
  (save-excursion
    (progn
      (move-beginning-of-line nil)
      (kill-visual-line 1)
      (search-backward "Done")
      (search-forward "\n\n")
      (previous-line)
      (yank))))

;; Set up a shortcut.
(global-set-key (kbd "C-c t") 'add-todo)
(global-set-key (kbd "C-c p") 'add-pivotal-tasks)
(global-set-key (kbd "C-c d") 'mark-as-done)

(provide 'todo)
