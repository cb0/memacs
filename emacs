
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(setenv "LSP_USE_PLISTS" "true")
(org-babel-load-file
 (expand-file-name "emacs-init.org"
                   user-emacs-directory))
