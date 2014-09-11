;; Flymake: On the fly syntax checking

; stronger error display
(defface flymake-message-face
  '((((class color) (background light)) (:foreground "#b2dfff"))
    (((class color) (background dark))  (:foreground "#b2dfff")))
  "Flymake message face")

; show the flymake errors in the minibuffer
(package-require 'flymake-cursor)  
