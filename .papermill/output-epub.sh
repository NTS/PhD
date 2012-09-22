#!/bin/sh

# This script is called from the ../Makefile

# Where we are
BASE_DIR="$(pwd)"

# Find every folder and start a loop for it
for DIR in $(find * -maxdepth 0 -type d -not \( -name "images" \))
do

    # Process MARKDOWN Files
	cd "$BASE_DIR"
	pwd
    echo "    [#] Processing MARKDOWN..."

	~/.cabal/bin/pandoc "$DIR.generated.markdown" \
	--write=epub --standalone --smart --toc --section-divs --normalize --number-sections \
	--css=".papermill/nts.css" \
	--bibliography="./BIBTEX/biblio.phd.nts.bib" \
	--csl=".papermill/CSL/din-1505-2.csl" \
	--output="$DIR.epub"
	
	echo "[<] Finished processing "$DIR"..."
	# END Process MARKDOWN Files
	
	#open -g -a /Applications/Safari.app "$DIR.generated.html"

done

open -g -a /Applications/Safari.app "PhD_Dissertation.generated.html"
