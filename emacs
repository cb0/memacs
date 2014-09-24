;; We start emacs in server mode, so we can later on attach to it.
(server-start)

;;; set custom path

;;(setq load-path
;;      (cons (expand-file-name "~/.emacs.d/custom/") load-path))

(add-to-list 'load-path "~/.emacs.d/")
(load-library "init")


;;; DESK TOP (Session Management)
(desktop-save-mode 1)
(setq history-length 250)
(add-to-list 'desktop-globals-to-save 'file-name-history)

(defun my-desktop-save ()
    (interactive)
    ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
    (if (eq (desktop-owner) (emacs-pid))
        (desktop-save desktop-dirname)))
  (add-hook 'auto-save-hook 'my-desktop-save)

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(jiralib-url "http://jira.app.activate.de/rpc/xmlrpc")
;;  '(org-agenda-files (quote ("~/todo.org")))
;;  '(org-agenda-ndays 7)
;;  '(org-agenda-show-all-dates t)
;;  '(org-agenda-skip-deadline-if-done t)
;;  '(org-agenda-skip-scheduled-if-done t)
;;  '(org-agenda-start-on-weekday nil)
;;  '(org-deadline-warning-days 14)
;;  '(org-default-notes-file "~/notes.org")
;;  '(org-fast-tag-selection-single-key (quote expert))
;;  '(org-reverse-note-order t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
