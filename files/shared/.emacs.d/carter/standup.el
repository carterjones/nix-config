(require 'dash)
(require 'request)

(defun standup-todo-new-section ()
  "Create a new TODO section."
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
    (move-end-of-line nil)
    (standup-todo-fold-except-top)))

(defun standup-todo-mark-as-done ()
  (interactive)
  (progn
    (move-beginning-of-line nil)
    (kill-visual-line 1)
    (search-backward "Done")
    (search-forward "\n\n")
    (previous-line)
    (yank)
    (previous-line)))

(defun standup-todo-fold-except-top ()
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

(defun get-pivotal-token ()
  (replace-regexp-in-string
   "\n"
   ""
   (with-temp-buffer
     (insert-file "~/.secret")
     (keep-lines "PIVOTAL_TOKEN")
     (replace-regexp ".*='?" "")
     (replace-regexp "'.*" "")
     (buffer-string))))

(defun extract-project-id-from-data (project-name data)
  (let ((jdata (coerce (json-read-from-string data) 'list)))
    (number-to-string
     (assoc-default
      'id
      (--first
       (string-match project-name (assoc-default 'name it))
       jdata)))))

(defun call-pivotal-api (type route handler &optional params)
  (let (result)
    (request
     (concat "https://www.pivotaltracker.com/services/v5/" route)
     :type type
     :headers `(("X-TrackerToken" . ,(get-pivotal-token)))
     :params params
     :parser 'buffer-string
     :sync t
     :success (function*
               (lambda (&key data &allow-other-keys)
                 (when data
                   (setq result (funcall handler data))))))
    result))

(defun get-project-id (project)
  (call-pivotal-api
   "GET"
   "projects"
   (lambda (data)
     (extract-project-id-from-data project data))))

(defun extract-stories (data)
  (coerce
   (assoc-default 'stories
                  (assoc-default 'stories
                                 (json-read-from-string data)))
   'list))

(defun extract-names-from-stories (data)
  (--map
   (assoc-default 'name it)
   (extract-stories data)))

(defun get-started-stories (project initials)
  (let (stories
        (route (concat "projects/"
                       (get-project-id project)
                       "/search"))
        (query (concat "owner:"
                       initials
                       " AND state:started")))
    (call-pivotal-api
     "GET"
     route
     (lambda (data)
       (setq stories (extract-names-from-stories data)))
     `(("query" . ,query)))
    stories))

(defun standup-pivotal-import-tasks ()
  (interactive)
  (save-excursion
    (progn
      (search-forward "###")
      (previous-line)
      (--each (get-started-stories "Security" "cj")
        (insert (concat "- [sec] " it)))
      (newline)
      (set-mark-command nil)
      (search-backward "TODO")
      (delete-duplicate-lines (region-beginning) (region-end))
      (deactivate-mark))))

(defun standup-pivotal-create-or-update-task (action)
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

(defun standup-pivotal-new-midweek-task ()
  (interactive)
  (save-excursion
    (standup-pivotal-create-or-update-task "new-midweek")))

(defun standup-pivotal-start-task ()
  (interactive)
  (save-excursion
    (standup-pivotal-create-or-update-task "start")))

(defun standup-pivotal-deliver-task ()
  (interactive)
  (save-excursion
    (standup-pivotal-create-or-update-task "done")))

;; Set up shortcuts that affect just this file.
(global-set-key (kbd "C-c s t n") 'standup-todo-new-section)
(global-set-key (kbd "C-c s t d") 'standup-todo-mark-as-done)
(global-set-key (kbd "C-c s t f") 'standup-todo-fold-except-top)

;; Set up shortcuts that interact with Pivotal.
(global-set-key (kbd "C-c s p i") 'standup-pivotal-import-tasks)
(global-set-key (kbd "C-c s p n") 'standup-pivotal-new-midweek-task)
(global-set-key (kbd "C-c s p s") 'standup-pivotal-start-task)
(global-set-key (kbd "C-c s p d") 'standup-pivotal-deliver-task)

(provide 'standup)
