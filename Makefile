# This is the Makefile
#
# It is run by the git-hook post-commit
# or manually by entering the directory in a shell and issuing the command
# 'make'

GIT = /usr/bin/git
PANDOC = ~/.cabal/bin/pandoc

default: html

all: html pdf epub rtf docx odt json native

chapters:
	sh .papermill/process-chapters.sh

html: chapters
	sh .papermill/output-html.sh

pdf: chapters
	sh .papermill/output-pdf.sh
	
# iBook
epub: chapters
	${PANDOC} "PhD_Dissertation.generated.markdown" --to=epub --output="PhD_Dissertation.epub"
	#open PhD_Dissertation.epub
	
# Rich Text
rtf: chapters
	${PANDOC} "PhD_Dissertation.generated.markdown" --to=rtf --output="PhD_Dissertation.generated.rtf"
	open PhD_Dissertation.generated.rtf
	
# Word
docx: chapters
	${PANDOC} "PhD_Dissertation.generated.markdown" --to=docx --output="PhD_Dissertation.generated.docx"
	#open PhD_Dissertation.generated.docx
	
# OpenOffice
odt: chapters
	${PANDOC} "PhD_Dissertation.generated.markdown" --to=odt --output="PhD_Dissertation.generated.odt"
	#open PhD_Dissertation.generated.odt
	
# JSON
json: chapters
	${PANDOC} "PhD_Dissertation.generated.markdown" --to=json --output="PhD_Dissertation.generated.json"
	#open PhD_Dissertation.generated.json
	
# Native Haskell
native: chapters
	${PANDOC} "PhD_Dissertation.generated.markdown" --to=native --output="PhD_Dissertation.generated.hs"
	#open PhD_Dissertation.hs
	
