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

;;Shortcut for insert of current datetime as comment
(global-set-key "\C-c\C-d" 'insert-current-date-time)

;; use command key as super <- not quite sure if this will work
(setq mac-command-modifier 'super)
;; Use the fn key as meta
(setq ns-function-modifier 'meta)
;; This is needed to use ALT key for OS X specific keys access like [ or |
(setq ns-alternate-modifier nil)
