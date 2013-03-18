(progn
  (require 'package)

  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("elpa" . "http://tromey.com/elpa/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.milkbox.net/packages/")))

                          '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (package-initialize)

  ;; It's recommended to create a list of packages in init.el which will be
  ;; installed if they are found to not be present:

  (when (not package-archive-contents)
    (package-refresh-contents))
