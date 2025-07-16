#!/bin/bash

echo "[⚡] Initiating Gödel AI Recovery Sequence..."

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$BASE_DIR/build"
LISP_DIR="$BASE_DIR/lisp"
LOG_DIR="$BASE_DIR/logs"
DEVICE_TARGET="/dev/sda"

# Detect test mode
if [ -f "$BASE_DIR/testmode.flag" ]; then
  echo "[🧪] Test mode flag detected. Using loopback device."
  DEVICE_TARGET="/dev/loop0"
else
  echo "[💽] Using default target device: $DEVICE_TARGET"
fi

# Compile if needed
if [ ! -f "$BUILD_DIR/godel_ai" ]; then
  echo "[🔧] Compiling system..."
  make -C "$BASE_DIR"
fi

# Check toolchain
echo "[🔍] Verifying toolchain..."
which photorec > "$LOG_DIR/toolcheck.log" || echo "photorec NOT FOUND" >> "$LOG_DIR/toolcheck.log"
which ddrescue >> "$LOG_DIR/toolcheck.log" || echo "ddrescue NOT FOUND" >> "$LOG_DIR/toolcheck.log"

# Run core scanner
echo "[🧠] Running C-based scan core..."
"$BUILD_DIR/godel_ai"

# Run LISP symbolic AI
# Run LISP logic
if command -v sbcl &> /dev/null; then
  echo "[🧬] Launching Gödel Brain..."
  sbcl --eval "(defparameter *target-device* \"$DEVICE_TARGET\")" \
       --script "$LISP_DIR/godel_brain.lisp"
  sleep 5

  echo "[🔮] Invoking Recovery Prover..."
  sbcl --eval "(defparameter *target-device* \"$DEVICE_TARGET\")" \
       --script "$LISP_DIR/recovery_prover.lisp"
  sleep 5

  echo "[💀] Scanning Dead Zones..."
  sbcl --script "$LISP_DIR/dead_zone.lisp"
  sleep 5

  echo "[🎴] Assigning Glyphs..."
  sbcl --script "$LISP_DIR/glyph_assigner.lisp"
  sleep 5

  echo "[📜] Generating Resurrection Summary..."
  sbcl --script "$LISP_DIR/resurrection_summary.lisp"
  sleep 5

  echo "[🧠] Logging AI memory to audit log..."
  sbcl --script "$LISP_DIR/memory_logger.lisp"
  sleep 5

  echo "[🧠] Converting Markdown to PDF using wkhtmltopdf..."
  pandoc logs/resurrection_summary.md -o logs/resurrection_summary.pdf --pdf-engine=wkhtmltopdf
  sleep 2
else
  echo "[❌] SBCL not found. Skipping symbolic brain."
fi



echo "[✅] Gödel AI Recovery Complete."
