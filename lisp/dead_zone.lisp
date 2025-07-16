(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :uiop))

(defparameter *dead-log* "logs/dead_zone.log")

(defun log-dead-zone (line reason)
  (with-open-file (stream *dead-log* :direction :output :if-exists :append :if-does-not-exist :create)
    (format stream "[☠️] ~a — REASON: ~a~%" line reason)))

(defun scan-for-dead-zones ()
  (with-open-file (stream "logs/devices.log")
    (loop for line = (read-line stream nil)
          while line do
            (when (search "unknown" line)
              (log-dead-zone line "Filesystem Unknown"))
            (when (search "swap" line)
              (log-dead-zone line "Non-resurrectable swap partition")))))

(scan-for-dead-zones)
