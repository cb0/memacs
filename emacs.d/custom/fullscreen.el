; fullscreen, taken from http://www.emacswiki.org/emacs/FullScreen#toc26
; should work for X und OSX with emacs 23.x (TODO find minimum version).
; for windows it uses (w32-send-sys-command #xf030) (#xf030 == 61488)
(defvar babcore-fullscreen-p t "Check if fullscreen is on or off")
(setq babcore-stored-frame-width nil)
(setq babcore-stored-frame-height nil)

(defun babcore-non-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
      ;; WM_SYSCOMMAND restore #xf120
      (w32-send-sys-command 61728)
    (progn (set-frame-parameter nil 'width 
                                (if babcore-stored-frame-width
                                    babcore-stored-frame-width 82))
           (set-frame-parameter nil 'height
                                (if babcore-stored-frame-height 
                                    babcore-stored-frame-height 42))
           (set-frame-parameter nil 'fullscreen nil))))

(defun babcore-fullscreen ()
  (interactive)
  (setq babcore-stored-frame-width (frame-width))
  (setq babcore-stored-frame-height (frame-height))
  (if (fboundp 'w32-send-sys-command)
      ;; WM_SYSCOMMAND maximaze #xf030
      (w32-send-sys-command 61488)
    (set-frame-parameter nil 'fullscreen 'fullboth)))

(defun toggle-fullscreen ()
  (interactive)
  (setq babcore-fullscreen-p (not babcore-fullscreen-p))
  (if babcore-fullscreen-p
      (babcore-non-fullscreen)
    (babcore-fullscreen)))

(global-set-key [f11] 'toggle-fullscreen)
