#!/bin/bash


# Debe ser DOMINGO
START_DATE="2025-01-05"
COMMIT_MSG="pixel"

declare -A LETTERS

LETTERS[V]=(
"10001"
"10001"
"01010"
"01010"
"00100"
)

LETTERS[I]=(
"11111"
"00100"
"00100"
"00100"
"11111"
)

LETTERS[E]=(
"11111"
"10000"
"11110"
"10000"
"11111"
)

LETTERS[W]=(
"10001"
"10001"
"10101"
"11011"
"10001"
)

LETTERS[S]=(
"11111"
"10000"
"11111"
"00001"
"11111"
)

LETTERS[O]=(
"01110"
"10001"
"10001"
"10001"
"01110"
)

LETTERS[F]=(
"11111"
"10000"
"11110"
"10000"
"10000"
)

LETTERS[T]=(
"11111"
"00100"
"00100"
"00100"
"00100"
)

WORD="VIEWSOFT"
WEEK_OFFSET=0

for ((i=0; i<${#WORD}; i++)); do
  LETTER=${WORD:$i:1}
  MATRIX=("${LETTERS[$LETTER][@]}")

  for col in {0..4}; do
    for row in {0..4}; do
      if [ "${MATRIX[$row]:$col:1}" == "1" ]; then
        OFFSET=$((WEEK_OFFSET * 7 + col * 7 + row))
        DATE=$(date -d "$START_DATE + $OFFSET days" +"%Y-%m-%dT12:00:00")

        echo "$DATE" >> README.md
        git add README.md
        GIT_AUTHOR_DATE="$DATE" GIT_COMMITTER_DATE="$DATE" git commit -m "$COMMIT_MSG"
      fi
    done
  done

  WEEK_OFFSET=$((WEEK_OFFSET + 6)) # 5 columnas + 1 espacio
done
