#!/bin/bash

SUMMARY_MD="logs/resurrection_summary.md"
PDF_FILE="logs/resurrection_summary.pdf"
HTML_FILE="logs/resurrection_summary.html"

# 🧬 Check if summary file exists
if [ ! -f "$SUMMARY_MD" ]; then
  echo "❌ Summary not found: $SUMMARY_MD"
  echo "⚠️  Run './run_godel.sh' first to generate it."
  exit 1
fi

echo "🧬 Resurrection Summary Export Options"
echo "1. View Markdown"
echo "2. Export to PDF"
echo "3. Export to HTML"
read -p "Choose [1–3]: " choice

case "$choice" in
  1)
    less "$SUMMARY_MD"
    ;;

  2)
    if ! command -v pandoc &> /dev/null; then
      echo "❌ 'pandoc' is not installed. Install it first."
      exit 1
    fi
    if ! command -v wkhtmltopdf &> /dev/null; then
      echo "❌ 'wkhtmltopdf' is not installed. PDF engine not found."
      exit 1
    fi
    pandoc "$SUMMARY_MD" -o "$PDF_FILE" --pdf-engine=wkhtmltopdf
    echo "[📄] PDF written to: $PDF_FILE"
    ;;

  3)
    if ! command -v pandoc &> /dev/null; then
      echo "❌ 'pandoc' is not installed. Install it first."
      exit 1
    fi
    pandoc "$SUMMARY_MD" -o "$HTML_FILE"
    echo "[🌐] HTML file saved to: $HTML_FILE"
    xdg-open "$HTML_FILE" &> /dev/null &
    ;;

  *)
    echo "❌ Invalid selection. Please enter 1, 2, or 3."
    exit 1
    ;;
esac
