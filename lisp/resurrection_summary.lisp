(defparameter *proof-file* "logs/proof.log")
(defparameter *summary-md* "logs/resurrection_summary.md")

(defun extract-target (line)
  (let ((start (search "Target " line))
        (end (search " marked" line)))
    (if (and start end)
        (subseq line (+ start 7) end)
        "UNKNOWN")))

(defun extract-proof-level (line)
  (let ((pos (search "Proof Level: " line)))
    (if pos
        (subseq line (+ pos 13))
        "??")))

(defun generate-markdown-summary ()
  (with-open-file (in *proof-file* :direction :input)
    (with-open-file (out *summary-md* :direction :output :if-exists :supersede)
      (format out "# 🧬 Gödel AI Resurrection Summary~%~%")
      (format out "### 📅 Timestamp: ~a~%~%" (get-universal-time))
      (format out "| Glyph | Partition | Level | Action |~%")
      (format out "|-------|-----------|--------|--------|~%")
      (let ((current-level "??"))
        (loop for line = (read-line in nil)
              while line do
                (when (search "[📈]" line)
                  (setf current-level (string-trim " " (extract-proof-level line))))
                (when (search "[✔️]" line)
                  (let ((target (string-trim " " (extract-target line))))
                    (format out "| RAZIEL | ~a | ~a | Resurrected |~%" target current-level))))))))

(generate-markdown-summary)

