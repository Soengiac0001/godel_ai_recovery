(defparameter *glyph-map*
  '(("sda1" . "RAZIEL")
    ("sda3" . "THAUMIEL")
    ("mmcblk0p2" . "ARK")
    ("loop0" . "VIRELL")))

(defun assign-glyph (line)
  (loop for (key . glyph) in *glyph-map*
        when (search key line)
          do (return glyph)))

(defun annotate-proof ()
  (with-open-file (source "logs/devices.log")
    (loop for line = (read-line source nil)
          while line do
            (let ((glyph (assign-glyph line)))
              (when glyph
                (with-open-file (stream "logs/proof.log"
                                        :direction :output
                                        :if-exists :append
                                        :if-does-not-exist :create)
                  (format stream "[🎴] Assigned Glyph: ~a to ~a~%" glyph line)))))))

(annotate-proof)
