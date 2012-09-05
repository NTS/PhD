#!/bin/sh

# This script is called from the ../Makefile

# VARS
source ./.papermill/papermill.config

# Where we are
BASE_DIR="$(pwd)"

# Find every folder and start a loop for it
for PAPER in $(find * -maxdepth 0 -type d )
do

    # Generate PDF Files
	cd "$BASE_DIR"
	pwd
    echo "    [#] Generating PDF..."

	{
		~/.cabal/bin/pandoc "$PAPER.generated.markdown" \
		\
		--smart \
		--normalize \
		--number-sections \
		--section-divs \
		--toc \
		--bibliography="./BIBTEX/biblio.phd.nts.bib" \
		--csl=".papermill/CSL/din-1505-2.csl" \
		\
		--to=latex \
		--latex-engine=xelatex \
		--template="./.papermill/nts.latex" \
		--no-tex-ligatures \
		--output="$PAPER.pdf"
		
	} && {
	
		cp $PAPER.pdf.pdf ~/Dropbox/MFA+NTS/PHD.NTS-output
		open "$PAPER.pdf"
	}
	
	echo "[<] Finished processing "$PAPER"..."
	# END Process MARKDOWN Files
	
done