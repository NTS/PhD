#!/bin/sh

# This script is called from the ../Makefile

function combine_chapters()
{
	    # Process CHAPTER Files
    echo "    [#] Processing CHAPTERS..."

    # delete $TMP_FILE if exists
    TMP_FILE=".$DIR.generated.markdown.tmp"
    [[ -f "$TMP_FILE" ]] && rm "$TMP_FILE" 

    # Process all Files in directory
    for FILE in *.markdown
    do
        [[ -f "$FILE" ]] || return 0 ## abort if no match in DIR
        echo "        [+] $FILE"
        cat "$FILE" >> "$TMP_FILE"
        echo >> "$TMP_FILE"          ## insert linebreak
        echo >> "$TMP_FILE"          ## insert linebreak
    done
    
    # Move the generated markdown file into base dir
    [[ -f "$TMP_FILE" ]] && mv "$TMP_FILE" ../"$DIR.generated.markdown" && echo "    [!] Generated "$DIR.generated.markdown" in "$BASE_DIR"."

    # END Pre-process CHAPTER Files

}

## START

# Where we are
BASE_DIR="$(pwd)"

# Find every folder and start a loop for it
for DIR in $(find * -maxdepth 0 -type d -not \( -name "images" \))
do
    echo "[>] Entering Folder "$DIR"..."
    cd "$BASE_DIR"/"$DIR" # FIXME: this files with funky folders in repo

    combine_chapters
    
done
