;; This delays initializing smex until it’s needed.
;; from: http://www.emacswiki.org/emacs/Smex#toc5
(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))

(global-set-key [(shift meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                                   (smex-major-mode-commands)))


;; using acronyms
;; This function needs the 'cl module which is not loaded in all systems. It will produce the error message "Error in post-command-hook (ido-exhibit): (void-function remove-if-not)"
;; Therefore we check if it's loaded and reload it if not.
(if (not (featurep 'cl)) 
    (require 'cl))
;; from: http://www.emacswiki.org/emacs/Smex#toc6
(defun acronym-matches ()
  (let* ((regex
          (concat "^"
                  (mapconcat 'char-to-string
                             ido-text
                             "[^-]*-") "[^-]*$")))
    (reverse (remove-if-not (lambda (i) (string-match regex i)) items))))

(defadvice ido-set-matches-1 (after acronym-matches)
  (if (> (length ido-text) 1)
      (setq ad-return-value (append (acronym-matches) ad-return-value))))

(ad-activate 'ido-set-matches-1)
