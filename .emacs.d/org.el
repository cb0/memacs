;; load .org and .notes files in org-mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ; not needed since Emacs 22.2
(add-to-list 'auto-mode-alist '("\\.notes\\'" . org-mode))

(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on

(global-set-key "\C-cl" 'org-store-link)
;; Creates task that are stored in a .notes
(global-set-key "\C-cc" 'org-capture)
;; List ToDos, Timeline & more
(global-set-key "\C-ca" 'org-agenda)
;; Fast org buffer switch
(global-set-key "\C-cb" 'org-iswitchb)
