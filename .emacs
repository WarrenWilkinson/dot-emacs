(require 'site-gentoo)

(setq-default ispell-program-name "aspell")
(set-default-font "Bitstream Vera Sans Mono-12")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(color-font-is-global nil)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(transient-mark-mode nil))

(setq scroll-step 1)
(global-set-key (kbd "C-w") 'backward-kill-word)

(setq x-select-enable-clipboard nil)
(setq x-select-enable-primary t)
(setq mouse-drag-copy-region t)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'tramp)
(setq tramp-default-method "scp")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Encryption

(require 'epa)
;(epa-file-enable)
(setq epa-file-select-keys nil) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Mode 

(require 'org)
(add-hook 'org-mode-hook 'flyspell-mode)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cr" 'org-todo)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . nil)
   (emacs-lisp . t)
   (sh . t)
   (lisp . t)
   (clojure . t)
   (ditaa . t)
   (latex . t)))

(setq org-src-fontify-natively t)
(setq org-confirm-babel-evaluate nil)
(setq org-src-window-setup 'current-window)

(setq org-ditaa-jar-path "/usr/share/ditaa-bin/lib/ditaa.jar")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; CSS color values colored by themselves
  ; http://xahlee.org/emacs/emacs_html.html
  
(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property
	 (match-beginning 0)
	 (match-end 0)
	 'face (list :background 
		     (match-string-no-properties 0)))))))

(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords))

(add-hook 'css-mode-hook 'hexcolour-add-to-font-lock)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lisp, Everywhere!

(require 'slime)
(set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8-unix)
(setq inferior-lisp-program "/usr/bin/sbcl")

(defun pretty-lambdas ()
  (font-lock-add-keywords
   nil `(("(=?\\(lambda\\>\\)"
	  (0 (progn (compose-region (match-beginning 1) (match-end 1)
				    ,(make-char 'greek-iso8859-7 107))
		    nil)))
	 ("#x[abcdef[:digit:]]\\{6\\}"
	  (0 ;(message "FOUND %s: %s." (match-string-no-properties 0)
	     ;	      (concat "#" (substring (match-string-no-properties 0) 2)))
	     (put-text-property
	      (match-beginning 0)
	      (match-end 0)
	      'face (list :background (concat "#" (substring (match-string-no-properties 0) 2)))))))))

(add-hook 'lisp-mode-hook 'pretty-lambdas)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Backups

(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load Local Setup

(load (concat "~/.emacs.d/setup/local-" system-name ".el"))
