;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq debug-on-error t)

;; Create a log buffer for tracking config loading
(defun log-config (message)
  (with-current-buffer (get-buffer-create "*Config-Log*")
    (goto-char (point-max))
    (insert (format "[%s] %s\n"
                    (format-time-string "%H:%M:%S")
                    message))))

(log-config "=== STARTING CONFIG LOAD ===")

(package-initialize)

(setenv "LSP_USE_PLISTS" "true")

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(log-config "About to load org-babel config file")

;; Wrap the org-babel loading in error handling
(condition-case err
    (progn
      (log-config "Loading emacs-init.org...")
      (org-babel-load-file
       (expand-file-name "emacs-init.org"
                         user-emacs-directory))
      (log-config "=== CONFIG LOAD COMPLETED SUCCESSFULLY ==="))
  (error
   (log-config (format "ERROR during config load: %s" err))
   (message "Config loading failed - check *Config-Log* buffer for details")
   (switch-to-buffer "*Config-Log*")))
