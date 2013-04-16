(require 'sql)

(defalias 'sql-get-login 'ignore)  ;; Don't ask for name, database and server.
(setq sql-user "postgres")
(setq sql-database "postgres")
(setq sql-server "localhost")
(setq sql-postgres-options '("-P" "pager=off"))

(defun sql-remove-continuing-prompts (output)
  (concat "\n" (replace-regexp-in-string (concat sql-database "[^=()]# ") "" output)))

(defun sqli-add-hooks ()
  (add-hook 'comint-preoutput-filter-functions 'sql-remove-continuing-prompts))

(add-hook 'sql-interactive-mode-hook 'sqli-add-hooks)

(defun my-sql-save-history-hook ()
    (let ((lval 'sql-input-ring-file-name)
          (rval 'sql-product))
      (if (symbol-value rval)
          (let ((filename
                 (concat "~/.emacs.d/sql/"
                         (symbol-name (symbol-value rval))
                         "-history.sql")))
            (set (make-local-variable lval) filename))
        (error
         (format "SQL history will not be saved because %s is nil"
                 (symbol-name rval))))))
(add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)

(load "~/.emacs.d/sql/sql-complete.el")

(defcustom sql-postgres-data-dictionary
  (concat
   "SELECT '(\"' || c.relname || '\" \"' || a.attname ||'\")' "
   "FROM pg_class AS c "
   "LEFT JOIN pg_attribute AS a ON c.oid = a.attrelid "
   "WHERE c.relkind='r' "
   "ORDER BY c.relname; ")
  "SQL Statement to determine all tables and columns."
  :group 'SQL
  :type 'string)

(defun save-sql-data-dictionary ()
  (let ((file "~/.emacs.d/sql/sql-data-dictionary"))
    (with-temp-buffer
      (pp sql-data-dictionary (current-buffer))
      (write-region (point-min) (point-max) file))))

(defun load-sql-postgres-data-dictionary ()
  "Read the contents of a file and return as a string."
  (let ((file "~/.emacs.d/sql/sql-data-dictionary"))
    (if (file-exists-p file)
        (setq sql-data-dictionary
              (with-temp-buffer
                (insert-file-contents file)
                (read (current-buffer)))))))

(defun generate-sql-postgres-data-dictionary ()
  (interactive)
  (setq sql-data-dictionary
        (sql-data-dictionary sql-postgres-data-dictionary))
  (save-sql-data-dictionary))

(load-sql-postgres-data-dictionary)

(define-key sql-interactive-mode-map (kbd "TAB") 'sql-complete)

(define-abbrev-table 'sql-mode-abbrev-table ())
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (setq local-abbrev-table sql-mode-abbrev-table)))
