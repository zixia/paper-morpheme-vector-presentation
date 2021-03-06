#!/usr/bin/env bash
set -e

[ -z "$1" ] && {
  echo 'Usage: build.sh <docx | html | pdf | tex>'
  exit 1
}

[ -d dist/ ] || mkdir dist

# 乱码
# --include-in-header latex/longtable-preamble.tex \

# Not Work
# --include-in-header latex/longtable-preamble-xtabular.tex \

PAPER_FILENAME='A Mini Review for Word Embedding in Morpho'

pandoc \
  --pdf-engine=xelatex \
  --filter=pandoc-citeproc \
  \
  --variable=classoption:twocolumn \
  --variable=papersize:a4paper \
  \
  --bibliography=paper/citations.bib \
  --metadata-file=paper/metadata.yaml \
  \
  --filter=latex/longtable-filter.py \
  -V tables \
  \
  -s paper/text.md \
  -o "dist/${PAPER_FILENAME}.$1"
