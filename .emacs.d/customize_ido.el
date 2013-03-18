(require 'ido)
(ido-mode t)

(custom-set-variables
 ;; If there is more than one, they won't work right.
 '(ido-enable-flex-matching t))
(custom-set-faces
 ;; If there is more than one, they won't work right.
 )

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

;;Sort files by mtime
;;Why would anyone want an alphabetically sorted list? You can save keystrokes if the most recently modified files are at the front:
;; sort ido filelist by mtime instead of alphabetically
(defun sixth (lst)
  (car (cdr (cdr (cdr (cdr (cdr lst)))))))

(add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
(add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
(defun ido-sort-mtime ()
  (setq ido-temp-list
        (sort ido-temp-list
              (lambda (a b)
                (time-less-p
                 (sixth (file-attributes (concat ido-current-directory b)))
                 (sixth (file-attributes (concat ido-current-directory a)))))))
  (ido-to-end  ;; move . files to end (again)
   (delq nil (mapcar
              (lambda (x) (and (char-equal (string-to-char x) ?.) x))
              ido-temp-list))))

;;Make the M-x ido compatible
;;from: http://emacswiki.org/emacs/InteractivelyDoThings
(global-set-key
     "\M-x"
     (lambda ()
       (interactive)
       (call-interactively
        (intern
         (ido-completing-read
          "M-x "
          (all-completions "" obarray 'commandp))))))
