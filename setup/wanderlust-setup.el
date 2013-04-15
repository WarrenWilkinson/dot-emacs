

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Wanderlust
 
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

;;(setq 
;;  elmo-maildir-folder-path "~/Maildir"          ;; where i store my mail
;;  elmo-imap4-default-server "imap.gmail.com"
;;  elmo-imap4-default-user "warrenwilkinson@gmail.com"
;;  elmo-imap4-default-authenticate-type 'clear
;;  elmo-imap4-default-port 993
;;  elmo-imap4-default-stream-type 'ssl
;;  elmo-imap4-use-modified-utf7 t)

;;(setq 
;;  wl-stay-folder-window t                       ;; show the folder pane (left)
;;  wl-folder-window-width 25                     ;; toggle on/off with 'i'


;;;  wl-local-domain "myhost.example.com"          ;; put something here...
;;;  wl-message-id-domain "myhost.example.com"     ;; ...
;;
;;  wl-from "Warren Wilkinson <warrenwilkinson@gmail.com>"                  ;; my From:

;;  wl-default-folder "%inbox"
;;;  wl-dispose-folder-alist
;;;      (cons '("^%inbox" . remove) wl-dispose-folder-alist)
;;  wl-default-spec "%"
;;  wl-draft-folder "%[Google Mail]/Drafts" ; Gmail IMAP
;;  wl-trash-folder "%[Google Mail]/Trash")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Wanderlust Enhancements

(defun djcb-wl-draft-subject-check ()
  "check whether the message has a subject before sending"
  (if (and (< (length (std11-field-body "Subject")) 1)
        (null (y-or-n-p "No subject! Send current draft?")))
      (error "Abort.")))


;; note, this check could cause some false positives; anyway, better
;; safe than sorry...
(defun djcb-wl-draft-attachment-check ()
  "if attachment is mention but none included, warn the the user"
  (save-excursion
    (goto-char 0)
    (unless ;; don't we have an attachment?

      (re-search-forward "^Content-Disposition: attachment" nil t) 
     (when ;; no attachment; did we mention an attachment?
        (re-search-forward "attach" nil t)
        (unless (y-or-n-p "Possibly missing an attachment. Send current draft?")
          (error "Abort."))))))

(add-hook 'wl-mail-send-pre-hook 'djcb-wl-draft-subject-check)
(add-hook 'wl-mail-send-pre-hook 'djcb-wl-draft-attachment-check)

(setq wl-forward-subject-prefix "Fwd: " )

;; Invert behaviour of with and without argument replies.
;; just the author
(setq wl-draft-reply-without-argument-list
  '(("Reply-To" ("Reply-To") nil nil)
     ("Mail-Reply-To" ("Mail-Reply-To") nil nil)
     ("From" ("From") nil nil)))


;; bombard the world
(setq wl-draft-reply-with-argument-list
  '(("Followup-To" nil nil ("Followup-To"))
     ("Mail-Followup-To" ("Mail-Followup-To") nil ("Newsgroups"))
     ("Reply-To" ("Reply-To") ("To" "Cc" "From") ("Newsgroups"))
     ("From" ("From") ("To" "Cc") ("Newsgroups"))))


(setq wl-summary-showto-folder-regexp "sent\\|draft\\|Sent\\|Draft")
(setq wl-user-mail-address-list  '("warrenwilkinson@gmail.com"))
;(setq wl-auto-save-drafts-interval nil)

;; Gmail doesn't handle deleting things correctly. In gmail it simply removes the
;; label from the email.  This tells wanderlust that to delete something, you actually
;; refile it to trash. 
(setq wl-dispose-folder-alist
      '(("^.*imap.gmail.com.*$" . "%[Gmail]/Trash:warrenwilkinson/clear@imap.gmail.com:993!")))

(require 'filladapt)


;; from a WL mailing list post by Per b. Sederber
;; Re-fill messages that arrive poorly formatted
(defun wl-summary-refill-message (all)
  (interactive "P")
  (if (and wl-message-buffer (get-buffer-window wl-message-buffer))
      (progn
        (wl-summary-toggle-disp-msg 'on)
        (save-excursion
          (set-buffer wl-message-buffer)
          (goto-char (point-min))
          (re-search-forward "^$")
          (while (or (looking-at "^\\[[1-9]") (looking-at "^$"))
            (forward-line 1))
          (let* ((buffer-read-only nil)
                 (find (lambda (regexp)
                         (save-excursion
                           (if (re-search-forward regexp nil t)
                               (match-beginning 0)
                             (point-max)))))
                 (start (point))
                 (end (if all
                          (point-max)
                        (min (funcall find "^[^>\n]* wrote:[ \n]+")
                             (funcall find "^>>>>>")
                             (funcall find "^ *>.*\n *>")
                             (funcall find "^-----Original Message-----")))))
            (save-restriction
              (narrow-to-region start end)
              (filladapt-mode 1)
              (fill-region (point-min) (point-max)))))
        (message "Message re-filled"))
    (message "No message to re-fill")))

(setq mime-edit-split-message nil)

;(define-key wl-summary-mode-map 
;(define-key mime-view-mode-map "\M-q" 'wl-summary-refill-message)

;	  '(lambda ()
;	     (setq fill-column 79)
;         (longlines-mode t)))
