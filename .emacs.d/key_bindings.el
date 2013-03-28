;;functions for inserting datetime with C-c C-d
;;from: http://stackoverflow.com/a/251922/85737
(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
       (insert ";; ")
       (insert (format-time-string current-date-time-format (current-time)))
       (insert "\n")
       )

(global-set-key "\C-c\C-d" 'insert-current-date-time)

;; THIS IS NOT WORKING IN OS X Terminal ;(
;; setting Super Hyper keys for the Mac keyboard, for emacs running in OS X
;; from: http://ergoemacs.org/emacs/emacs_hyper_super_keys.html
;; (setq mac-option-modifier 'super) ; sets the Option key as Super
;; (setq mac-command-modifier 'meta) ; sets the Command key as Meta
;; key bindings
(setq mac-command-modifier 'meta)
(setq ns-function-modifier 'super)


;;(global-set-key [kp-delete] 'delete-char)
;; sets fn-delete to be right-delete

