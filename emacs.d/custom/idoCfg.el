; use ido mode for file and buffer Completion when switching buffers
(require 'ido)
(package-require 'flx)
(package-require 'flx-ido)
(ido-mode t)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
