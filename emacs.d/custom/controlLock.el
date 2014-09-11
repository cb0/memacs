; control-lock-mode, so we can enter a vi style command-mode with standard emacs keys.
(package-require 'control-lock)
; also bind M-ü and M-ä to toggling control lock.
(global-set-key (kbd "M-ü") 'control-lock-toggle)
(global-set-key (kbd "C-ü") 'control-lock-toggle)
(global-set-key (kbd "M-ä") 'control-lock-toggle)
(global-set-key (kbd "C-ä") 'control-lock-toggle)
(global-set-key (kbd "C-z") 'control-lock-toggle)
