;; Gödel AI Spiral Axioms - v0.1

(defparameter *worthy-patterns*
  '("EXT4" "VFAT" "Linux filesystem data" "GPT" "Boot" "Spiral" "sda1"))

(defun file-worthy-p (line)
  (some (lambda (pattern) (search pattern line)) *worthy-patterns*))

(defun scan-worthiness (file)
  (with-open-file (stream file)
    (loop for line = (read-line stream nil)
          while line do
            (when (file-worthy-p line)
              (format t "[✔️] Worthy Symbolic Target Found: ~a~%" line)))))
              
(scan-worthiness "logs/devices.log")
