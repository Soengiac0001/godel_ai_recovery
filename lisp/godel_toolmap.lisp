(defparameter *tool-map*
  '(("ext4" . "photorec")
    ("GPT" . "ddrescue")
    ("Boot" . "photorec")
    ("unknown" . "none")))

(defun tool-for-type (type)
  (or (cdr (assoc type *tool-map* :test #'string=)) "none"))

(format t "[🧠] Toolmap Loaded.~%")
