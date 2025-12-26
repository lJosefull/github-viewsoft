#!/bin/bash

START_DATE="2025-01-05" # DOMINGO
COMMIT_MSG="pixel"

get_letter() {
  case "$1" in
    V) echo -e "10001\n10001\n01010\n01010\n00100" ;;
    I) echo -e "11111\n00100\n00100\n00100\n11111" ;;
    E) echo -e "11111\n10000\n11110\n10000\n11111" ;;
    W) echo -e "10001\n10001\n10101\n11011\n10001" ;;
    S) echo -e "11111\n10000\n11111\n00001\n11111" ;;
    O) echo -e "01110\n10001\n10001\n10001\n01110" ;;
    F) echo -e "11111\n10000\n11110\n10000\n10000" ;;
    T) echo -e "11111\n00100\n00100\n00100\n00100" ;;
  esac
}

WORD="VIEWSOFT"
WEEK_OFFSET=0

for ((i=0; i<${#WORD}; i++)); do
  LETTER=${WORD:$i:1}
  ROW=0

  get_letter "$LETTER" | while read -r LINE; do
    for COL in {0..4}; do
      if [ "${LINE:$COL:1}" = "1" ]; then
        OFFSET=$((WEEK_OFFSET * 7 + COL * 7 + ROW))
        DATE=$(date -d "$START_DATE + $OFFSET days" +"%Y-%m-%dT12:00:00")

        echo "$DATE" >> README.md
        git add README.md
        GIT_AUTHOR_DATE="$DATE" GIT_COMMITTER_DATE="$DATE" git commit -m "$COMMIT_MSG"
      fi
    done
    ROW=$((ROW + 1))
  done

  WEEK_OFFSET=$((WEEK_OFFSET + 6)) # 5 columnas + 1 espacio
done
