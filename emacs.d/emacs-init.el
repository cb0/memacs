(setq user-full-name "Marcus Puchalla"
      user-mail-address "marcus.puchalla@gmail.com")

(setenv "PATH" (concat (getenv "PATH") ":/Users/tk/.ghcup/bin"))
(setq exec-path (append exec-path '("/Users/tk/.ghcup/bin")))
(getenv "PATH")

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
     that used by the user's shell.

     This is particularly useful under Mac OS X and macOS, where GUI
     apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "$SHELL --login -c 'echo $PATH'"
					  ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

(setq ns-right-alternate-modifier (quote nil))
(setq ns-option-modifier      nil
      ns-right-option-modifer 'meta)
(setq mac-command-modifier 'meta)
(set-keyboard-coding-system nil)

(defun ask-before-closing ()
  "Close only if y was pressed."
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to close this frame? "))
      (save-buffers-kill-emacs)                                                                                            
    (message "Canceled frame close")))

(when (daemonp)
  (global-set-key (kbd "C-x C-c") 'ask-before-closing))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Make german umlauts work.
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(require 'use-package)

(require 'cl-lib)

		    (require 'loadhist)
		    ;; (file-dependents (feature-file 'cl))

;;		    (file-dependents (feature-file 'yaxception))
;;     ("/home/cb0/.emacs.d/elpa/auto-complete-pcmp-20140227.651/auto-complete-pcmp.elc" "/home/cb0/.emacs.d/elpa/org-ac-20170401.1307/org-ac.elc" ;;"/home/cb0/projects/memacs/emacs.d/elpa/auto-complete-pcmp-20140303.255/auto-complete-pcmp.el")

;;	  ("/home/cb0/.emacs.d/elpa/yaxception-20150105.1452/yaxception.elc" "/home/cb0/projects/memacs/emacs.d/elpa/yaxception-20150105.1540/yaxception.el" ;;"/home/cb0/projects/memacs/emacs.d/elpa/yaxception-20150105.1540/yaxception.elc" ;;"/home/cb0/projects/memacs/emacs.d/elpa/auto-complete-pcmp-20140303.255/auto-complete-pcmp.el")

(require 'package)

     ;; use packages from marmalade
     ;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
     ;;the orgmode elpa
     (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
     ;; and the old elpa repo
     ;;(add-to-list 'package-archives '("elpa-old" . "http://tromey.com/elpa/"))

     ;; and automatically parsed versiontracking repositories.
     ;;(add-to-list 'package-archives '("melpa" . "http://melpa.org"))

(setq package-enable-at-startup nil)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/"))
 (add-to-list 'package-archives
         '("gnu" . "http://elpa.gnu.org/packages/"))

;; Make sure a package is installed
(defun package-require (package)
  "Install a PACKAGE unless it is already installed
or a feature with the same name is already active.

Usage: (package-require 'package)"
  ; try to activate the package with at least version 0.
  (package-activate package '(0))
  ; try to just require the package. Maybe the user has it in his local config
  (condition-case nil
      (require package)
    ; if we cannot require it, it does not exist, yet. So install it.
    (error (package-install package))))

;; Initialize installed packages
;;(package-initialize)
;; package init not needed, since it is done anyway in emacs 24 after reading the init
;; but we have to load the list of available packages
(unless package-archive-contents
  (package-refresh-contents))

(setq package-load-list '(all))

(unless (package-installed-p 'org)  ;; Make sure the Org package is
  (package-install 'org))           ;; installed, install it if not
;;(package-initialize)

(package-require 'use-package)

(package-require 'esup)

(global-set-key (kbd "C-c M-l") 'locked-buffer-mode)

(define-minor-mode locked-buffer-mode
  "Make the current window always display this buffer."
  nil " locked" nil
  (set-window-dedicated-p (selected-window) locked-buffer-mode))

(package-require 'which-key)
;; add minor mode to show help
(which-key-mode)
;; slide in from right side if there is enough space there
(which-key-setup-side-window-right-bottom)

(package-require 'hydra)

(cond
 ((not (string-equal system-type "darwin"))
  (progn
    (package-require 'exwm))))

(defun efs/exwm-update-class ()
     (exwm-workspace-rename-buffer exwm-class-name))

   (defun efs/exwm-update-title ()
     (pcase exwm-class-name
       ("Google-chrome" (exwm-workspace-rename-buffer (format "Chrome %s" exwm-title)))))

(defun efs/configure-window-by-class ()
  (interactive)
  (pcase exwm-class-name
    ("Chrome" (exwm-workspace-move-window 1))
    ("Firefox" (exwm-workspace-move-window 2))
    ("webstorm" (exwm-workspace-move-window 3))
    ("thunderbird" (exwm-workspace-move-window 3))
    ("TelegramDesktop" (exwm-workspace-move-window 0))))

(require 'exwm)

(setq exwm-workspace-number 5)

;; example config to be revmoed soon
(require 'exwm-config)

;; simple system tray
(require 'exwm-systemtray)
(exwm-systemtray-enable)

(setq exwm-systemtray-height 32)

;; use char mode on startup
(setq exwm-manage-configurations '((t char-mode t)))

;; All buffers created in EXWM mode are named "*EXWM*". You may want to
;; change it in `exwm-update-class-hook' and `exwm-update-title-hook', which
;; are run when a new X window class name or title is available.  Here's
;; some advice on this topic:
;; + Always use `exwm-workspace-rename-buffer` to avoid naming conflict.
;; + For applications with multiple windows (e.g. GIMP), the class names of
;    all windows are probably the same.  Using window titles for them makes
;;   more sense.
;; In the following example, we use class names for all windows except for
;; Java applications and GIMP.
(add-hook 'exwm-update-class-hook
	  (lambda ()
	    (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
			(string= "gimp" exwm-instance-name))
	      (exwm-workspace-rename-buffer exwm-class-name))))

(add-hook 'exwm-update-title-hook
	  (lambda ()
	    (when (or (not exwm-instance-name)
		      (string-prefix-p "sun-awt-X11-" exwm-instance-name)
		      (string= "gimp" exwm-instance-name))
	      (exwm-workspace-rename-buffer exwm-title))))

(add-hook 'exwm-update-class-hook #'efs/exwm-update-class)
(add-hook 'exwm-update-title-hook #'efs/exwm-update-title)
(add-hook 'exwm-manage-finish-hook #'efs/configure-window-by-class)

(exwm-config-example)
(exwm-enable)

(setq exwm-input-simulation-keys
 '(([?\C-b] . [left])
   ([?\C-f] . [right])
   ([?\C-p] . [up])
   ([?\C-n] . [down])
   ([?\C-a] . [home])
   ([?\C-e] . [end])
   ([?\M-v] . [prior])
   ([?\C-v] . [next])
   ([?\C-d] . [delete])
   ([?\C-k] . [S-end delete])))


;using xim input
(require 'exwm-xim)

(exwm-xim-enable)
;;(exwm-xim--exit)

(setq exwm-input-prefix-keys
      '(?\C-x
	?\C-u
	?\C-h	   
	?\M-x
	?\M-`
	?\M-&
	?\M-:
	?\C-\\
	?\C-\M-j
	?\C-\ ))

;; (push ?\C-\\ exwm-input-prefix-keys)   ;; use Ctrl + \ to switch input method

;; get workspace list in bar
;; (defun feb/exwm-workspace-list ()
;;   "Return a lemonbar string showing workspace list."
;;   (let* ((num (exwm-workspace--count))
;; 	 (sequence (number-sequence 0 (1- num)))
;; 	 (curr (exwm-workspace--position exwm-workspace--current)))
;;     (mapconcat (lambda (i)
;; 		 (format (if (= i curr) "[%%{F#00ff00}%d%%{F-}] " "%d ") i))
;; 	       sequence "")
;;     ))

;; (defun feb/exwm-report-workspaces-to-lemonbar ()
;;   (with-temp-file "/tmp/panel-fifo"
;;   (insert (format "WIN%s\n" (feb/exwm-workspace-list)))))

;;  (add-hook 'exwm-workspace-switch-hook #'feb/exwm-report-workspaces-to-lemonbar)
;;  (add-hook 'exwm-init-hook #'feb/exwm-report-workspaces-to-lemonbar)

;; (defun efs/run-in-background (command)
;;   (let ((command-parts (split-string command "[ ]+")))
;;     (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

(defun dw/exwm-init-hook ()
  ;; Make workspace 1 be the
  ;; one where we land at startup
  (exwm-workspace-switch-create 1)

  ;; Open eshell by default
  ;;(eshell)

  ;; Launch apps that will run in the background
  (efs/run-in-background "nm-applet"))

;; (add-hook 'exwm-init-hook #'efs/after-exwm-init)

;; (efs/run-in-background "pavucontrol")	
;; (efs/run-in-background "blueman-applet")

;; from https://config.daviwil.com/desktop
   ;; Hide the modeline on all X windows
   (add-hook 'exwm-floating-setup-hook
	     (lambda ()
	       (exwm-layout-hide-mode-line)))

;; Ctrl+Q will enable the next key to be sent directly
(define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

;; (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
;; (add-to-list 'default-frame-alist '(alpha . (90 . 90)))
;; (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))

(display-battery-mode 1)

(setq display-time-day-and-date t)
(setq display-time-format "%H:%M")
(display-time-mode 1)

(exwm-input-set-key (kbd "s-SPC") 'counsel-linux-app)
(exwm-input-set-key (kbd "s-f") 'exwm-layout-toggle-fullscreen)

(package-require 'enwc)
(setq enwc-default-backend 'nm)
;;(condition-case nil			
;;    (enwc)
;;  (error nil))

(cond
 ((not (string-equal system-type "darwin"))
  (progn

    (add-to-list 'load-path "~/.emacs.d/lib/desktop-environment/")
    (require 'desktop-environment)

    (use-package desktop-environment
      :after exwm
      :config (desktop-environment-mode)
      :custom
      (desktop-environment-brightness-small-increment "2%+")
      (desktop-environment-brightness-small-decrement "2%-")
      (desktop-environment-brightness-normal-increment "5%+")
      (desktop-environment-brightness-normal-decrement "5%-")
      (desktop-environment-screenshot-command "flameshot gui"))



    ;; This needs a more elegant ASCII banner
    (defhydra hydra-exwm-move-resize (:timeout 4)
      "Move/Resize Window (Shift is bigger steps, Ctrl moves window)"
      ("j" (lambda () (interactive) (exwm-layout-enlarge-window 10)) "V 10")
      ("J" (lambda () (interactive) (exwm-layout-enlarge-window 30)) "V 30")
      ("k" (lambda () (interactive) (exwm-layout-shrink-window 10)) "^ 10")
      ("K" (lambda () (interactive) (exwm-layout-shrink-window 30)) "^ 30")
      ("h" (lambda () (interactive) (exwm-layout-shrink-window-horizontally 10)) "< 10")
      ("H" (lambda () (interactive) (exwm-layout-shrink-window-horizontally 30)) "< 30")
      ("l" (lambda () (interactive) (exwm-layout-enlarge-window-horizontally 10)) "> 10")
      ("L" (lambda () (interactive) (exwm-layout-enlarge-window-horizontally 30)) "> 30")
      ("C-j" (lambda () (interactive) (exwm-floating-move 0 10)) "V 10")
      ("C-S-j" (lambda () (interactive) (exwm-floating-move 0 30)) "V 30")
      ("C-k" (lambda () (interactive) (exwm-floating-move 0 -10)) "^ 10")
      ("C-S-k" (lambda () (interactive) (exwm-floating-move 0 -30)) "^ 30")
      ("C-h" (lambda () (interactive) (exwm-floating-move -10 0)) "< 10")
      ("C-S-h" (lambda () (interactive) (exwm-floating-move -30 0)) "< 30")
      ("C-l" (lambda () (interactive) (exwm-floating-move 10 0)) "> 10")
      ("C-S-l" (lambda () (interactive) (exwm-floating-move 30 0)) "> 30")
      ("f" nil "finished" :exit t))



    ;; Workspace switching
    (setq exwm-input-global-keys	   
	  `(;; reset to line mode (C-c C-k switch to char mode)
	    ([?\s-\C-r] . exwm-reset)
	    ;; switch workspaces
	    ([?\s-w] . exwm-workspace-switch)
	    ;; hydro to rresize windows
	    ([?\s-r] . hydra-exwm-move-resize/body)
	    ;; quick jump to current directory
	    ([?\s-e] . dired-jump)
	    ;; quick jump to home directory
	    ([?\s-E] . (lambda () (interactive) (dired "~")))

	    ([?\s-Q] . (lambda () (interactive) (kill-buffer)))
	    ([?\s-`] . (lambda () (interactive) (exwm-workspace-switch-create 0)))
	    ([?\s-&] . (lambda (command)
			 (interactive (list (read-shell-command "$ ")))
			 (start-process-shell-command command nil command)))
	    ([?\C-\s-l] . (lambda ()
			    (interactive)
			    (start-process "" nil "/usr/bin/slock")))
	    ,@(mapcar (lambda (i)
			`(,(kbd (format "s-%d" i)) .
			  (lambda ()
			    (interactive)
			    (exwm-workspace-switch-create ,i))))
		      (number-sequence 0 9))))

    ;; setting these in exwm-input-global-keys does not work
    (exwm-input-set-key (kbd "s-<left>") 'windmove-left)
    (exwm-input-set-key (kbd "s-<right>") 'windmove-right)
    (exwm-input-set-key (kbd "s-<up>") 'windmove-up)
    (exwm-input-set-key (kbd "s-<down>") 'windmove-down)

    (exwm-input-set-key (kbd "S-s-<down>") 'windmove-swap-states-down)
    (exwm-input-set-key (kbd "S-s-<up>") 'windmove-swap-states-up)
    (exwm-input-set-key (kbd "S-s-<left>") 'windmove-swap-states-left)
    (exwm-input-set-key (kbd "S-s-<right>") 'windmove-swap-states-right)

    ;; (exwm-enable)

    )))

(package-require 'exwm-randr)
(exwm-randr-enable)

(start-process-shell-command "xrandr" nil "")

(setq async-shell-command-buffer 'new-buffer)
;;(setq async-shell-command-display-buffer nil) ;; this would keep the new buffer in background. Might be attached to C-s-&

(cond
 ((not (string-equal system-type "darwin"))
  (progn
    (setq exwm-workspace-show-all-buffers t)
    (setq exwm-layout-show-all-buffers t))))

(cond
 ((not (string-equal system-type "darwin"))
  (progn (setq exwm-workspace-minibuffer-position 'bottom)
	 (setq exwm-workspace-display-echo-area-timeout 5)
	 ;; (exwm-workspace-attach-minibuffer)
	 ;; (exwm-workspace-detach-minibuffer)
	 )))

;; (defun get-exwm-process-id (&optional buffer-or-name)
;;   (interactive)
;;   (let* ((buf (or buffer-or-name (current-buffer)))
;;        (id (exwm--buffer->id (get-buffer buf)))) ; ID of X window being displayed
;;      (if id
;; 	  (slot-value (xcb:+request-unchecked+reply
;; 			   exwm--connection
;; 			   (make-instance 'xcb:ewmh:get-_NET_WM_PID :window id))
;; 		       'value)
;; 	(user-error "Target buffer %S is not an X window managed by EXWM!"
;; 		    buf))))

;; (get-exwm-process-id)

(global-visual-line-mode 1)

(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)

(global-set-key [f11] 'toggle-frame-fullscreen)

(package-require 'zenburn-theme)
(load-theme 'zenburn t)

(package-require 'spaceline)
;;(package-require 'spaceline-config)
;;(spaceline-spacemacs-theme)

(defun my-increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
   (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(global-set-key (kbd "C-c +") 'my-increment-number-decimal)

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(package-require 'spray)
(global-set-key (kbd "<f6>") 'spray-mode)

;; let's get encryption established
(setenv "GPG_AGENdaT_INFO" nil)  ;; use emacs pinentry
(setq auth-source-debug t)

(setq epg-gpg-program "gpg2")  ;; not necessary
(package-require 'epa-file)
(epa-file-enable)
(setq epa-pinentry-mode 'loopback)
(setq epg-pinentry-mode 'loopback)
;;(pinentry-start)

(require 'org-crypt)
(org-crypt-use-before-save-magic)

(setq epa-file-select-keys nil)

(package-require 'epa-file)
(setq epg-debug t)
(epa-file-enable)
(setq epa-file-select-keys nil)

 ;;check OS type and load additional gpg path
 (cond
  ((string-equal system-type "darwin")
   (progn
     (message "loading Mac OS X specific path settings")
     (add-to-list 'exec-path "/usr/local/MacGPG2/bin")
     (load-library "secrets")
     (require 'secrets)
     )))
(setf epa-pinentry-mode 'loopback)

;; (load-library "~/.secrets.el.gpg")
(require 'secrets)

;; (package-require 'org-passwords)
;; (setq org-passwords-file "/home/mpuchalla/ownCloud/org/secrets.org.gpg")
;; (setq org-passwords-random-words-dictionary "/etc/dictionaries-common/words")

(use-package pinentry
  :ensure t
  :config
  (pinentry-start))

;;(add-to-list 'load-path "~/.emacs.d/lib/smudge/")
(package-require 'smudge)

(package-require 'simple-httpd)
(package-require 'oauth2)

(require 'smudge)

;; Settings
;;(setq smudge-oauth2-client-secret PASS_spotify-app-client-secret)
;;(setq smudge-oauth2-client-id PASS_spotify-app-client-id)
;;(define-key smudge-mode-map (kbd "C-c .") 'smudge-command-map)

;;(setq smudge-transport 'connect)

;; A hydra for controlling spotify.
(defhydra hydra-spotify (:hint nil)
  "
^Search^                  ^Control^               ^Manage^
^^^^^^^^-----------------------------------------------------------------
_t_: Track               _SPC_: Play/Pause        _+_: Volume up
_m_: My Playlists        _n_  : Next Track        _-_: Volume down
_f_: Featured Playlists  _p_  : Previous Track    _x_: Mute
_u_: User Playlists      _r_  : Repeat            _d_: Device
^^                       _s_  : Shuffle           _q_: Quit
"
  ("t" smudge-track-search :exit t)
  ("m" smudge-my-playlists :exit t)
  ("f" smudge-featured-playlists :exit t)
  ("u" smudge-user-playlists :exit t)
  ("SPC" smudge-controller-toggle-play :exit nil)
  ("n" smudge-controller-next-track :exit nil)
  ("p" smudge-controller-previous-track :exit nil)
  ("r" smudge-controller-toggle-repeat :exit nil)
  ("s" smudge-controller-toggle-shuffle :exit nil)
  ("+" smudge-controller-volume-up :exit nil)
  ("-" smudge-controller-volume-down :exit nil)
  ("x" smudge-controller-volume-mute-unmute :exit nil)
  ("d" smudge-select-device :exit nil)
  ("q" quit-window "quit" :color blue))

(bind-key "s-s" #'hydra-spotify/body)

;;     (add-to-list 'load-path "/usr/local/Cellar/mu/1.2.0_1/share/emacs/site-lisp/mu/mu4e")
  ;;   (package-require 'mu4e)
    ;; (setq mu4e-maildir "~/.mail")
     ;;(setq mu4e-drafts-folder "/my.drafts")
     ;;(setq mu4e-sent-folder   "/my.sent_mail")
     ;; (setq mu4e-sent-messages-behavior 'delete)
     ;; allow for updating mail using 'U' in the main view:
     ;; (setq mu4e-get-mail-command "offlineimap")

     ;; ;; shortcuts
     ;; (setq mu4e-maildir-shor;; tcuts
     ;; ;;
        ;; '( ("/INBOX"               . ?i)))

     ;; ;; something about ourselves
     ;; (setq
     ;;    user-mail-address "cb0@0xcb0.com"
     ;;    user-full-name  "Marcus Puchalla"
     ;;    mu4e-compose-signature
     ;;     (concat
     ;;    "MfG,\n"
     ;;    "Marcus Puchalla\n"))

(package-require 'notmuch)

(package-require 'osa-chrome)

(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
	(setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (next-line)))

(global-set-key (kbd "M-,") 'comment-or-uncomment-region-or-line)

(global-set-key (kbd "C-x C-;") 'comment-region)
(global-set-key (kbd "C-x C-:") 'uncomment-region)

;;(package-require 'helm)
;; (package-require 'ac-helm)

;; (global-set-key (kbd "C-c m") 'helm-mini)

;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
;; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
;; (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;; (when (executable-find "curl")
;;   (setq helm-google-suggest-use-curl-p t))

;; (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
;;       helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
;;       helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
;;       helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
;;       helm-ff-file-name-history-use-recentf t)

;; ;; Control Spotify
;; (package-require 'helm-spotify)
;; (global-set-key (kbd "<f9>") 'helm-spotify)

;; ;; Helm as Backup ([[https://github.com/antham/helm-backup][Helm-Backup]])
;; (add-to-list 'load-path "~/.helm-backups/")
;; (package-require 'helm-backup)

;; (add-hook 'after-save-hook 'helm-backup-versioning)

;; (global-set-key (kbd "C-c b")   'helm-backup)

;; ;; theme select
;; (package-require 'helm-themes)
;; (package-require 'helm-projectile)

;; ;;enable fuzzy matching
;; (setq helm-recentf t)
;; (setq helm-mini t)
;; (setq helm-buffers-list t)
;; (setq helm-find-files t)
;; (setq helm-locate t)
;; (setq helm-M-x t)
;; (setq helm-semantic t)
;; (setq helm-imenu t)
;; (setq helm-apropos t)
;; (setq helm-lisp-completion-at-point t)

;; (setq helm-candidate-number-limit 100)

;; ;;(image-dired-display-image-mode)

;; (helm-autoresize-mode 1)
;; ;; activate helm mode
;; (helm-mode 1)

;;(desktop-save-mode 1)
;;(setq history-length 250)
;(add-to-list 'desktop-globals-to-save 'file-name-history)

(defun my-desktop-save ()
  (interactive)
  ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
;;(add-hook 'auto-save-hook 'my-desktop-save)

;;(desktop-read)

;;(package-require 'workgroups2)

;;(setq wg-prefix-key (kbd "C-z"))
;;(setq wg-session-file "~/.emacs.d/.emacs_workgroups")
;; (global-set-key (kbd "C-c C-c")         'wg-create-workgroup)
;; (global-set-key [?\s-c] 'wg-create-workgroup)
;; (global-set-key (kbd "C-c w")         'wg-switch-to-workgroup)
;; (global-set-key [?\s-w] 'wg-switch-to-workgroup)
;; (global-set-key (kbd "C-c C-r")         'wg-rename-workgroup)
;; (global-set-key (kbd "C-c C-k")         'wg-kill-workgroup)
;; (global-set-key (kbd "C-c C-<left>")         'wg-switch-to-previous-workgroup)
;; ;; What to do on Emacs exit / workgroups-mode exit?
;; (setq wg-emacs-exit-save-behavior           'save)      ; Options: 'save 'ask nil
;; (setq wg-workgroups-mode-exit-save-behavior 'save)      ; Options: 'save 'ask nil

;; ;; Mode Line changes
;; ;; Display workgroups in Mode Line?
;; (setq wg-mode-line-display-on t)          ; Default: (not (featurep 'powerline))
;; (setq wg-flag-modified t)                 ; Display modified flags as well
;; (setq wg-mode-line-decor-left-brace "["
;;       wg-mode-line-decor-right-brace "]"  ; how to surround it
;;       wg-mode-line-decor-divider ":")



;; (setq debug-on-error t)

;; (workgroups-mode 1)

;; (package-require 'workgroups)

;; (workgroups-mode 1)

;; (setq wg-prefix-key (kbd "C-z"))

;; (global-set-key [?\s-c] 'wg-create-workgroup)
;; (global-set-key [?\s-s] 'wg-switch-to-workgroup)

(package-require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(text-scale-set 4)

(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<up>") 'shrink-window)
(global-set-key (kbd "S-C-<down>") 'enlarge-window)

;; Jump backwards between windows
(defun other-window-backward (n)
  "Select Nth previous window."
  (interactive "p")
  (other-window (- n)))

;;bind switching between windows to SHIFT-UP/DOWN (super usefull!!!!)
(global-set-key [(shift down)] 'other-window)
(global-set-key [(shift up)] 'other-window-backward)

;; (package-require 'zoom-window)
;; ;;(setq zoom-window-use-elscreen t)
;; (zoom-window-setup)

;; (global-set-key (kbd "C-x C-z") 'zoom-window-zoom)

(package-require 'tree-sitter)
(package-require 'tree-sitter-langs)

(global-tree-sitter-mode)

(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(add-hook 'typescript-mode-hook #'tree-sitter-mode)

;; (add-to-list 'load-path "./submodules/")
;;   ; Semantic
;;   (global-semantic-idle-completions-mode t)
;;   (global-semantic-decoration-mode t)
;;   (global-semantic-highlight-func-mode t)
;;   (global-semantic-show-unmatched-syntax-mode t)

;;   ;; CC-mode
;;   (add-hook 'c-mode-hook '(lambda ()
;; 	  (setq ac-sources (append '(ac-source-semantic) ac-sources))
;; 	  (local-set-key (kbd "RET") 'newline-and-indent)
;; 	  (linum-mode t)
;; 	  (semantic-mode t)))

;; (package-require 'speedbar)
;; (package-require 'sr-speedbar)
;; (setq speedbar-show-unknown-files t)

;; (setq company-backends (delete 'company-semantic company-backends))
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)

;; (package-require 'company-c-headers)
;; (add-to-list 'company-backends 'company-c-headers)

;; (package-require 'cc-mode)
;; (package-require 'semantic)

;; (global-semanticdb-minor-mode 1)
;; (global-semantic-idle-scheduler-mode 1)

;; (global-semantic-idle-summary-mode 1)
;; ;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;; ;; (package-require 'stickyfunc-enhance)

;; ;; (semantic-mode 1)

;; Package: smartparens
;; (package-require 'smartparens)
;; (show-smartparens-global-mode +1)
;; (smartparens-global-mode 1)

;; ;; when you press RET, the curly braces automatically
;; ;; add another newline
;; (sp-with-modes '(c-mode c++-mode)
;;   (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
;;   (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
;; 					    ("* ||\n[i]" "RET"))))

(global-set-key (kbd "<f4>") (lambda ()
                           (interactive)
                           (setq-local compilation-read-command nil)
                           (call-interactively 'compile)))

(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;; (package-require 'ggtags)
;; (add-hook 'c-mode-common-hook
;; 	  (lambda ()
;; 	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;; 	      (ggtags-mode 1))))

;; (define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
;; (define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
;; (define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
;; (define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
;; (define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
;; (define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

;; (define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

;; (package-require 'ac-php)
;; (add-hook 'php-mode-hook
;;           '(lambda ()
;;              (company-mode t)
;;              (add-to-list 'company-backends 'company-ac-php-backend )))

;; (package-require 'php-mode)
;; ;; (package-require 'php-extras)

;; (add-hook 'php-mode-hook
;;           '(lambda ()
;;              (auto-complete-mode t)
;;              (require 'ac-php)
;;              (setq ac-sources  '(ac-source-php ) )
;;              (yas-global-mode 1)
;;              (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
;;              (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back   ) ;go back
;;              ;; (php-extras-company)
;;              ))

;; (eval-after-load 'company
;;   '(progn
;;      (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
;;      (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)))

(package-require 'haskell-mode)
(package-require 'lsp-mode)
(package-require 'lsp-ui)
(package-require 'lsp-haskell)
;; (package-require 'company-ghc)

(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

(eval-after-load "haskell-mode"
  '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))

(eval-after-load "haskell-cabal"
    '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))

(package-require 'slime)
(setq inferior-lisp-program "sbcl")
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;; (load "~/quicklisp/setup.lisp")
;; (ql:add-to-init-file)

(package-require 'dap-mode)
(package-require 'typescript-mode)


(setq package-list '(dap-mode typescript-mode tree-sitter tree-sitter-langs lsp-mode lsp-ui))

(package-require 'lsp-mode)

(add-hook 'typescript-mode-hook 'lsp-deferred)
(add-hook 'javascript-mode-hook 'lsp-deferred)

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

;;(define-key dired-mode-map [s-return] 'sudo-edit-current-file)

;;(setq tramp-default-method "ssh")

;;(package-require 'sudo-edit)

(defun ido-remove-tramp-from-cache nil
  "Remove any TRAMP entries from `ido-dir-file-cache'.
    This stops tramp from trying to connect to remote hosts on emacs startup,
    which can be very annoying."
  (interactive)
  (setq ido-dir-file-cache
        (cl-remove-if
         (lambda (x)
           (string-match "/\\(rsh\\|ssh\\|telnet\\|su\\|sudo\\|sshx\\|krlogin\\|ksu\\|rcp\\|scp\\|rsync\\|scpx\\|fcp\\|nc\\|ftp\\|smb\\|adb\\):" (car x)))
         ido-dir-file-cache)))
;; redefine 'ido-kill-emacs-hook' so that cache is cleaned before being saved
(defun ido-kill-emacs-hook ()
  (ido-remove-tramp-from-cache)
  (ido-save-history))

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

(package-require 'counsel)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(use-package counsel
  :custom (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only))

;; ;;projectile
;; (package-require 'projectile)
;; (projectile-global-mode)
;; (setq projectile-indexing-method 'alien)
;; (setq projectile-switch-project-action 'projectile-dired)
;; (setq projectile-enable-caching t)
;; (package-require 'ag)

;; (define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
;; (define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
;; (define-key projectile-mode-map [?\s-f] 'projectile-find-file)
;; (define-key projectile-mode-map [?\s-g] 'projectile-grep)
;; (define-key projectile-mode-map (kbd "s-.") 'projectile-recentf)
;; (define-key projectile-mode-map (kbd "s-a") 'projectile-ag)
;; (define-key projectile-mode-map (kbd "s-q") 'helm-projectile-ag)

;; (package-require 'perspective)
;; (package-require 'helm-ag)
;; (persp-mode)
;; (package-require 'persp-projectile)
;; (define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)

;; (package-require 'project-explorer)

(package-require 'swiper)

(setq magit-completing-read-function 'ivy-completing-read)
(setq projectile-completion-system 'ivy)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-load-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
;; (package-require 'helm-rhythmbox)
;;(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

;; (defun counsel ()
;;   "Elisp completion at point."
;;   (interactive)
;;   (let* ((bnd (bounds-of-thing-at-point 'symbol))
;;          (str (buffer-substring-no-properties (car bnd) (cdr bnd)))
;;          (candidates (all-completions str obarray))
;;          (ivy-height 7)
;;          (res (ivy-read (format "pattern (%s): " str)
;;                         candidates)))
;;     (when (stringp res)
;;       (delete-region (car bnd) (cdr bnd))
;;       (insert res))))

(package-require 'smex)

(require 'smex)
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                                        ; when Smex is auto-initialized on its first run.

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; This is the old M-x.
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

; Activate org-mode
(require 'org)
;; (require 'org-install)
;; (require 'org-habit)
;; (setq org-habit-preceding-days 7
      ;; org-habit-following-days 1
      ;; org-habit-graph-column 80
      ;; org-habit-show-habits-only-for-today t
      ;; org-habit-show-all-today t)
;;(require 'ess-site)
					;; http://orgmode.org/guide/Activation.html#Activation

					;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

					;; And add babel inline code execution
					;; babel, for executing code in org-mode.
(org-babel-do-load-languages
 'org-babel-load-languages
					;; load all language marked with (lang . t).
 '((C . t)
   (shell . t)))

;; turn off "evaluate code question" in org-mode code blocks
(setq org-confirm-babel-evaluate nil)

;;set org diretrory to owncloud sync
;; (setq org-directory "~/ownCloud/org")

;; and some more org stuff
(setq org-list-allow-alphabetical t)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;; add a timestamp when we close an item
(setq org-log-done 'note)
;; include a closing note when close an todo item
;; (setq org-log-done 'note)

;;(global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-cc" 'org-capture)
;; (global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cb" 'org-iswitchb)
;; (global-set-key (kbd "<S-i>") 'org-clock-in)
;; (global-set-key (kbd "<S-o>") 'org-clock-out)
;; (global-set-key (kbd "<S-g>") 'org-clock-goto)



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
 ;; '(org-agenda-files (quote ("~/todo.org")))
 ;; '(org-default-notes-file "~/notes.org")
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
;; (setq org-capture-templates
      ;; '(("t" "Todo" entry (file+headline (concat org-directory "/gtd.org") "Tasks")
	 ;; "* TODO %?\n %i\n")
	;; ("l" "Link" plain (file (concat org-directory "/links.org"))
	 ;; "- %?\n %x\n")))


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
;;         ("c" todo "DONE|DEFERRED|CANCELLED" nil)
;;         ("w" todo "WAITING" nil)
;;         ("W" agenda "" ((org-agenda-ndays 21)))
;;         ("A" agenda ""
;;          ((org-agenda-skip-function
;;            (lambda nil
;;              (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
;;           (org-agenda-ndays 1)
;;           (org-agenda-overriding-header "Today's Priority #A tasks: ")))
;;         ("u" alltodo ""
;;          ((org-agenda-skip-function
;;            (lambda nil
;;              (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
;;                                        (quote regexp) "\n]+>")))
;;           (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
;;  '(org-remember-store-without-prompt t)
;;  '(org-remember-templates
;;    (quote ((116 "* TODO %?\n  %u" "~/todo.org" "Tasks")
;;         (110 "* %u %?" "~/notes.org" "Notes"))))
;;  '(remember-annotation-functions (quote (org-remember-annotation)))
;;  '(remember-handler-functions (quote (org-remember-handler))))

;; (package-require 'org-ac)
;; (package-require 'org-tempo)

;; To save the clock history across Emacs sessions:
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-continuously nil)

;; we want some non standard todo types
(setq org-todo-keywords
      '((sequence
	 "TODO(t)" "BUG(b)" "WAIT_FOR_FEEDBACK(w)" "FIXED(f)" "TO_BE_MERGE(m)" "MERGED(M)" "WAIT(w)" "|" "CANCELED(c)" "DONE(d)" "|" "INFO(i)")))

(setq org-todo-keyword-faces
      '(("TODO" :background "red1" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
	("BUG" :background "red1" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
	("WAIT_FOR_FEEDBACK" :background "yellow" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
	("DISCUSSION" :background "red2" :foreground "orange" :weight bold :box (:line-width 2 :style released-button))
	("FIXED" :background "orange" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
	("TO_BE_MERGE" :background "gold" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
	("MERGED" :background "gold" :foreground "grey" :weight bold :box (:line-width 2 :style released-button))
	("WAIT" :background "gray" :foreground "black" :weight bold :box (:line-width 2 :style released-button))
	("DONE" :background "forest green" :weight bold :box (:line-width 2 :style released-button))
	("INFO" :background "green" :foreground "red1" :weight bold :box (:line-width 2 :style released-button))
	("CANCELLED" :background "lime green" :foreground "black" :weight bold :box (:line-width 2 :style released-button))))

;; dont ask when executing code
(setq org-confirm-babel-evaluate nil)

(defface org-block-begin-line
  '((t (:underline "#A7A6AA" :foreground "#040404" :background "#9a9a9a")))
  "Face used for the line delimiting the begin of source blocks.")

(defface org-block-background
  '((t (:background "#4F4F4F")))
  "Face used for the source block background.")

(defface org-block-end-line
  '((t (:overline "#A7A6AA" :foreground "#000000" :background "#9a9a9a")))
  "Face used for the line delimiting the end of source blocks.")

(setq org-completion-use-ido t)

(setq exec-path (append exec-path '("/usr/bin/mscgen")))

(defun do-org-show-all-inline-images ()
  (interactive)
  (org-display-inline-images t t))

;; (add-hook 'org-ctrl-c-ctrl-c-hook (lambda () (org-display-inline-images)))
;;(add-hook 'org-confirm-babel-evaluate-hook (lambda () (org-display-inline-images)))

(add-hook 'org-babel-after-execute-hook
	  (lambda ()
	    (condition-case nil
		(org-display-inline-images)
	      (error nil)))
	  'append)

;; set so that each line has correct indent
(setq org-adapt-indentation t)

(when (version<= "9.2" (org-version))
  (require 'org-tempo))

(package-require 'org-journal)

(setq org-journal-dir "~/sync/org/journal/")

(setq org-agenda-file-regexp "\\`\\\([^.].*\\.org\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'")
(add-to-list 'org-agenda-files org-journal-dir)
(add-to-list 'org-agenda-files "~/org/calendar.org")

(custom-set-variables
 '(org-directory "~/sync/org/")
 '(org-agenda-files (directory-files-recursively "~/sync/org/" "\\.org$")))

(add-to-list 'auto-mode-alist '("\\`[^.].*\\.org|[0-9]+" . org-mode))

(setq org-capture-templates
      '(("j" "Journal Entry"
	 entry (file+datetree "~/sync/org/journal/journal.org")
	 "* Event: %?\n\n  %i\n\n  From: %a"
	 :empty-lines 1)))

(defun get-journal-file-today ()
  "Return filename for today's journal entry."
  (let ((daily-name (format-time-string "%Y%m%d")))
    (expand-file-name (concat org-journal-dir daily-name ".org"))))

(defun journal-file-today ()
  "Create and load a journal file based on today's date."
  (interactive)
  (find-file (get-journal-file-today)))

(global-set-key (kbd "C-c f j") 'org-journal-new-entry)
;; journal-file-today)

;; Turn off auto-save-mode, needed for saving encrypted journals without leaking data
(add-hook 'org-journal-mode-hook (lambda () (auto-save-mode -1)))

;; Enable encryption
(setq org-journal-enable-encryption t)

(package-require 'org-super-agenda)
(org-super-agenda-mode)
(let ((org-super-agenda-groups
       '(;; Each group has an implicit boolean OR operator between its selectors.
	 (:name "Today"  ; Optionally specify section name
		:time-grid t  ; Items that appear on the time grid
		:todo "TODAY")  ; Items that have this TODO keyword
	 (:name "Important"
		;; Single arguments given alone
		:tag "work"
		:priority "A"))))
  (org-agenda nil "a"))

(package-require 'org-caldav)
(setq org-caldav-url "https://cal.0xcb0.com/")
(setq org-caldav-calendar-id "cb0/53ba00fd-502f-8b48-c01d-bd339a3ef42a")
(setq org-caldav-inbox "~/org/calendar.org")
(setq org-caldav-files ())
(setq org-icalendar-timezone "Europe/Berlin")

(global-set-key (kbd "C-c y") 'org-caldav-sync)

(setq calendar-week-start-day 1)
(setq diary-number-of-entries 14)
(appt-activate t)

(global-set-key (kbd "C-c c") 'calendar)
;; use the same diary file as the one from caldav
(setq diary-file org-caldav-inbox)

(copy-face font-lock-constant-face 'calendar-iso-week-face)
(set-face-attribute 'calendar-iso-week-face nil
		    :height 0.7)
(setq calendar-intermonth-text
      '(propertize
	(format "%2d"
		(car
		 (calendar-iso-from-absolute
		  (calendar-absolute-from-gregorian (list month day year)))))
	'font-lock-face 'calendar-iso-week-face))

(package-require 'org-wc)

;; and run org-wc-display on a timer every time I go idle for 5 seconds
(defun pc/display-org-wc-in-buffer ()
  "Calls org-wc-display in the buffer if timer is set."
  (when (timerp pc/org-wc-display-timer)
    (call-interactively 'org-wc-display)))

(defun pc/setup-org-wc-display-timer ()
  "Function to setup a buffer local timer."
  (interactive)

  (defvar pc/org-wc-display-timer nil
    "Buffer-local timer.")

  (let ((buffer (current-buffer)))
    (setq pc/org-wc-display-timer
          (run-with-idle-timer 2 t 'pc/display-org-wc-in-buffer))))

(defun pc/cancel-org-wc-display-timer ()
  "Cancel the timer once we are done."
  (interactive)
  (when (timerp pc/org-wc-display-timer)
    (cancel-timer pc/org-wc-display-timer)))

(global-set-key (kbd "C-c o")
                (lambda () (interactive) (find-file "~/sync/org/old/homenotes.org")))

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 5))))

(global-set-key (kbd "C-c a") 'org-agenda)
     (global-set-key (kbd "C-c c") 'org-capture)

;;     (setq org-agenda-files
;;       '("~/ownCloud/org/homenotes.org" "~/ownCloud/org/journal/"))

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-capture-templates
  '(("t" "Todo" entry (file+headline "~/sync/org/old/homenotes.org" "Todos")
        "* TODO %?\n  %i\n %a")
    ("b" "Book" entry (file+headline "~/sync/org/old/homenotes.org" "Books")
        "* TODO Description: %?
	        %^{Author}p \n Created: %T")
   ("j" "Journal Entry" entry (file+datetree "~/sync/org/journalEntry.org")
         "* Event: %?\n\n  %i\n\n  From: %a"
         :empty-lines 1)
    ))

(setq temporary-file-directory "/tmp/")

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/sync/org/org-roam")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t))
   ("l" "programming language" plain
    "* Characteristics\n\n- Family: %?\n- Inspired by: \n\n* Reference:\n\n"
    :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
    :unnarrowed t))
  :bind (("C-c n l"   . org-roam-buffer-toggle)
	 ("C-c n f"   . org-roam-node-find)
	 ("C-c n i"   . org-roam-node-insert)
	 ("C-c n _"   . org-id-get-create)
	 ("C-c n a"   . org-roam-alias-add)
	 ("C-c n d"   . org-roam-dailies-find-date)
	 ("C-c n c"   . org-roam-dailies-capture-today)
	 ("C-c n C r" . org-roam-dailies-capture-tomorrow)
	 ("C-c n t"   . org-roam-dailies-goto-today)
	 ("C-c n y"   . org-roam-dailies-find-yesterday)
	 ("C-c n r"   . org-roam-dailies-find-tomorrow)
	 ("C-c n g"   . org-roam-graph)
	 :map org-mode-map
	 ("C-M-i"     . completion-at-point))
  :config
  (org-roam-setup))

;; (make-directory "~/sync/org/org-roam")
;; here is the home directory
;; (setq org-roam-directory (file-truename "~/sync/org/org-roam")) ;

(org-roam-db-autosync-mode)

(package-require 'anki-editor)
(use-package anki-editor
  :after org
  :config
  ; I like making decks
  (setq anki-editor-create-decks 't))

;; git and magit (Magit rules!!!!)
;; (require 'git)
(package-require 'magit)
(global-set-key (kbd "<f5>") 'magit-status)

;;taken from http://tullo.ch/articles/modern-emacs-setup/
;; (defadvice magit-status (around magit-fullscreen activate)
;;   "Make magit-status run alone in a frame."
;;   (window-configuration-to-register :magit-fullscreen)
;;   ad-do-it
;;   (delete-other-windows))

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
;;(setq magit-last-seen-setup-instructions "1.4.0")

(setq magit-completing-read-function 'magit-ido-completing-read)
;; (package-require 'ido-ubiquitous)
;; (ido-ubiquitous-mode 1)

(defun magit-stash-clear (ref)
  "Remove all stashes saved in REF's reflog by deleting REF."
  (interactive (let ((ref (or (magit-section-value-if 'stashes) "refs/stash")))
		 (magit-confirm t (format "Drop all stashes in %s" ref))
		 (list ref)))
(message "To prevent from dropping all stashes again, this was disabled!"))

(setq smerge-command-prefix "\C-cv")

;; (package-require 'secretaria)
;; (use-package secretaria
             ;; :config
             ;; use this for getting a reminder every 30 minutes of those tasks scheduled
             ;; for today and which have no time of day defined.
             ;; (add-hook 'after-init-hook #'secretaria-today-unknown-time-appt-always-remind-me))

;; (package-require 'wakatime-mode)
;; (require 'secrets)
;; (global-wakatime-mode)
;; (setq wakatime-api-key PASS_wakatime-api-key)
;; (setq wakatime-cli-path "/home/cb0/.wakatime/wakatime-cli")

;;  (setq paradox-github-token TOKEN_paradox-github-token)

;;needed by jira
(package-require 'xml-rpc)
;;acutal package
;; (package-require 'org-jira)
;; (require 'org-jira)
;; (setq jiralib-url "http://")

(global-set-key (kbd "C-S-l") 'sgml-pretty-print)

(defun xmllint-region (&optional b e)
  (interactive "r")
  (shell-command-on-region b e "xmllint --format -" t))
;;(global-set-key (kbd "C-M-l") 'xmlling-region)

(package-require 'w3m)

(defun wicked/toggle-w3m ()
  "Switch to a w3m buffer or return to the previous buffer."
  (interactive)
  (if (derived-mode-p 'w3m-mode)
      ;; Currently in a w3m buffer
      ;; Bury buffers until you reach a non-w3m one
      (while (derived-mode-p 'w3m-mode)
        (bury-buffer))
    ;; Not in w3m
    ;; Find the first w3m buffer
    (let ((list (buffer-list)))
      (while list
        (if (with-current-buffer (car list)
              (derived-mode-p 'w3m-mode))
            (progn
              (switch-to-buffer (car list))
              (setq list nil))
          (setq list (cdr list))))
      (unless (derived-mode-p 'w3m-mode)
        (call-interactively 'w3m)))))

(global-set-key (kbd "<f7>") 'wicked/toggle-w3m)

(package-require 'langtool)
(setq langtool-language-tool-jar "/home/mpuchalla/projects/languagetools/LanguageTool-3.6/languagetool.jar")
(setq langtool-mother-tongue "de")

(package-require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<down>") 'mc/mark-all-like-this)

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
   (cons '("\\.m$" . octave-mode) auto-mode-alist))

(add-hook 'octave-mode-hook
    (lambda ()
      (abbrev-mode 1)
      (auto-fill-mode 1)
      (if (eq window-system 'x)
      	  (font-lock-mode 1))))
(autoload 'run-octave "octave-inf" nil t)

(setq exec-path (append exec-path '("/usr/local/octave/3.8.0/bin/")))

;; Seems not to work in emacs 25
;; (autoload 'octave-help "octave-hlp" nil t)
;; (package-require 'gnuserv)
;; (gnuserv-start)

(global-set-key (kbd "C-c i l") 'octave-send-line)
(global-set-key (kbd "C-c i b") 'octave-send-block)
(global-set-key (kbd "C-c i r") 'octave-send-region)
(global-set-key (kbd "C-c i s") 'octave-show-process-buffer)

;; (package-require 'ansible)
;; (package-require 'company-ansible)

(package-require 'lastfm)
(package-require 'vuiet)
