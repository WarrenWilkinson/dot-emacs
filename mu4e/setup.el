
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu")
(require 'mu4e)



(setq
 mu4e-get-mail-command "offlineimap"
 mu4e-update-interval 300)


;(setq message-send-mail-function 'smtpmail-send-it)
;; if our mail server lives at smtp.example.org; if you have a local
;; mail-server, simply use 'localhost' here.
;(setq smtpmail-smtp-server "smtp.example.org")

;; use 'fancy' non-ascii characters in various places in mu4e
(setq mu4e-use-fancy-chars nil)

;; save attachment to my desktop (this can also be a function)
;(setq mu4e-attachment-dir "~/Desktop")

;; attempt to show images when viewing messages
(setq
 mu4e-view-show-images t
 mu4e-view-image-max-width 800)
