; Activate org-mode
(require 'org)

; http://orgmode.org/guide/Activation.html#Activation

; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

; And add babel inline code execution
; babel, for executing code in org-mode.
(org-babel-do-load-languages
 'org-babel-load-languages
 ; load all language marked with (lang . t).
 '((C . t)
   (R . t)
   (asymptote)
   (awk)
   (calc)
   (clojure)
   (comint)
   (css)
   (ditaa . t)
   (dot . t)
   (emacs-lisp . t)
   (fortran)
   (gnuplot . t)
   (haskell)
   (io)
   (java)
   (js)
   (latex)
   (ledger)
   (lilypond)
   (lisp)
   (matlab)
   (maxima)
   (mscgen)
   (ocaml)
   (octave)
   (org . t)
   (perl)
   (picolisp)
   (plantuml)
   (python . t)
   (ref)
   (ruby)
   (sass)
   (scala)
   (scheme)
   (screen)
   (sh . t)
   (shen)
   (sql)
   (sqlite)))
;;set org diretrory to owncloud sync
(setq org-directory "~/ownCloud/org")
; and some more org stuff
(setq org-list-allow-alphabetical t)

(setq org-todo-keywords
      '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;; add a timestamp when we close an item
(setq org-log-done t)
;; include a closing note when close an todo item
(setq org-log-done 'note)

;;(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
;;(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; (eval-after-load "org"
;;   '(progn
;;      (define-prefix-command 'org-todo-state-map)

;;      (define-key org-mode-map "\C-cx" 'org-todo-state-map)

;;      (define-key org-todo-state-map "x"
;;        #'(lambda nil (interactive) (org-todo "CANCELLED")))
;;      (define-key org-todo-state-map "d"
;;        #'(lambda nil (interactive) (org-todo "DONE")))
;;      (define-key org-todo-state-map "f"
;;        #'(lambda nil (interactive) (org-todo "DEFERRED")))
;;      (define-key org-todo-state-map "l"
;;        #'(lambda nil (interactive) (org-todo "DELEGATED")))
;;      (define-key org-todo-state-map "s"
;;        #'(lambda nil (interactive) (org-todo "STARTED")))
;;      (define-key org-todo-state-map "w"
;;        #'(lambda nil (interactive) (org-todo "WAITING")))

;;      (define-key org-agenda-mode-map "\C-n" 'next-line)
;;      (define-key org-agenda-keymap "\C-n" 'next-line)
;;      (define-key org-agenda-mode-map "\C-p" 'previous-line)
;;      (define-key org-agenda-keymap "\C-p" 'previous-line)))

(custom-set-variables 
 '(org-agenda-files (quote ("~/todo.org")))
 '(org-default-notes-file "~/notes.org")
 '(org-agenda-ndays 7)
 '(org-deadline-warning-days 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-reverse-note-order t)
 '(org-fast-tag-selection-single-key (quote expert)))

(global-set-key "\C-cr" 'org-capture)

;; Org Capture
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "/gtd.org") "Tasks")
         "* TODO %?\n %i\n")
        ("l" "Link" plain (file (concat org-directory "/links.org"))
         "- %?\n %x\n")))


;; (custom-set-variables
;;  '(org-agenda-files (quote ("~/todo.org")))
;;  '(org-default-notes-file "~/notes.org")
;;  '(org-agenda-ndays 7)
;;  '(org-deadline-warning-days 14)
;;  '(org-agenda-show-all-dates t)
;;  '(org-agenda-skip-deadline-if-done t)
;;  '(org-agenda-skip-scheduled-if-done t)
;;  '(org-agenda-start-on-weekday nil)
;;  '(org-reverse-note-order t)
;;  '(org-fast-tag-selection-single-key (quote expert))
;;  '(org-agenda-custom-commands
;;    (quote (("d" todo "DELEGATED" nil)
;; 	   ("c" todo "DONE|DEFERRED|CANCELLED" nil)
;; 	   ("w" todo "WAITING" nil)
;; 	   ("W" agenda "" ((org-agenda-ndays 21)))
;; 	   ("A" agenda ""
;; 	    ((org-agenda-skip-function
;; 	      (lambda nil
;; 		(org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
;; 	     (org-agenda-ndays 1)
;; 	     (org-agenda-overriding-header "Today's Priority #A tasks: ")))
;; 	   ("u" alltodo ""
;; 	    ((org-agenda-skip-function
;; 	      (lambda nil
;; 		(org-agenda-skip-entry-if (quote scheduled) (quote deadline)
;; 					  (quote regexp) "\n]+>")))
;; 	     (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
;;  '(org-remember-store-without-prompt t)
;;  '(org-remember-templates
;;    (quote ((116 "* TODO %?\n  %u" "~/todo.org" "Tasks")
;; 	   (110 "* %u %?" "~/notes.org" "Notes"))))
;;  '(remember-annotation-functions (quote (org-remember-annotation)))
;;  '(remember-handler-functions (quote (org-remember-handler))))

(package-require 'org-ac)

;; To save the clock history across Emacs sessions:
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-continuously t)

;; we want some non standard todo types
(setq org-todo-keywords
      '((sequence
	 "TODO" "BUG" "WAIT_FOR_FEEDBACK" "FIXED" "TO_BE_MERGE" "MERGED" "WAIT" "|" "CANCELED" "DONE")))

(setq org-todo-keyword-faces
      '(("TODO" :background "red1" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
	("BUG" :background "red1" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
	("WAIT_FOR_FEEDBACK" :background "yellow" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
	("FIXED" :background "orange" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
	("TO_BE_MERGE" :background "gold" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
	("MERGED" :background "gold" :foreground "grey" :weight bold :box (:line-width 2 :style released-button))
	("WAIT" :background "gray" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
	("DONE" :background "forest green" :weight bold :box (:line-width 2 :style released-button))
	("CANCELLED" :background "lime green" :foreground "black" :weight bold :box (:line-width 2 :style released-button))))
