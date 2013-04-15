
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Big Brother Database

(setq bbdb-file "~/.emacs.d/bbdb")           ;; keep ~/ clean; set before loading
(require 'bbdb)

(bbdb-initialize)
(setq 
    bbdb-offer-save 1                        ;; 1 means save-without-asking

    
    bbdb-use-pop-up t                        ;; allow popups for addresses
    bbdb-electric-p t                        ;; be disposable with SPC
    bbdb-popup-target-lines  1               ;; very small
    
    bbdb-dwim-net-address-allow-redundancy t ;; always use full name
    bbdb-quiet-about-name-mismatches 2       ;; show name-mismatches 2 secs

    bbdb-always-add-address t                ;; add new addresses to existing...
                                             ;; ...contacts automatically
    bbdb-canonicalize-redundant-nets-p t     ;; x@foo.bar.cx => x@bar.cx

    bbdb-completion-type nil                 ;; complete on anything

    bbdb-complete-name-allow-cycling t       ;; cycle through matches
                                             ;; this only works partially

    bbbd-message-caching-enabled t           ;; be fast
    bbdb-use-alternate-names t               ;; use AKA

    bbdb-check-zip-codes-p nil

    bbdb-elided-display t )                   ;; single-line addresses

    ;; auto-create addresses from mail
 ;   bbdb/mail-auto-create-p 'prompt ;;;bbdb-ignore-some-messages-hook   


(setq bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook)
(setq bbdb-ignore-some-messages-alist
      '(( "From" . "no.?reply\\|no.?spam\\|invalid\\|DAEMON\\|daemon\\|facebookmail\\|twitter|linkedin\\|spam")))

(add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook)
(setq bbdb-auto-notes-alist 
      '(("Subject"    ("lisp"  . "Lisp User"))
	("Organization" (".*" company 0))
	("Newsgroups" (".*" newsgroups 0))))
(put 'newsgroups 'field-separator "; ")
		      

;; The above means the variable bbdb-auto-notes-alist will control
;; what stuff will automatically be added to this users notes.

;Newsgroups: gmane.mail.wanderlust.general

(require 'bbdb-wl)
(bbdb-wl-setup)


;; (setq wl-summary-from-function 'bbdb-wl-from-func)
(setq wl-summary-get-petname-function 'bbdb-wl-get-petname)
     ;; automatically add mailing list fields





;; i don't want to store addresses from my mailing folders
;(setq 
;  bbdb-wl-folder-regexp    ;; get addresses only from these folders
;  "^\.inbox$\\|^%[Gmail]/Sent Mail")    ;; 


;(define-key wl-draft-mode-map (kbd "<C-tab>") 'bbdb-complete-name)

;(bbdb-initialize 'gnus 'message)
;(setq 
;(bbdb-insinuate-w3)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
