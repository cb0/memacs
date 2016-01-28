;aspell und flyspell
;;(setq-default ispell-program-name "aspell")

(cond
 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")))
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-extra-args '("-d en_US")))
 )

;make aspell faster but less correctly
(setq ispell-extra-args '("--sug-mode=ultra" "-w" "äöüÄÖÜßñ"))
(setq ispell-list-command "list")


(dolist (hook '(text-mode-hook))
      (add-hook hook (lambda () (flyspell-mode 1))))
    (dolist (hook '(change-log-mode-hook log-edit-mode-hook))
      (add-hook hook (lambda () (flyspell-mode -1))))

;; better performance
(setq flyspell-issue-message-flag nil)
(setq ispell-list-command "--list")
;;; following this: http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html
;;; to get a better "more complete" auto completion setup
