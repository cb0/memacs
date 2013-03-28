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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ido-enable-flex-matching t)
 '(ns-alternate-modifier (quote none))
 '(ns-auto-hide-menu-bar nil)
 '(ns-function-modifier (quote super)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
