;; Convenient printing

(require 'printing)

(pr-update-menus t)
; make sure we use localhost as cups server
(setenv "CUPS_SERVER" "localhost")
(package-require 'cups)
