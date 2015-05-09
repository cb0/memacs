; use key chords invoke commands
;; UNCOMMENT ME IF TYPING FAST WILL BREAK HERE
(package-require 'key-chord)
(key-chord-mode 1)
; buffer actions
(key-chord-define-global "vg"     'eval-region)
(key-chord-define-global "vb"     'eval-buffer)
(key-chord-define-global "cy"     'yank-pop)
(key-chord-define-global "cg"     "\C-c\C-c")
; frame actions
(key-chord-define-global "xo"     'other-window);
(key-chord-define-global "x1"     'delete-other-windows)
(key-chord-define-global "x0"     'delete-window)
(defun kill-this-buffer-if-not-modified ()
  (interactive)
  ; taken from menu-bar.el
  (if (menu-bar-non-minibuffer-window-p)
      (kill-buffer-if-not-modified (current-buffer))
    (abort-recursive-edit)))
(key-chord-define-global "xk"     'kill-this-buffer-if-not-modified)
; file actions
(key-chord-define-global "xb"     'ido-switch-buffer)
(key-chord-define-global "xd"     'ido-dired)
(key-chord-define-global "cf"     'ido-find-file)
(key-chord-define-global "vc"     'vc-next-action)
