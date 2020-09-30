(require 'cl)
(require 'dash)
(require 'request)

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

(defun get-account-id ()
  (let (profile-id)
    (call-pivotal-api
     "GET"
     "me"
     (lambda (data)
       (setq profile-id (assoc-default 'id (json-read-from-string data)))))
    profile-id))

(defun get-project-id (project)
  (call-pivotal-api
   "GET"
   "projects"
   (lambda (data)
     (number-to-string
      (assoc-default
       'id
       (--first
        (string-match project (assoc-default 'name it))
        (coerce (json-read-from-string data) 'list)))))))

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
       (setq stories
             (coerce
              (assoc-default 'stories (assoc-default 'stories (json-read-from-string data)))
              'list)))
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
                    (--map (assoc-default 'id it)
                           (get-stories-by-name project name))))
    (if (not story-id)
        (setq story-id (assoc-default 'id (create-story project name))))
    (number-to-string story-id)))

(defun add-data-to-test-buffer (data)
  (with-current-buffer (get-buffer-create "*test123*")
  (erase-buffer)
  (insert (format "%s" data))
  (pop-to-buffer (current-buffer))))

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

(provide 'pivotal)
