# This is the Makefile
#
# It is run by the git-hook post-commit
# or manually by entering the directory in a shell and issuing the command
# 'make'
#
# oh hai!

GIT = /usr/bin/git
PANDOC = ~/.cabal/bin/pandoc

default: pdf

all: html pdf epub rtf docx odt json native

chapters:
	sh .papermill/process-chapters.sh

punch:
	cd Bildtafeln; make

html: punch chapters
	sh .papermill/output-html.sh

pdf: chapters punch
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
	
# GIT viz
viz:
	gource --title PhD.nts --auto-skip-seconds 3 --follow-user "Naomi T. Salmon" --viewport 1920x1080 --output-framerate 30

viz2file:
	gource --title PhD.nts --auto-skip-seconds 3 --follow-user "Naomi T. Salmon" --viewport 1920x1080 --output-framerate 30 --output-ppm-stream phdntsgource.ppm
	
viz-install:
	brew update
	brew install gource