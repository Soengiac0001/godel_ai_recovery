(format t "~%🧠 FS Reflector Activated.~%")

(defun reflect-fs-state (file)
  (if (probe-file file)
      (with-open-file (stream file)
        (loop for line = (read-line stream nil)
              while line do
                (when (search "ext4" line)
                  (format t "[💾] FS Match: ~a~%" line))
                (when (search "unknown" line)
                  (format t "[⚠️] Unknown FS Type Found: ~a~%" line))))
      (format t "[⚠️] FS Reflection Failed: ~a not found.~%" file)))

(reflect-fs-state "logs/devices.log")
