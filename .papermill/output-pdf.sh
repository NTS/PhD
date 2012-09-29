#!/bin/sh

# This script is called from the ../Makefile

source ~/.profile

# Where we are
BASE_DIR="$(pwd)"

# DEV: Version and Date in Title
echo "" > "Version.markdown"
echo "> Version: \`\`$(git log -1 --pretty=format:"%H")\`\`  " >> "Version.markdown"
echo "> Datum: \`\`$(date)\`\`  " >> "Version.markdown"
echo "" >> "Version.markdown"


for BLOCK in "_Impressum" "_After-Title" "Version"
do \
	{	# MAKE TITLE AFTER
		~/.cabal/bin/pandoc ""$BLOCK".markdown" \
		\
		--smart \
		--normalize \
		\
		--to=latex \
		--latex-engine=xelatex \
		--no-tex-ligatures \
		\
		--output=""$BLOCK".generated.latex"
		
	} && { 
		echo "Made block "$BLOCK"" 
	} || { 
		echo "Could not make block "$BLOCK"" 
	}
done

# Find every folder and start a loop for it
for PAPER in $(find * -maxdepth 0 -type d -not \( -name "images" \))
do

    # Generate PDF Files
	cd "$BASE_DIR"
	pwd
    echo "    [#] Generating PDF..."
    
    # if there is a local imprint
    if [[ -e "$PAPER"/_Impressum.markdown ]] 
    then
        # convert to latex
        ~/.cabal/bin/pandoc ""$PAPER"/_Impressum.markdown" \
		--smart --normalize \
		--to=latex --latex-engine=xelatex --no-tex-ligatures \
		--output=""$PAPER"_Impressum.generated.latex"
        # set variable
        IMPRINT=""$PAPER"_Impressum.generated.latex"
    else
        IMPRINT="_Impressum.generated.latex"
    fi
    
	{   
		~/.cabal/bin/pandoc "$PAPER.generated.markdown" \
		\
		--smart \
		--normalize \
		--number-sections \
		--section-divs \
		--toc \
        --variable=links-as-notes:true \
		--bibliography="./BIBTEX/biblio.phd.nts.bib" \
		--csl=".papermill/CSL/din-1505-2.csl" \
		\
		--to=latex \
		--latex-engine="/usr/texbin/xelatex" \
		--template="./.papermill/nts.latex" \
		--no-tex-ligatures \
		--variable=lang:DE \
		\
		--include-before-body="_After-Title.generated.latex" \
		--include-before-body="Version.generated.latex" \
		--include-after-body="$IMPRINT" \
		\
		--output=""$PAPER".pdf"
		
		#--variable=links-as-notes

	} && {
	
		cp "$PAPER".pdf ~/"Dropbox/MFA+NTS/PHD.NTS-output"
		open "$PAPER.pdf"
	}
	
    rm ""$PAPER"_Impressum.generated.latex"
    
	echo "[<] Finished processing "$PAPER"..."
	# END Process MARKDOWN Files
	
done

# CLEANUP
rm "_After-Title.generated.latex" *"_Impressum.generated.latex" "Version.markdown" "Version.generated.latex"
