;; EMERGENCY PACKAGE WORKAROUND
;; This bypasses the url-cache requirement

(setq debug-on-error t)

;; Try to create a minimal url-cache substitute
(unless (featurep 'url-cache)
  (message "Creating url-cache workaround...")

  ;; Define minimal url-cache functions that packages expect
  (defvar url-cache-directory
    (expand-file-name "cache" user-emacs-directory))

  (defun url-cache-create-filename (url)
    "Create a cache filename for URL."
    (concat url-cache-directory "/"
            (replace-regexp-in-string "[^a-zA-Z0-9]" "_" url)))

  (defun url-store-in-cache (&optional buff)
    "Dummy cache function."
    nil)

  (defun url-is-cached (url)
    "Always return nil - no caching."
    nil)

  (defun url-cache-expired (url mod-time)
    "Always return t - cache always expired."
    t)

  ;; Provide the feature so packages think it's loaded
  (provide 'url-cache)
  (message "url-cache workaround installed"))

;; Now try basic package functionality
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(condition-case err
    (progn
      (message "Attempting package-initialize...")
      (package-initialize)
      (message "✓ Package initialize successful")

      (message "Attempting to refresh package contents...")
      (package-refresh-contents)
      (message "✓ Package refresh successful")

      (message "Attempting to install company...")
      (package-install 'company)
      (message "✓ Company install successful"))
  (error
   (message "Error: %s" err)))
