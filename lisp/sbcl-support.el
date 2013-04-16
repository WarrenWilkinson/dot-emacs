;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SBCL

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

