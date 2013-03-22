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

;;emacs internals that override the default behaviour. (e.g. Relocate auto-saved files)
(load "~/.emacs.d/internals.el")
(load "~/.emacs.d/key_bindings.el")

