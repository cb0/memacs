(add-to-list 'load-path "~/.emacs.d/")
(setq debug-on-error t)

;;load package manager and resources
(load "~/.emacs.d/package_manager.el")

;; load autocomplete features
(load "~/.emacs.d/customize_autocomplete.el")

;; when do we want to load which mode
(load "~/.emacs.d/hooks.el")

;;customize ido
(load "~/.emacs.d/customize_ido.el")
;; on top of IDO, history/frequency command usage  
(load "~/.emacs.d/customize_smex.el")
;;org mode stuff
(load "~/.emacs.d/org.el")

;;emacs internals that override the default behaviour. (e.g. Relocate auto-saved files)
(load "~/.emacs.d/internals.el")
(load "~/.emacs.d/key_bindings.el")

;;egg init
(load "~/.emacs.d/egg.el")

(load "~/.emacs.d/backup-each-save.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ns-right-alternate-modifier (quote none))
 '(vc-handled-backends (quote (RCS CVS SVN SCCS Bzr Hg Mtn Arch))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
