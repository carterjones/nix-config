(setq-local dynaflowy-mode nil)

(define-minor-mode dynaflowy-mode
  "Make lists behave like Dynalist/Workflowy lists. This allows
sublists to be narrowed infinitely, also referred to as 'zooming
in' or 'focusing' on sublists."
  :lighter " Dynaflowy"
  :keymap (let ((map (make-sparse-keymap)))
            ;; indentation
            (define-key map (kbd "TAB")           'df-indent-subtree)
            (define-key map (kbd "s-<right>")     nil)
            (define-key map (kbd "s-<right>")     'df-indent-subtree)
            (define-key map (kbd "S-s-<right>")   'df-indent-entry)

            ;; unindentation
            (define-key map (kbd "<S-tab>")       'df-unindent-subtree)
            (define-key map (kbd "s-<left>")      nil)
            (define-key map (kbd "s-<left>")      'df-unindent-subtree)
            (define-key map (kbd "S-s-<left>")    'df-unindent-entry)

            ;; delete
            (define-key map (kbd "s-<backspace>") 'df-delete-subtree)

            ;; collapse/expand
            (define-key map (kbd "s-.")           'yafolding-toggle-element)

            ;; narrow/widen
            (define-key map (kbd "s-]")           'df-narrow)
            (define-key map (kbd "s-[")           'df-widen)

            ;; new items
            (define-key map (kbd "RET")           'df-insert-entry)
            (define-key map (kbd "s-<return>")    'df-insert-non-entry)

            ;; save
            (define-key map (kbd "C-x C-s")       'df-save)
            (define-key map (kbd "s-s")           'df-save)

            ;; format
            (define-key map (kbd "M-q")           'df-fill-paragraph-entry)

            ;; TODO:
            ;; Swap with previous
            ;; Swap with next
            map)
  (progn
    ;; Add Dynaflowy to the mode line.
    (add-to-list 'minor-mode-alist '(dynaflowy-mode " Dynaflowy"))

    ;; Enable folding.
    (require 'yafolding)
    (yafolding-mode 1)))

(defvar df-entry-identifier-regexp "^ *\\(-\\|\\([0-9]+\\|[a-z]\\)\\.\\) "
  "A regular expression that can be used to identify the
beginning of an entry in dynaflowy-mode. It will match on '-' and
integers followed by a period, such as '1.', '42.', and
'9001.'. It does not support decimal numbers.")

(defvar df-default-indent-size 2
  "The default amount of spaces to indent entries and subtrees")

;; Store the positions of each buffer that has had a subtree narrowed from
;; it. Each positoin represents the beginning and end of a region of a subtree
;; that is narrowed in a child buffer.
(setq df-narrow-posns (make-hash-table :test #'equal))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; narrow/widen functions ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun df-narrow ()
  (interactive)
  (let* ((current-point (point))
         (parent-b (df-subtree-beginning))
         (parent-e (df-subtree-ending (df-subtree-indentation)))
         (child-buf-name (concat (buffer-name) ">"))
         (buf (generate-new-buffer child-buf-name)))
    ;; Add the beginning and end of the subtree to df-narrow-posns. This will
    ;; be used during widening.
    (puthash (buffer-name) (list parent-b parent-e) df-narrow-posns)

    ;; Mark the parent buffer as read-only.
    (read-only-mode 1)

    ;; Copy the subtree to the child buffer and switch to that buffer.
    (copy-to-buffer child-buf-name parent-b parent-e)
    (switch-to-buffer buf)

    ;; Enable dynaflowy mode in the child buffer.
    (dynaflowy-mode 1)

    ;; Save the original indentation level to the local buffer.
    (df-save-top-level-indentation)

    ;; Unindent the whole subtree until it is on the far left.
    (df-unindent-buffer-until-parent-is-level-0)

    ;; Move the cursor to the desired position.
    ;; TODO: make this reflect where the point was in the parent buffer.
    (end-of-line)))

(defun df-widen ()
  (interactive)
  (let* ((child-buf-name (buffer-name))
         (parent-buf-name (string-remove-suffix ">" (buffer-name)))
         (parent-b (nth 0 (gethash parent-buf-name df-narrow-posns))))
    (save-excursion
      ;; Push changes all the way up.
      (df-push-changes-to-parent-recursive)

      ;; Switch to the parent buffer.
      (switch-to-buffer parent-buf-name)

      ;; Unmark parent as read-only.
      (read-only-mode -1)

      ;; Delete the child buffer.
      (kill-buffer child-buf-name))
    (goto-char parent-b)
    (end-of-line)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; get information about subtrees ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun df-subtree-indentation ()
  (save-excursion
    (end-of-line)
    (let* ((indent-point (search-backward-regexp df-entry-identifier-regexp nil t))
           (b (progn (beginning-of-line) (point))))
      (cond (indent-point (- (search-forward-regexp "^ *") b))
            ;; TODO: handle situations where no regex is found, such as indented spaces
            ;; not exactly sure how we want to handle that
            (t 0)))))

(defun msg-indentation ()
  (interactive)
  (message (number-to-string (df-subtree-indentation))))

(defun df-subtree-beginning ()
  (save-excursion
    (end-of-line)
    (let ((b (search-backward-regexp df-entry-identifier-regexp nil t)))
      (if (not b)
          (goto-char (point-min))))
    (beginning-of-line)
    (point)))

(defun df-subtree-ending (level)
  (save-excursion
    (let ((target-point nil))
      (forward-line)
      (while (< (point) (point-max))
        (if (and (<= (df-subtree-indentation) level)
                 (df-is-entry-line))
            ;; If true, we have found the end of the subtree, so we save the
            ;; target point and move to the end of the buffer so that the while
            ;; loop will terminate.
            (progn
              (beginning-of-line)
              (setq target-point (point))
              (goto-char (point-max)))
          ;; If false, we keep moving.
          (forward-line)))
      (if target-point
          ;; If true, we found an end to the subtree, so we return that value.
          target-point
        ;; If false, no value was found, so we return the maximum point in the
        ;; buffer.
        (point-max)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; get information about buffers ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun df-buffer-name (level)
  "Get the name of the buffer given the specified level."
  (let ((base-buf-name (replace-regexp-in-string ">+$" "" (buffer-name))))
    (cond ((< level 0) (error "error in df-buffer-name: level should be 0 or greater"))
          ((= level 0) base-buf-name)
          ((> level 0) (concat base-buf-name (make-string level ?\>))))))

(defun df-buffer-level ()
  "Get the current buffer level."
  (let ((base-buf-name (df-buffer-name 0))
        (this-buf-name (buffer-name)))
    (length (string-remove-prefix base-buf-name this-buf-name))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; functions to propagate changes and save them ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun df-push-changes-to-parent (level)
  (interactive "p")
  ;; Only proceed if the level is not the topmost buffer.
  (when (> level 0)
    (let* ((this-buf-name (buffer-name))
           (child-buf-name (df-buffer-name level))
           (parent-buf-name (df-buffer-name (1- level)))
           (parent-b (nth 0 (gethash parent-buf-name df-narrow-posns)))
           (parent-e (nth 1 (gethash parent-buf-name df-narrow-posns)))
           child-original-indent-level
           parent-read-only
           indented-buf-size)
      ;; Save the original indentation level from the child buffer.
      (switch-to-buffer child-buf-name)
      (setq child-original-indent-level df-original-indentation-level)

      ;; Use a temporary buffer for the rest of the processing.
      (with-temp-buffer
        (let ((tmp-buf (current-buffer)))
          ;; Make a copy of the child buffer in the temp buffer.
          (insert-buffer-substring child-buf-name)

          ;; Make sure there is an empty newline at the end of the temp
          ;; buffer. This fixes weird bugs that can occur when a new top-level
          ;; object is added to the bottom of the narrowed buffer.
          (df-ensure-empty-line-at-end)

          ;; Indent the copy of the child buffer in the temp buffer.
          (df-indent-buffer-until-parent-is-level child-original-indent-level)
          (setq indented-buf-size (point-max))

          ;; Switch to the parent buffer.
          (switch-to-buffer parent-buf-name)

          ;; Determine if the parent is read-only. If it is, unmark it.
          (setq parent-read-only buffer-read-only)
          (if parent-read-only (read-only-mode -1))

          ;; Delete the original region that will be replaced.
          (delete-region parent-b parent-e)

          ;; Move to the beginning of where the new data will be inserted.
          (goto-char parent-b)

          ;; Insert the indented data from the temp buffer.
          (insert-buffer-substring tmp-buf)

          ;; If the parent was originally read-only, then re-mark it as read-only.
          (if parent-read-only (read-only-mode 1) nil)

          ;; Update the positions of the start and end of the parent buffer.
          (puthash parent-buf-name
                   (list parent-b (+ parent-b indented-buf-size -1))
                   df-narrow-posns)))

      ;; Switch back to the original buffer.
      (switch-to-buffer this-buf-name))))

(defun df-push-changes-to-parent-recursive ()
  (interactive)
  (let ((level (df-buffer-level)))
    (while (> level 0)
      (df-push-changes-to-parent level)
      (setq level (1- level)))))

(defun df-save-root-buffer ()
  (interactive)
  (let ((root-buf-name (df-buffer-name 0))
        (this-buf-name (buffer-name)))
    (switch-to-buffer root-buf-name)
    (save-buffer)
    (switch-to-buffer this-buf-name)))

(defun df-push-changes-and-save-root ()
  (interactive)
  (progn
    (df-push-changes-to-parent-recursive)
    (df-save-root-buffer)))

(defun df-save ()
  (interactive)
  (df-push-changes-and-save-root)
  (not-modified)
  (message "Saved."))

;;;;;;;;;;;;;;;;;;;;;;
;; insert functions ;;
;;;;;;;;;;;;;;;;;;;;;;

(defun df-insert-entry ()
  (interactive)
  (let ((current-level (df-subtree-indentation)))
    (newline)
    (insert (make-string current-level ?\s) "- ")))

(defun df-insert-non-entry (&optional indent-size)
  (unless indent-size (setq indent-size df-default-indent-size))
  (interactive)
  (let ((current-level (df-subtree-indentation)))
    (newline)
    (insert (make-string (+ indent-size current-level) ?\s))))

;;;;;;;;;;;;;;;;;;;;;;
;; delete functions ;;
;;;;;;;;;;;;;;;;;;;;;;

(defun df-delete-subtree ()
  (interactive)
  (df-mark-subtree)
  (delete-region (region-beginning) (region-end))
  (forward-line -1)
  (end-of-line))

;;;;;;;;;;;;;;;;;;;;
;; mark functions ;;
;;;;;;;;;;;;;;;;;;;;

(defun df-mark-entry ()
  (interactive)
  (let ((next-entry
         (save-excursion
           (progn
             (end-of-line)
             (search-forward-regexp
              df-entry-identifier-regexp
              nil t)))))
    (set-mark (df-subtree-beginning))
    (if next-entry
        (progn (goto-char next-entry) (beginning-of-line))
      (goto-char (point-max)))))

(defun df-mark-subtree ()
  (interactive)
  (let ((next-subtree (df-subtree-ending (df-subtree-indentation))))
    (set-mark (df-subtree-beginning))
    (goto-char next-subtree)))

;;;;;;;;;;;;;;;;;;;;;;;
;; indent functionss ;;
;;;;;;;;;;;;;;;;;;;;;;;

(defun df-indent-region (beg end &optional indent-size)
  (unless indent-size (setq indent-size df-default-indent-size))
  (df-map-over-lines-in-region
   (lambda () (insert (make-string indent-size ?\s)))
   beg end))

(defun df-indent-entry (&optional indent-size)
  (interactive)
  (unless indent-size (setq indent-size df-default-indent-size))
  (let ((original-point (point)))
    (df-mark-entry)
    (df-indent-region (region-beginning) (region-end) indent-size)
    (goto-char (+ indent-size original-point))))

(defun df-indent-subtree (&optional indent-size)
  (interactive)
  (unless indent-size (setq indent-size df-default-indent-size))
  (let ((original-point (point)))
    (df-mark-subtree)
    (df-indent-region (region-beginning) (region-end))
    (goto-char (+ indent-size original-point))))

(defun df-indent-buffer (&optional indent-size)
  (interactive)
  (unless indent-size (setq indent-size df-default-indent-size))
  (save-excursion
    (goto-char (point-min))
    (while (< (point) (point-max))
      (df-indent-subtree indent-size)
      (df-goto-next-subtree-sibling))))

(defun df-indent-buffer-until-parent-is-level (level &optional indent-size)
  (save-excursion
    (goto-char (point-min))
    (while (< (df-subtree-indentation) level)
      (df-indent-buffer indent-size)
      (goto-char 0))))

;;;;;;;;;;;;;;;;;;;;;;;;
;; unindent functions ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(defun df-unindent-region (beg end &optional indent-size)
  (if (not indent-size) (setq indent-size df-default-indent-size))
  (df-map-over-lines-in-region
   (lambda ()
     (save-excursion
       (let ((e (progn (end-of-line) (point))))
         (beginning-of-line)
         (let ((indent-exists
                (progn
                  (search-forward (make-string indent-size ?\s) e t))))
           (beginning-of-line)
           (if indent-exists (delete-char indent-size) nil)))))
   beg end))

(defun df-unindent-entry (&optional indent-size)
  (interactive)
  (if (not indent-size) (setq indent-size df-default-indent-size))
  (let ((original-point (point)))
    (df-mark-entry)
    (df-unindent-region (region-beginning) (region-end) indent-size)
    (goto-char (- original-point indent-size))))

(defun df-unindent-subtree (&optional indent-size)
  (interactive)
  (if (not indent-size) (setq indent-size df-default-indent-size))
  (let ((original-point (point)))
    (df-mark-subtree)
    (df-unindent-region (region-beginning) (region-end) indent-size)
    (goto-char (- original-point indent-size))))

(defun df-unindent-buffer (&optional indent-size)
  (interactive)
  (if (not indent-size) (setq indent-size df-default-indent-size))
  (save-excursion
    (goto-char (point-min))
    (while (< (point) (point-max))
      (df-unindent-subtree indent-size)
      (df-goto-next-subtree-sibling))))

(defun df-unindent-buffer-until-parent-is-level-0 ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (df-unindent-buffer (df-subtree-indentation))))

;;;;;;;;;;;;;;;;;;;;;;
;; helper functions ;;
;;;;;;;;;;;;;;;;;;;;;;

(defun df-is-entry-line ()
  (let* ((e (save-excursion (end-of-line) (point)))
         (entry-marker
          (save-excursion
            (search-forward-regexp
             df-entry-identifier-regexp
             e t))))
    (if entry-marker t nil)))

(defun df-save-top-level-indentation ()
  (save-excursion
    (goto-char (point-min))
    (setq-local df-original-indentation-level (df-subtree-indentation))))

(defun df-map-over-lines-in-region (fn beg end)
  (let ((buf (current-buffer)))
    (with-temp-buffer
      (let ((tmp-buf (current-buffer)))
        (insert-buffer-substring buf beg end)
        (goto-char 0)
        (while (< (point) (point-max))
          (beginning-of-line)
          (funcall fn)
          (forward-line))
        (switch-to-buffer buf)
        (delete-region beg end)
        (goto-char beg)
        (insert-buffer-substring tmp-buf)
        (kill-buffer tmp-buf)))))

(defun df-ensure-empty-line-at-end ()
  (save-excursion
    (goto-char (point-max))
    (beginning-of-line)
    (if (< (point) (point-max))
        (progn
          (goto-char (point-max))
          (electric-indent-just-newline 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; navigation functions ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun df-goto-next-subtree-sibling ()
  (interactive)
  (df-mark-subtree)
  (deactivate-mark))

(defun df-goto-next-entry ()
  (interactive)
  (search-forward-regexp df-entry-identifier-regexp))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; formatting functions ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun df-fill-paragraph-entry ()
  (interactive)
  (let ((indent-level (df-subtree-indentation))
        (current-point (point))
        (original-point-max (point-max))
        (num-newlines-before-point-old (count-matches "\n" 0 (point) nil))
        (num-newlines-total-old (count-matches "\n" 0 (point-max) nil)))
    ;; Mark the entire entry.
    (df-mark-entry)
    (let* ((buf (current-buffer))
          (entry-b (region-beginning))
          (entry-e (region-end))

          ;; sub-b and sub-e represent the temporary beginning and end of the
          ;; next sub-region to be modified by fill-paragraph. Over the course
          ;; of one call to df-fill-paragraph, these values may be modified
          ;; multiple times. They represent points *after* the entry has been
          ;; unindented. They do not represent points in the original buffer,
          ;; but rather points in the temporary buffer.
          sub-b
          sub-e

          ;; done-flag is set to true once the entire entry has been processed.
          done-flag)
      (deactivate-mark)
      (goto-char entry-b)
      (while (not done-flag)
        (with-temp-buffer
          (let ((tmp-buf (current-buffer))
                next-sub-b
                new-entry-size)
            ;; Insert the entry from the main buffer being modified.
            (insert-buffer-substring buf entry-b entry-e)
            (goto-char (point-min))
            (df-unindent-buffer-until-parent-is-level-0)

            ;; If the beginning of a subregion has been set, move there.
            (if sub-b (goto-char sub-b))

            ;; Set sub-e according to the sub-region that we want to operate
            ;; on. This excludes:
            ;; - colons (:) followed immidiately by newlines
            ;; - code blocks indicated by triple backticks (```)
            ;;
            ;; If none of the exclusions are found, then set sub-e to the last
            ;; point in the buffer.
            (let* ((backticks "^ +```\n")
                   (colon ":\n")
                   (target-regexp (concat "\\(" backticks "\\|" colon "\\)"))
                   (backticks-posn (save-excursion (search-forward-regexp backticks nil t)))
                   (colon-posn (save-excursion (search-forward-regexp colon nil t)))
                   (target-posn (save-excursion (search-forward-regexp target-regexp nil t))))
              (if target-posn
                  (cond
                   ;; If the target is a triple backtick, then search for the
                   ;; closing set of triple backticks and set sub-b equal to the
                   ;; end of that location.
                   ((and backticks-posn (= target-posn backticks-posn))
                    (progn
                      ;; Set sub-e to the start of the backticks.
                      (save-excursion
                        (goto-char backticks-posn)
                        (search-backward-regexp backticks)
                        (setq sub-e (point)))

                      (save-excursion
                        ;; Go to the end of the first set of backticks.
                        (goto-char backticks-posn)
                        ;; Go to the end of the second set of backticks. If they
                        ;; don't exist, go to the last point in the buffer.
                        ;;
                        ;; Set next-sub-b equal to the current point.
                        (progn
                          (search-forward-regexp backticks nil t)
                          (setq next-sub-b (point))))))
                   ;; If the target is a colon followed by a newline, use that
                   ;; location without any further logic.
                   ((and colon-posn (= target-posn colon-posn))
                    (progn
                      (setq sub-e colon-posn)
                      (setq next-sub-b sub-e))))
                ;; If no target exists, then set sub-e equal to (point-max).
                (setq sub-e (point-max))))

            ;; Select the sub-region.
            (set-mark (point))
            (goto-char sub-e)

            ;; Call fill-paragraph on the selected sub-region.
            (fill-paragraph nil t)

            ;; If next-sub-b is set, then set sub-b to that value. Otherwise,
            ;; set it to sub-e.
            (setq sub-b (if next-sub-b next-sub-b sub-e))

            ;; Unset next-sub-b.
            (setq next-sub-b nil)

            ;; If sub-b equals point-max, then set done-flag to true.
            (if (= sub-b (point-max)) (setq done-flag t))

            ;; Re-indent the entire buffer.
            (df-indent-buffer-until-parent-is-level indent-level)

            ;; Save the point-max value in order to set the new entry-e value.
            (setq new-entry-size (point-max))

            ;; Replace the entry in the main buffer with the newly modified
            ;; contents of the temporary buffer.
            (switch-to-buffer buf)
            (delete-region entry-b entry-e)
            (goto-char entry-b)
            (insert-buffer-substring tmp-buf)

            ;; Update the entry's end point based on the newly formatted
            ;; text. This will be used if this entry is re-processed before the
            ;; function returns.
            (setq entry-e (+ entry-b new-entry-size -1))))))

    ;; Move the point forward based on the number of characters added to the
    ;; buffer, as well as the number of newlines formed in the process of
    ;; filling the paragraph.
    (let* ((new-point-max (point-max))
           (num-chars-added (- new-point-max original-point-max)))
      (goto-char current-point)
      (if (not (= new-point-max original-point-max))
          (let* ((num-newlines-before-point-new (count-matches "\n" 0 (point) nil))
                 (num-newlines-before-point-diff (- num-newlines-before-point-new num-newlines-before-point-old))
                 (num-newlines-total-new (count-matches "\n" 0 (point-max) nil))
                 (num-newlines-total-diff (- num-newlines-total-new num-newlines-total-old))
                 (num-chars-move-forward (/ (* num-chars-added num-newlines-before-point-diff)
                                            num-newlines-total-diff)))
            ;; Return the point back to (close to) the original point.
            (goto-char (+ current-point num-chars-move-forward)))))))
