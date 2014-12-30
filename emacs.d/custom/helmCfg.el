(package-require 'helm)

(package-require 'ac-helm)


(global-set-key (kbd "C-c m") 'helm-mini)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
;;(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

;; Control Spotify
(package-require 'helm-spotify)
(global-set-key (kbd "<f9>") 'helm-spotify)

;; Helm as Backup ([[https://github.com/antham/helm-backup][Helm-Backup]])
(add-to-list 'load-path "~/.helm-backups/")
(package-require 'helm-backup)

(add-hook 'after-save-hook 'helm-backup-versioning)

(global-set-key (kbd "C-c b")   'helm-backup)

;; theme select
(package-require 'helm-themes)
(package-require 'helm-projectile)

;; activate helm mode
(helm-mode 1)

