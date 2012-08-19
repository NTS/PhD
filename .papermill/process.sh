#!/bin/sh

# This script is called from the ../Makefile

# Where we are
BASE_DIR="$(pwd)"

# Find every folder and start a loop for it
for DIR in $(find * -maxdepth 0 -type d )
do
    echo "[>] Entering Folder "$DIR"..."
    cd "$BASE_DIR"/"$DIR"

    # Process CHAPTER Files
    echo "    [#] Processing CHAPTERS..."

    # delete $TMP_FILE if exists
    TMP_FILE=".$DIR.generated.markdown.tmp"
    [[ -f "$TMP_FILE" ]] && rm "$TMP_FILE" 

    # Process all Files in directory
    for FILE in *.markdown
    do
        [[ -f "$FILE" ]] || continue ## abort if no match in DIR
        echo "        [+] $FILE"
        cat "$FILE" >> "$TMP_FILE"
        echo "\n" >> "$TMP_FILE"
    done
    
    # Move the generated markdown file into base dir
    [[ -f "$TMP_FILE" ]] && mv "$TMP_FILE" ../"$DIR.generated.markdown" && echo "    [!] Generated "$DIR.generated.markdown" in "$BASE_DIR"."

    # END Pre-process CHAPTER Files

    # Process MARKDOWN Files
	cd "$BASE_DIR"
	pwd
    echo "    [#] Processing MARKDOWN..."

	~/.cabal/bin/pandoc "$DIR.generated.markdown" \
	--write=html5 --standalone --smart --toc --section-divs --normalize --number-sections \
	--css=".papermill/swiss.css" \
	--bibliography="./BIBTEX/biblio.phd.nts.bib" \
	--csl=".papermill/CSL/din-1505-2.csl" \
	--output="$DIR.generated.html"
	
	echo "[<] Finished processing "$DIR"..."
	# END Process MARKDOWN Files
	
	#open -g -a /Applications/Safari.app "$DIR.generated.html"

done

open -g -a /Applications/Safari.app "PhD_Dissertation.generated.html"
