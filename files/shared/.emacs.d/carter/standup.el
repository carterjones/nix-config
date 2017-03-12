(require 'cl)
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
  (let (pivotal-api-result)
    (request
     (concat "https://www.pivotaltracker.com/services/v5/" route)
     :type type
     :headers (let ((headers `(("X-TrackerToken" . ,(get-pivotal-token)))))
                (if (string= type "GET")
                    headers
                  (cons '("Content-Type" . "application/json") headers)))
     :params (if (string= type "GET")
                 params
               nil)
     :data (if (string= type "GET")
               nil
             (json-encode params))
     :parser 'buffer-string
     :sync t
     :success (cl-function
               (lambda (&key data &allow-other-keys)
                 (when data
                   (setq pivotal-api-result (funcall handler data)))))
     :error (cl-function
             (lambda (&key data &allow-other-keys)
               (let ((jdata (coerce
                             (json-read-from-string data)
                             'list)))
                 (message "%S: %S"
                          (assoc-default 'error jdata)
                          (assoc-default 'general_problem jdata))))))
    pivotal-api-result))

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

(defun extract-names-from-stories (stories)
  (--map (assoc-default 'name it)
         stories))

(defun extract-ids-from-stories (stories)
  (--map (assoc-default 'id it)
         stories))

(defun search-for-stories (project search-query)
  (let (stories
        (route (concat "projects/"
                       (get-project-id project)
                       "/search"))
        (query search-query))
    (call-pivotal-api
     "GET"
     route
     (lambda (data)
       (setq stories (extract-stories data)))
     `(("query" . ,query)))
    stories))

(defun get-started-stories (project initials)
  (search-for-stories
   project
   (concat "owner:" initials " AND state:started")))

(defun get-stories-by-name (project name)
  (search-for-stories
   project
   (concat "name:" name)))

(defun create-story (project name)
  (let (story
        (project-id (get-project-id project)))
    (call-pivotal-api
     "POST"
     (concat "projects/" project-id "/stories")
     (lambda (data)
       (setq story (json-read-from-string data)))
     `(("name" . ,name)))
    story))

(defun get-or-create-story-id (project name)
  (let (story-id)
    (setq story-id (-first-item
                    (extract-ids-from-stories
                     (get-stories-by-name
                      project
                      name))))
    (if (not story-id)
        (setq
         story-id
         (assoc-default 'id (create-story project name))))
    (number-to-string story-id)))

(defun add-data-to-test-buffer (data)
  (with-current-buffer (get-buffer-create "*test123*")
  (erase-buffer)
  (insert (format "%s" data))
  (pop-to-buffer (current-buffer))))

(defun get-account-id ()
  (let (profile-id)
    (call-pivotal-api
     "GET"
     "me"
     (lambda (data)
       (setq profile-id (assoc-default 'id (json-read-from-string data)))))
    profile-id))

(defun update-pivotal-story (project name params)
  (let ((story-id (get-or-create-story-id project name)))
    (call-pivotal-api
     "PUT"
     (concat "stories/" story-id)
     (lambda (data)
       (message
        (concat
         "Pivotal story update successful for '"
         (assoc-default 'name
                        (json-read-from-string data))
         "'")))
     params)))

(defun set-story-estimate-zero (project name)
  (update-pivotal-story project name '(("estimate" . 0))))

(defun set-story-state-started (project name)
  (let ((account-ids (vector (get-account-id))))
    (update-pivotal-story
     project
     name
     `(("current_state" . "started")
       ("owner_ids" . ,account-ids)))))

(defun set-story-state-delivered (project name)
  (let ((account-ids (vector (get-account-id))))
    (update-pivotal-story
     project
     name
     `(("current_state" . "delivered")
       ("owner_ids" . ,account-ids)))))

(defun standup-pivotal-import-tasks ()
  (interactive)
  (save-excursion
    (progn
      (search-forward "###")
      (previous-line)
      (--each (extract-names-from-stories
               (get-started-stories "Security" "cj"))
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
      (let ((story-name (buffer-substring (region-beginning) (region-end))))
        (cond ((string= action "midweek") (set-story-estimate-zero "Security" story-name))
              ((string= action "start") (set-story-state-started "Security" story-name))
              ((string= action "done") (set-story-state-delivered "Security" story-name))))
      (deactivate-mark))))

(defun standup-pivotal-new-midweek-task ()
  (interactive)
  (save-excursion
    (standup-pivotal-create-or-update-task "midweek")))

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
