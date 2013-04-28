;; Local Setup for Home Computer

(require 'site-gentoo)
(setq-default ispell-program-name "aspell")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(setq org-publish-project-alist
;      '(("earth-alberta"
;	 :base-directory "~/Projects/EarthAlberta"
;	 :publishing-directory "/tmp/"
;	 :recursive t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key "5362373C")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "../mu4e/setup.el")

(setq mu4e-drafts-folder "/BitByByte/Drafts")
(setq mu4e-sent-folder   "/BitByByte/Sent")
(setq mu4e-trash-folder  "/BitByByte/Trash")

(setq mu4e-sent-messages-behavior 'sent)

(setq
 message-send-mail-function   'smtpmail-send-it
 smtpmail-default-smtp-server "oxmail.registrar-servers.com"
 smtpmail-smtp-server         "oxmail.registrar-servers.com"
 smtpmail-local-domain        "bitbybytesoftware.com"
 smtpmail-sendto-domain        "bitbybytesoftware.com"
 smtpmail-debug-info t
 smtpmail-debug-verb t
 smtpmail-stream-type 'plain)

(setq smtpmail-auth-credentials  (expand-file-name "~/.authinfo.gpg"))

(setq
 user-mail-address "warren@bitbybytesoftware.com"
 user-full-name  "Warren Wilkinson"
 message-signature
 (concat
  "Warren Wilkinson\n"
  "http://www.bitbybytesoftware.com\n"))


(setq mu4e-user-mail-address-list '("warren@bitbybytesoftware.com"))

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-default-font "Terminus 10")
(find-file "~/organization/main.org")
