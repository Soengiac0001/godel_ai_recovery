(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :uiop))

(defparameter *audit-file* "logs/memory.audit.log")

(defun write-memory-audit ()
  (with-open-file (stream *audit-file*
                          :direction :output
                          :if-exists :append
                          :if-does-not-exist :create)
    (format stream "[🧠] Session at ~a~%" (get-universal-time))
    (loop for line in (uiop:read-file-lines "logs/proof.log")
          do (format stream "~a~%" line))
    (format stream "========================================================~%")))

(write-memory-audit)
