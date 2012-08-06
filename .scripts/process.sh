#!/bin/sh

# This script is called from the ../Makefile

# Where we are
BASE_DIR="$(pwd)"

# Find every folder and start a loop for it
for DIR in $(find * -maxdepth 0 -type d )
do
    echo "[>] Processing "$DIR"..."
    cd "$BASE_DIR"/"$DIR"

    # Process MARKDOWN Files
    echo "[>] Processing MARKDOWN..."

    # delete $TMP_FILE if exists
    TMP_FILE=".$DIR.generated.markdown.tmp"
    [[ -f "$TMP_FILE" ]] && rm "$TMP_FILE" 

    # Process all Files in directory
    for FILE in *.markdown
    do
        [[ -f "$FILE" ]] || continue ## abort if no match in DIR
        echo "    [+] $FILE"
        cat "$FILE" >> "$TMP_FILE"
        echo "\n" >> "$TMP_FILE"
    done
    
    # Move the generated markdown file into base dir
    [[ -f "$TMP_FILE" ]] && mv "$TMP_FILE" ../"$DIR.generated.markdown" && echo "[!] Generated "$DIR.generated.markdown" in "$BASE_DIR"."

    # END Process MARKDOWN Files

done
echo "[!] Finished processing "$DIR"..."
