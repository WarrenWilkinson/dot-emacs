;; Local Setup for Work Computer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Customizations

(load "~/.emacs.d/org/org-mingle.el")
(load "~/.emacs.d/org/org-reviewboard.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PHP
(load "~/.emacs.d/php/setup.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SQL
(load "~/.emacs.d/sql/setup.el")

(defalias 'sql-get-login 'ignore)  ;; Don't ask for name, database and server.
(setq sql-user "warren")
(setq sql-database "warren_hero")
(setq sql-server "curvefiles")
(setq sql-postgres-options '("-P" "pager=off" "-v" "schema=warren_hero")) ;; Turn off pager (needed), and set the :schema variable

(snippet-with-abbrev-table
 'sql-mode-abbrev-table
; ("test" . "SELECT * FROM $${users} LIMIT 1;")
 ("seetransactions" . "SELECT substr(u.first_name, 0, 2) || '. ' || u.last_name || ' (' || u.id || ')' as patient, visit__id || ' (' || visit_status__name || ')' AS visit, visit__history_on as on, CASE WHEN t.id IS NULL THEN '   --' WHEN t.is_void = true THEN '[X] ' || t.id  ELSE '    ' || t.id::varchar END AS invoice, substr(chargeable_item__name,0,45) as service, line_item__tooth AS tooth FROM chart_history AS ch LEFT JOIN users AS u ON patient_id = u.id LEFT JOIN transaction_entries AS te ON te.line_item_id = ch.line_item__id LEFT JOIN transactions AS t ON te.transaction_id = t.id WHERE (ch.patient_id = $${-1} OR (ch.patient_id = u.id AND u.first_name || ' ' || u.last_name = '$${patient fullname}') OR visit__id = $${-2} OR t.id = $${-3}) ORDER BY visit__id;")
 ("seeformversions" . "SELECT id,
                     form_template_id AS f_id,
                     form_template_item_id AS i_id,
                     CASE WHEN length(name) > 23 THEN substr(overlay(name placing '...' from 20), 0, 23) ELSE name END AS name,
                     expired_at,
                     created_at
              FROM form_template_versions
              ORDER BY form_template_id, updated_at;")
 ("seeforms" . "WITH versions AS (SELECT ftv.id,
                                       ftv.name,
                                       ftv.form_template_id,
                                       ftv.expired_at,ROW_NUMBER() OVER(PARTITION BY ftv.form_template_id ORDER BY ftv.expired_at DESC) AS rk
                                FROM form_template_versions ftv)
                 SELECT form.id,
                        to_char(patient.id, '99999') || ':  ' || substr(patient.first_name, 0, 2) || '. ' || patient.last_name AS patient,
                        'Rev' || to_char(fv.id, '999') || ': ' || CASE WHEN fv.expired_at IS NULL THEN '  latest' WHEN fv.id=v.id THEN '  deleted' ELSE fv.expired_at::date || '' END AS rev,
                        CASE WHEN length(v.name) > 29 THEN substr(overlay(v.name placing '...' from 26), 0, 29) ELSE v.name END AS form,
                        fs.name AS status,
                        completed_date,
                        is_accessible
                 FROM forms AS form
                 LEFT JOIN form_statuses AS fs ON form.form_status_id = fs.id
                 LEFT JOIN form_template_versions AS fv ON form.form_template_version_id = fv.id
                 LEFT JOIN form_templates AS template ON fv.form_template_id = template.id
                 LEFT JOIN versions AS v ON fv.form_template_id = v.form_template_id
                 LEFT JOIN users AS patient ON form.patient_id = patient.id WHERE v.rk = 1 ORDER BY $${patient}.id, form.completed_date;")
 ("seeuser" . "SELECT patient.id,
                   type,
                   patient.first_name || ' ' || patient.last_name AS name,
                   ps.name AS status
              FROM users AS patient
              LEFT JOIN patient_statuses AS ps ON patient.patient_status_id = ps.id
              WHERE patient.first_name || ' ' || patient.last_name ILIKE '$${first last}';")
 ("seevisits" . "SELECT v.id,
                     to_char(patient.id, '99999') || ':  ' || substr(patient.first_name, 0, 2) || '. ' || patient.last_name AS patient,
                     v.name,
                     v.history_on AS on,
                     vs.name AS status,
                     tp.name as treatment
              FROM visits AS v
              LEFT JOIN treatment_plans AS tp ON v.treatment_plan_id = tp.id
              LEFT JOIN visit_statuses AS vs ON v.visit_status_id = vs.id
              LEFT JOIN users AS patient ON tp.patient_id = patient.id
              WHERE tp.patient_id = $${-1} OR patient.first_name || ' ' || patient.last_name ILIKE '$${first last}';")
 ("showvisit" . "SELECT li.id,
                     CASE WHEN li.is_active IS true THEN ' ' ELSE 'X' END AS X,
                      '(' || chargeable_item_id || ') ' || chargeable.name AS Chargable,
                      provider.first_name || ' ' || provider.last_name AS Provider,
                      tooth,
                      li.cost
              FROM line_items AS li
              LEFT JOIN users AS provider ON li.provider_id = provider.id
              LEFT JOIN chargeable_items AS chargeable ON li.chargeable_item_id = chargeable.id
              WHERE li.visit_id = $${-1};"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Geben

(add-to-list 'load-path "/usr/share/emacs/23.1/site-lisp/geben")
(require 'geben)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Startup File

(setq org-todo-keywords
       '((sequence "TODO(t)" "WAIT(w)" "REVU(r@/!)" "CUST(c!)" "INQA(q!)" "|" "DONE(d!)" "MERG(m!)" "QUIT(Q@/!)")))

(setq org-todo-keyword-faces '(("TODO" :foreground "red" :weight bold)))


(set-default-font "Terminus 8")
(setq org-agenda-files (list "~/work.org"))
(find-file "~/work.org")
