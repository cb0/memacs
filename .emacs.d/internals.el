;;;; BACKUP SECTION START
;;Save all backup files to /tmp instead of current directory
;;from: http://emacswiki.org/emacs/BackupDirectory
;(defconst memacs_backup_directory )

(setq
   backup-by-copying-when-linked t      ; don't clobber symlinks
   backup-directory-alist '(("~/.emacs_backup_files"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)

;;Remove backuped temp files that haven't been accessed in a week
;;from: http://www.emacswiki.org/emacs/BackupDirectory
;;defined function 'fifth' because my emacs wasn't able to find it. I'm not quite sure if there is such a function in CL.
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
;;from: http://www.emacswiki.org/emacs/BackupEachSave
;;reuqires backup-each-save.el file in .emacs.d. File taken from http://www.emacswiki.org/emacs-de/backup-each-save.el from http://www.emacswiki.org/emacs-de/backup-each-save.el
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
