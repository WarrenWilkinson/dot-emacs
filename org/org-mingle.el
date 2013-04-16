;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Mingle Links

(org-add-link-type "mingle" 'mingle-open)
(defun mingle-open (mingle-number)
  (browse-url (concat "https://mingle.curvedms.org/projects/curve_hero/cards/" mingle-number)))
