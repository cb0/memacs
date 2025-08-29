;; MINIMAL TEST CONFIG
;; This tests just the basic package functionality

(setq debug-on-error t)

;; Log function
(defun log-test (message)
  (with-current-buffer (get-buffer-create "*Test-Log*")
    (goto-char (point-max))
    (insert (format "[%s] %s\n"
                    (format-time-string "%H:%M:%S")
                    message))))

(log-test "=== Starting minimal test ===")

;; Test 1: Package system
(condition-case err
    (progn
      (require 'package)
      (log-test "✓ package.el loaded")

      (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                               ("elpa" . "https://elpa.gnu.org/packages/")))
      (log-test "✓ package archives set")

      (package-initialize)
      (log-test "✓ package system initialized")

      ;; Test network connectivity
      (unless package-archive-contents
        (log-test "Attempting to refresh package contents...")
        (package-refresh-contents)
        (log-test "✓ package contents refreshed"))

      (log-test "✓ Package system working"))
  (error
   (log-test (format "✗ Package system failed: %s" err))))

;; Test 2: use-package
(condition-case err
    (progn
      (unless (package-installed-p 'use-package)
        (log-test "Installing use-package...")
        (package-install 'use-package))
      (require 'use-package)
      (log-test "✓ use-package working"))
  (error
   (log-test (format "✗ use-package failed: %s" err))))

;; Test 3: Company
(condition-case err
    (progn
      (unless (package-installed-p 'company)
        (log-test "Installing company...")
        (package-install 'company))
      (require 'company)
      (global-company-mode 1)
      (log-test "✓ Company working"))
  (error
   (log-test (format "✗ Company failed: %s" err))))

(log-test "=== Test completed - check results above ===")
(switch-to-buffer "*Test-Log*")
