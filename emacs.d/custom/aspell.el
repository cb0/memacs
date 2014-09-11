;aspell und flyspell
(setq-default ispell-program-name "aspell")

;make aspell faster but less correctly
(setq ispell-extra-args '("--sug-mode=ultra" "-w" "äöüÄÖÜßñ"))
(setq ispell-list-command "list")
