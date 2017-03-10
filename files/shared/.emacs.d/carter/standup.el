(defun add-todo-section ()
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
    (insert "\n\nDone:\n\nKudos:\n\n")
    (yank)
    (search-backward "Done")
    (next-line)
    (move-end-of-line nil)))

(defun import-pivotal-tasks ()
  (interactive)
  (save-excursion
    (progn
      (search-forward "###")
      (previous-line)
      (insert (shell-command-to-string
               (concat
                "/bin/bash --login $HOME/bin/pi | "
                "/usr/local/bin/jq -r '.stories.stories[].name' | "
                "sed 's,^,- [sec] ,'"))))))

(defun create-or-update-pivotal-task (action)
  (interactive)
  (save-excursion
    (progn
      (beginning-of-line)
      (search-forward "] ")
      (set-mark-command nil)
      (end-of-line)
      (shell-command
       (concat
        "/bin/bash --login $HOME/bin/pu \""
        (buffer-substring (region-beginning) (region-end))
        "\" "
        action
        "> /dev/null"))
      (deactivate-mark))))

(defun add-task-to-pivotal ()
  (interactive)
  (save-excursion
    (create-or-update-pivotal-task "new-midweek-done")))

(defun mark-as-done ()
  (interactive)
  (progn
    (move-beginning-of-line nil)
    (kill-visual-line 1)
    (search-backward "Done")
    (search-forward "\n\n")
    (previous-line)
    (yank)
    (previous-line)
    (create-or-update-pivotal-task "done")))

(defun fold-todos-except-top ()
  (interactive)
  ;; Move to top header and collapse everything.
  (beginning-of-buffer)
  (markdown-cycle)
  ;; Unfold the next level of headers and move down.
  (markdown-cycle)
  (next-line 2)
  ;; Unfold the next level of headers and move down.
  (markdown-cycle)
  (next-line 2)
  ;; Unfold the last level of headers.
  (markdown-cycle)
  ;; Move to the end of the TODO line within this section.
  (search-forward "TODO:"))



;; Set up shortcuts.
(global-set-key (kbd "C-c t t") 'add-todo-section)
(global-set-key (kbd "C-c t a") 'add-task-to-pivotal)
(global-set-key (kbd "C-c t i") 'import-pivotal-tasks)
(global-set-key (kbd "C-c t d") 'mark-as-done)
(global-set-key (kbd "C-c t f") 'fold-todos-except-top)

(provide 'standup)
