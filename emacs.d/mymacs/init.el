(setq user-full-name "Marcus Puchalla"
      user-mail-address "marcus.puchalla@gmail.com")
;; init GC after we allocated 20MB of memory
(setq gc-cons-threshold 20000000)
;; remove scroll/tool/menu bar
;;(if (fboundp 'scroll-bar-mode) (scroll-bar-mode 1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;; this loads the package manager
(require 'package)

;; add load path for custom scripts
(add-to-list 'load-path "~/.emacs.d/custom/")
;; tell emacs where to read abbrev
(setq abbrev-file-name "~/projects/emacs_abbrev_defs/general.abbrev.txt")
;; load org.el containing customizations for org-mode
;; uncomment this line will force the package repository to update
(load-library "installer")

;; load org mode and org customisations
(load-library "orgCfg")
(require 'org-compat)
;; On thy fly syntax checking (http://www.emacswiki.org/emacs/FlyMake)
;; ToDo: It'll work on os x only if you install flymake  through package-install-packages. Determine why package-require is not working.
(package-require 'flymake)
;;(require 'flymake)
;;(load-library "flymakeCfg")

;; load ido mode (interactivly do things :)
(load-library "idoCfg")

;; load printing module
(load-library "printingCfg")

;; load special rules for german umlaute 
(load-library "german")


;; load flyspell and aspell
(load-library "aspell")
;;chord (keyboard shortcuts without C-/M- modifiers)
(load-library "chord")

;; load fullscreen support by binding to f11
(load-library "fullscreen")

;; load shell support for C-!
(load-library "customizeShell")

;; controlLock to emulate holding down C key for easy navigation 
(load-library "controlLock")

;; smex, helper for most used commands
(load-library "smexCfg")

;; helm (command-completion-helper)
;;(progn (print 'starting helm search'))
(load-library "helmCfg")
;;(progn (print 'finish helm search'))

;; advanced commenting and more (toogle-comment)
;; taken from http://www.cbrunzema.de/download/ll-debug/ll-debug.el
(load-library "ll-debug")


;; os x specific - thanks to http://stackoverflow.com/questions/3376863/unable-to-type-braces-and-square-braces-in-emacs
(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gpg and authentication integration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'epa-file)
(epa-file-enable)
(setq epa-file-select-keys nil)
;; check OS type and load additional gpg path
(cond
 ((string-equal system-type "darwin")
  (progn
    (message "loading Mac OS X specific path settings")
    (add-to-list 'exec-path "/usr/local/bin")
    )))

(load-library "secrets")
(require 'secrets)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; Load custom configuartions for allday use ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(desktop-read)
;; Navigation contains loading of packages (goto-chg) that help moving around easier
(load-library "navigation")

;;use undo-tree
(package-require 'undo-tree)
(global-undo-tree-mode 1)

;; enable subword mode for all programming modes (treating camel case the right way)
(add-hook 'prog-mode-hook 'subword-mode)

(package-require 'lorem-ipsum)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load modes other/minor modes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;make other minor modes do not clutter the modeline
(package-require 'diminish)
;;(diminish 'wrap-region-mode)
;;(diminish 'yas/minor-mode)

;; rename-modeline to support diminish
(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))

;;(rename-modeline "js2-mode" js2-mode "JS2")
;;(rename-modeline "clojure-mode" clojure-mode "Clj")
;;(rename-modeline "global-undo-tree-mode" global-undo-tree-mode "uTr")
(rename-modeline "undo-tree-mode" undo-tree-mode "uTm")


; use allout minor mode to have outlining everywhere.
(allout-mode)
;;(type-break-mode)

;; enable for all programming modes
(add-hook 'prog-mode-hook 'subword-mode)

;; enable "tail -f" like view of log files (using auto-mode-alist)
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

;;uncomment to enable guru mode 
;;(package-require 'guru-mode)
;;(require 'guru-mode)
;;(guru-global-mode +1)

;;projectile
(package-require 'projectile)
(projectile-global-mode)
(setq projectile-indexing-method 'alien)
(setq projectile-switch-project-action 'projectile-dired)
(setq projectile-enable-caching t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set linux system  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Use the system clipboard
(setq x-select-enable-clipboard t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load/install other usefull packages that do not reqire a great amount of configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Inline auto completion and suggestions
;;(package-require 'flymake)

(package-require 'auto-complete)

(package-require 'git)
(package-require 'git-timemachine)
;;(package-require 'gist)
(package-require 'yagist)
(require 'yagist)
(package-require 'js2-mode)

;; git and magit (Magit rules!!!!)
(require 'git)
(package-require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "<f5>") 'magit-status)

;;taken from http://tullo.ch/articles/modern-emacs-setup/
(defadvice magit-status (around magit-fullscreen activate)
  "Make magit-status run alone in a frame."
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restore the previous window configuration and kill the magit buffer."
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))
 
(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

;;magit update recommendation
;;Note from update: Before running Git, Magit by default reverts all unmodified buffers which visit files tracked in the current repository. This can potentially lead to dataloss so you might want to disable this by adding the following line to your init file:
(setq magit-auto-revert-mode nil)

;;prevent magit update message 1.4
(setq magit-last-seen-setup-instructions "1.4.0")


;;we want global-auto-complete-mode to work everywhere but not in minibuffer
;;to do this we have to redeclare auto-complete-mode-maybe which is used by
;;global-auto-complete-mode
;; (defun auto-complete-mode-maybe ()
;;   "No maybe for you. Only AC!"
;;   (unless (minibufferp (current-buffer))
;;     (auto-complete-mode 1)))

;; turn on autocomplete globally 
;;(global-auto-complete-mode t)

(whitespace-mode)

; syntax highlighting everywhere
(global-font-lock-mode 1)

; Add proper word wrapping
(global-visual-line-mode t)

; enable org table minor mode
(add-hook 'message-mode-hook 'turn-on-orgtbl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; web mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'web-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;;turn auto indent on
(local-set-key (kbd "RET") 'newline-and-indent)

;; ;;smart parens
;; (defun my-web-mode-hook ()
;;   (setq web-mode-enable-auto-pairing nil))
;; (add-hook 'web-mode-hook 'my-web-mode-hook)
;; (defun sp-web-mode-is-code-context (id action context)
;;   (when (and (eq action 'insert)
;; 	     (not (or (get-text-property (point) 'part-side)
;; 		      (get-text-property (point) 'block-side)))) t))
;; (sp-local-pair 'web-mode "<" nil :when '(sp-web-mode-is-code-context))

;; (setq web-mode-ac-sources-alist
;;       '(("css" . (ac-source-css-property))
;; 	("html" . (ac-source-words-in-buffer ac-source-abbrev)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; web mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'php-mode)
;;(package-require 'php-completion)
(package-require 'php-eldoc)
(package-require 'php-extras)

;; use web and php mode at the same time
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; el doc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; smartparens
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'smartparens)
(require 'smartparens-config)
;; (package-require 'paredit)
;; (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
;; (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
;; (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
;; (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
;; (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
;; (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
;; (add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto install and auto-install components
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; auto install (http://www.emacswiki.org/emacs/AutoInstall)
;;(package-require 'auto-install)
;;(setq auto-install-directory "~/.emacs.d/auto-install/")
;;(auto-install-update-emacswiki-package-name t)
;;(auto-install-from-url "https://raw.github.com/aki2o/org-ac/master/org-ac.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; customize backup stategy 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist
      '(("." . "~/.local/share/emacs-saves"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom short function for all day use
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Jump backwards between windows
(defun other-window-backward (n)
  "Select Nth previous window."
  (interactive "p")
  (other-window (- n)))

;;bind switching between windows to SHIFT-UP/DOWN (super usefull!!!!)
(global-set-key [(shift down)] 'other-window)
(global-set-key [(shift up)] 'other-window-backward)

;; Font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; commenting
(global-set-key (kbd "C-x C-;") 'comment-region)
(global-set-key (kbd "C-x C-:") 'uncomment-region)

;;imenu for fast infile naviation
(global-set-key (kbd "C-c i") 'imenu)

;; cycle through buffers
(global-set-key (kbd "<C-tab>") 'bury-buffer)

;; quick line jump
(global-set-key (kbd "\e\el") 'goto-line)

;;show frame. May be deleted if not used.
(defun show-frame (&optional frame)
  "Show the current Emacs frame or the FRAME given as argument.

And make sure that it really shows up!"
  (raise-frame)
  ; yes, you have to call this twice. Don’t ask me why…
  ; select-frame-set-input-focus calls x-focus-frame and does a bit of
  ; additional magic.
  (select-frame-set-input-focus (selected-frame))
  (select-frame-set-input-focus (selected-frame)))

;; replace in region
(defun replace-regexp-in-region (start end)
  (interactive "*r")
  (save-excursion
    (save-restriction
      (let ((regexp (read-string "Regexp: "))
	    (to-string (read-string "Replacement: ")))
	(narrow-to-region start end)
	(goto-char (point-min))
	(while (re-search-forward regexp nil t)
	  (replace-match to-string nil nil))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TRAMP for president (switch to edit file as root on remote machines)
;; - you need to connect to a remote server and start view a file
;;   C-x C-f /ssh/remote_user@remote-host:/file/location/info.log
;; - if file is only writable by root and your remote_user has sudo priviledges then do
;;   M-x sudo-edit-current-file
;;   to reopen the file remotly as root user.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sudo-edit-current-file ()
  (interactive)
  (let ((my-file-name) ; fill this with the file to open
        (position))    ; if the file is already open save position
    (if (equal major-mode 'dired-mode) ; test if we are in dired-mode 
        (progn
          (setq my-file-name (dired-get-file-for-visit))
          (find-alternate-file (prepare-tramp-sudo-string my-file-name)))
      (setq my-file-name (buffer-file-name); hopefully anything else is an already opened file
            position (point))
      (find-alternate-file (prepare-tramp-sudo-string my-file-name))
      (goto-char position))))


(defun prepare-tramp-sudo-string (tempfile)
  (if (file-remote-p tempfile)
      (let ((vec (tramp-dissect-file-name tempfile)))

        (tramp-make-tramp-file-name
         "sudo"
         (tramp-file-name-user nil)
         (tramp-file-name-host vec)
         (tramp-file-name-localname vec)
         (format "ssh:%s@%s|"
                 (tramp-file-name-user vec)
                 (tramp-file-name-host vec))))
    (concat "/sudo:root@localhost:" tempfile)))

(define-key dired-mode-map [s-return] 'sudo-edit-current-file)

(setq tramp-default-method "ssh")

;;----------------------------------------------------
;; tramp root edit warning
;;----------------------------------------------------

(defvar find-file-root-prefix (if (featurep 'xemacs) "/[sudo/root@localhost]" "/sudo:root@localhost:" "/.*|sudo:root@" )
  "*The filename prefix used to open a file with `find-file-root'.")

(defvar find-file-root-history nil
  "History list for files found using `find-file-root'.")

(defvar find-file-root-hook nil
  "Normal hook for functions to run after finding a \"root\" file.")

(defun find-file-root ()
  "*Open a file as the root user.
   Prepends `find-file-root-prefix' to the selected file name so that it
   maybe accessed via the corresponding tramp method."

  (interactive)
  (require 'tramp)
  (let* ( ;; We bind the variable `file-name-history' locally so we can
	 ;; use a separate history list for "root" files.
	 (file-name-history find-file-root-history)
	 (name (or buffer-file-name default-directory))
	 (tramp (and (tramp-tramp-file-p name)
		     (tramp-dissect-file-name name)))
	 path dir file)

    ;; If called from a "root" file, we need to fix up the path.
    (when tramp
      (setq path (tramp-file-name-localname tramp)
	    dir (file-name-directory path)))

    (when (setq file (read-file-name "Find file (UID = 0): " dir path))
      (find-file (concat find-file-root-prefix file))
      ;; If this all succeeded save our new history list.
      (setq find-file-root-history file-name-history)
      ;; allow some user customization
      (run-hooks 'find-file-root-hook))))

(defface find-file-root-header-face
  '((t (:foreground "white" :background "red3")))
  "*Face use to display header-lines for files opened as root.")

(defun find-file-root-header-warning ()
  "*Display a warning in header line of the current buffer.
   This function is suitable to add to `find-file-root-hook'."
  (let* ((warning "WARNING: EDITING FILE AS ROOT!")
	 (space (+ 6 (- (window-width) (length warning))))
	 (bracket (make-string (/ space 2) ?-))
	 (warning (concat bracket warning bracket)))
    (setq header-line-format
	  (propertize  warning 'face 'find-file-root-header-face))))

(defun find-file-hook-root-header-warning ()
  (when (and buffer-file-name (string-match "root@localhost" buffer-file-name))
    (find-file-root-header-warning)))

(add-hook 'find-file-hook 'find-file-hook-root-header-warning)
(add-hook 'find-file-root-hook 'find-file-root-header-warning)

(global-set-key [(control x) (control r)] 'find-file-root)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; make some things shine brighter
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Highlight TODO and FIXME in comments 
(package-require 'fic-ext-mode)
(defun add-something-to-mode-hooks (mode-list something)
  "helper function to add a callback to multiple hooks"
  (dolist (mode mode-list)
    (add-hook (intern (concat (symbol-name mode) "-mode-hook")) something)))
(add-something-to-mode-hooks '(c++ tcl emacs-lisp python text markdown latex) 'fic-ext-mode)

;;;;;; tools & other misc
(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes 
                 '("\\.zip\\'" ".zip" "unzip")))

;; Require IEdit (e.g. rename variables)
(package-require 'iedit)

;;package typing for typing tests
(package-require 'typing)

;;; test jira
(package-require 'jira)
(require 'jira)

(setq jiralib-url "http://jira.app.activate.de") 
;; you need make sure whether the "/jira" at the end is 
;; necessary or not, see discussion at the end of this page

;;(package-require 'org-jira)
;;(require 'org-jira) 
;; jiralib is not explicitly required, since org-jira will load it.

;;;;;;;;;; custom functions
(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

(defun uniquify-region-lines (beg end)
  "Remove duplicate adjacent lines in region."
  (interactive "*r")
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "^\\(.*\n\\)\\1+" end t)
      (replace-match "\\1"))))

(defun uniquify-buffer-lines ()
  "Remove duplicate adjacent lines in the current buffer."
  (interactive)
  (uniquify-region-lines (point-min) (point-max)))

;;move lines up/down (taken from http://emacsredux.com/blog/2013/04/02/move-current-line-up-or-down/)
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))
(global-set-key [(control shift up)]  'move-line-up)
(global-set-key [(control shift down)]  'move-line-down)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Wordpress integration 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'xml-rpc)
(package-require 'metaweblog)
(package-require 'org2blog)
(package-require 'htmlize)

(require 'org2blog-autoloads)
(require 'netrc)
(setq auth-sources '("~/.authinfo"))

(setq debug-on-error t)
(setq wp-0xcb0 (netrc-machine (netrc-parse "~/.netrc") "wp-0xcb0" t))

;; (setq
;;  org2blog/wp-confirm-post t
;;  org2blog/wp-blog-alist
;;  `(
;;    ("0xcb0"
;;     :url "http://www.0xcb0.com/xmlrpc.php"
;;     :username ,0xcb0-username
;;     :password ,0xcb0-password
;;     :default-title "Hello, World!"
;;     :default-categories ("Uncategorized")
;;     :tags-as-categories nil)
;;     ))

(setq org2blog/wp-use-sourcecode-shortcode 't)
;; removed light="true"
(setq org2blog/wp-sourcecode-default-params nil)
;; target language needs to be in here
(setq org2blog/wp-sourcecode-langs
      '("actionscript3" "bash" "coldfusion" "cpp" "csharp" "css" "delphi"
        "erlang" "fsharp" "diff" "groovy" "javascript" "java" "javafx" "matlab"
        "objc" "perl" "php" "text" "powershell" "python" "ruby" "scala" "sql"
        "vb" "xml"
        "sh" "emacs-lisp" "lisp" "lua"))

;; this will use emacs syntax higlighting in your #+BEGIN_SRC
;; <language> <your-code> #+END_SRC code blocks.
(setq org-src-fontify-natively t)

;; (package-require 'anything)
;; (package-require 'anything-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Markdown integration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'markdown-mode)

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Themes/Appereance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'zenburn-theme)
(load-theme 'zenburn t)

;; some other tests
(package-require 'on-screen)
(require 'on-screen)
(on-screen-global-mode +1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multiple-cursors
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'multiple-cursors)
(require 'multiple-cursors)
(global-set-key (kbd "C-M-m M-m") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; web-mode tryout as described here http://truongtx.me/2014/07/22/setup-php-development-environment-in-emacs/)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'web-mode)
(package-require 'emmet-mode)
(require 'web-mode)

(defun my-setup-php ()
  ;; enable web mode
  (web-mode)

  ;; make these variables local
  (make-local-variable 'web-mode-code-indent-offset)
  (make-local-variable 'web-mode-markup-indent-offset)
  (make-local-variable 'web-mode-css-indent-offset)

  ;; set indentation, can set different indentation level for different code type
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
;;  (flycheck-select-checker my-php)
  (flycheck-mode t))

(add-to-list 'auto-mode-alist '("\\.php$" . my-setup-php))

;; flycheck for php files
(package-require 'flycheck)
(require 'flycheck)

(package-require 'exec-path-from-shell)

;; redefine flycheck to work inside web-mode
;; (flycheck-define-checker my-php
;;   "A PHP syntax checker using the PHP command line interpreter.

;; See URL `http://php.net/manual/en/features.commandline.php'."
;;   :command ("php" "-l" "-d" "error_reporting=E_ALL" "-d" "display_errors=1"
;;             "-d" "log_errors=0" source)
;;   :error-patterns
;;   ((error line-start (or "Parse" "Fatal" "syntax") " error" (any ":" ",") " "
;;           (message) " in " (file-name) " on line " line line-end))
;;   :modes (php-mode php+-mode web-mode))

;; (setq web-mode-ac-sources-alist
;;       '(("css" . (ac-source-words-in-buffer ac-source-css-property))
;;         ("html" . (ac-source-words-in-buffer ac-source-abbrev))
;;         ("php" . (ac-source-words-in-buffer
;;                   ac-source-words-in-same-mode-buffers
;;                   ac-source-dictionary))))
(package-require 'yasnippet)
(package-require 'elscreen)
(define-key global-map (kbd "C-c C-c") 'elscreen-create)
(define-key global-map (kbd "C-c C-<right>") 'elscreen-next)
(define-key global-map (kbd "C-c C-<left>") 'elscreen-previous)
(define-key global-map (kbd "C-c C-k") 'elscreen-kill)

;; Ace jump
(package-require 'ace-jump-mode)
(define-key global-map (kbd "C-c j") 'ace-jump-mode) 

(package-require 'git-gutter-fringe+)
(require 'git-gutter-fringe+)
(git-gutter+-toggle-fringe)
(setq global-git-gutter+-mode t)
(package-require 'git-link)

;; add discovery mode (http://www.masteringemacs.org/article/discoverel-discover-emacs-context-menus)
(package-require 'discover)
(global-discover-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; resize window
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<up>") 'shrink-window)
(global-set-key (kbd "S-C-<down>") 'enlarge-window)




;; rst
(defun rst-validate-buffer ()
  "Tests to see if buffer is valid reStructured Text."
  (interactive)
  (if (eq major-mode 'rst-mode)         ; only runs in rst-mode
      (let ((name (buffer-name))
            (filename (buffer-file-name)))
        (cond
         ((not (file-exists-p "/usr/bin/rst2pseudoxml")) ; check that the program used to process file is present
              (error "Docutils programs not available."))
         ((not (file-exists-p filename)) ; check that the file of the buffer exists
              (error "Buffer '%s' is not visiting a file!" name))
         (t                             ; ok, process the file, producing pseudoxml output
          (let* ((pseudoxml (split-string (shell-command-to-string (concat "rst2pseudoxml " filename)) "\n"))
                 (firstline (car pseudoxml)) ; take first line of output
                 (lastline (nth (- (length pseudoxml) 2) pseudoxml))) ; take last line of output text
            (if (or (string-match "ERROR/" firstline)
                    (string-match "WARNING/" firstline)
                    ;; for reasons I don't understand, sometimes the warnings/errors are at the end of output
                    (string-match "ERROR/" lastline)
                    (string-match "WARNING/" lastline))
                (progn (ding)
                       (message "There's an problem in this buffer."))
              (message "Buffer is valid reStructured Text."))))))))

(add-hook 'rst-mode-hook
          (lambda()
	    (add-hook 'after-save-hook 'rst-validate-buffer)))


;; nXml mode folding
(require 'hideshow)
(require 'sgml-mode)
(require 'nxml-mode)

(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "<!--\\|<[^/>]*[^/]>"
               "-->\\|</[^/>]*[^/]>"

               "<!--"
               sgml-skip-tag-forward
               nil))



(add-hook 'nxml-mode-hook 'hs-minor-mode)

;; optional key bindings, easier than hs defaults
(define-key nxml-mode-map (kbd "C-c h") 'hs-toggle-hiding)

;; correct the umlaute problem \334 etc.
;;(standard-display-european 1)

(package-require 'sql-indent)
 (eval-after-load "sql"
      (load-library "sql-indent"))

;;;; eShell section from http://www.howardism.org/Technical/Emacs/eshell-fun.html
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-!") 'eshell-here)

(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))

;;
(global-set-key (kbd "C-=") 'er/expand-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;copy line  from http://www.emacswiki.org/emacs/CopyingWholeLines
(defun copy-line (arg)
    "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Move to start of next line.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
    (interactive "p")
    (let ((beg (line-beginning-position))
          (end (line-end-position arg)))
      (when mark-active
        (if (> (point) (mark))
            (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
          (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
      (if (eq last-command 'copy-line)
          (kill-append (buffer-substring beg end) (< end beg))
        (kill-ring-save beg end)))
    (kill-append "\n" nil)
    (beginning-of-line (or (and arg (1+ arg)) 2))
    (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

(global-set-key (kbd "C-c C-a") 'copy-line)

;; yasnippets
(package-require 'yasnippet)
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"               ;; personal snippets
        "~/projects/yasnippet-snippets"     ;; the default collection
        ))
(yas-reload-all)
(yas-global-mode 1)

;; yasnippets
;; Completing point by some yasnippet key
(defun yas-ido-expand ()
  "Lets you select (and expand) a yasnippet key"
  (interactive)
    (let ((original-point (point)))
      (while (and
              (not (= (point) (point-min) ))
              (not
               (string-match "[[:space:]\n]" (char-to-string (char-before)))))
        (backward-word 1))
    (let* ((init-word (point))
           (word (buffer-substring init-word original-point))
           (list (yas-active-keys)))
      (goto-char original-point)
      (let ((key (remove-if-not
                  (lambda (s) (string-match (concat "^" word) s)) list)))
        (if (= (length key) 1)
            (setq key (pop key))
          (setq key (ido-completing-read "key: " list nil nil word)))
        (delete-char (- init-word original-point))
        (insert key)
        (yas-expand)))))

(define-key yas-minor-mode-map (kbd "<C-tab>")     'yas-ido-expand)

;; force UTF8 everywhere
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)


;; display german calendar week
;; (thanks to http://stackoverflow.com/questions/21364948/how-to-align-the-calendar-with-week-number-as-the-intermonth-text)
(setq calendar-week-start-day 1)
(setq calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'font-lock-warning-face))
(setq calendar-intermonth-header
      (propertize "KW" 'font-lock-face 'font-lock-keyword-face))

;; versor setup
;; (add-to-list 'load-path "/home/mpuchalla/projects/emacs-versor/lisp/path/to/versor/lisp")

;; (require 'versor)
;; (require 'languide)

;; (versor-setup)

;; Screensaver command
(defvar screensaver-command "xscreensaver-command -lock")
(defun activate-screen-saver ()
  (interactive)
  (shell-command screensaver-command))
(global-set-key (kbd "C-c C-x C-s") 'activate-screen-saver)


;;modes that look interesting but there is so less time
;;https://github.com/ShingoFukuyama/helm-swoop
(package-require 'rainbow-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cl and slime 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'slime)
(package-require 'ac-slime)
