;;;; BACKUP SECTION START
;;Save all backup files to /tmp instead of current directory
;;just testing again
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;;Remove backuped temp files that haven't been accessed in a week
(defun fifth (x)
  (car (cdr (cdr (cdr (cdr x))))))

(message "Deleting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files temporary-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (fifth (file-attributes file))))
                  week))
      (message "%s" file)
      (delete-file file))))

;;Backup the file after every save
(require 'backup-each-save)
    (add-hook 'after-save-hook 'backup-each-save)
    (defun backup-each-save-filter (filename)
      (let ((ignored-filenames
	      '("^/tmp" "semantic.cache$" "\\.emacs-places$"
		   "\\.recentf$" ".newsrc\\(\\.eld\\)?"))
	    (matched-ignored-filename nil))
        (mapc
         (lambda (x)
           (when (string-match x filename)
	      (setq matched-ignored-filename t)))
         ignored-filenames)
        (not matched-ignored-filename)))
    (setq backup-each-save-filter-function 'backup-each-save-filter)
 
;;;; BACKUP SECTION END
