;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Reviewboard Links

(org-add-link-type "review" 'review-open)
(defun review-open (review-number)
  (browse-url (concat "http://reviewboard.curvedms.org/r/" review-number)))
