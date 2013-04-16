;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PHP Style

(add-to-list 'load-path "~/.emacs.d/php-mode/")
(require 'php-mode)

(setq-default indent-tabs-mode nil)

(defconst my-php-style
  '((c-tab-always-indent        . t)
    (c-basic-offset             . 4)
    (c-default-style            . "linux")
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((substatement-open . 0)
                                   (case-label        . 4)
				   (arglist-intro     . +)
				   (arglist-cont-nonempty . c-lineup-math)
				   (arglist-close     . 0)
				   (comment-intro     . 0)
                                   (block-open        . 0)
                                   (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . t))
  "My PHP Programming Style")

(c-add-style "my-php-style" my-php-style)

(defun my-php-mode-hook ()
  "My PHP mode configuration."
  (setq-default show-trailing-whitespace t)
  (c-set-style "my-php-style"))

(add-hook 'php-mode-hook 'my-php-mode-hook)
(add-hook 'php-mode-hook 'flymake-mode)
