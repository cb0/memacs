; go to the last change
(package-require 'goto-chg)
(global-set-key [(control .)] 'goto-last-change)
; M-. can conflict with etags tag search. But C-. can get overwritten
; by flyspell-auto-correct-word. And goto-last-change needs a really
; fast key.
(global-set-key [(meta .)] 'goto-last-change)


; Save edit points in files while switching between open files.
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/saved-places")

; show recent files
(package-require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 1000)
