;; Local Setup for Home Computer

(require 'site-gentoo)
(setq-default ispell-program-name "aspell")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-publish-project-alist
      '(("earth-alberta"
	 :base-directory "~/Projects/EarthAlberta"
	 :publishing-directory "/tmp/"
	 :recursive t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-default-font "Bitstream Vera Sans Mono-12")
(find-file "~/organization/main.org")
