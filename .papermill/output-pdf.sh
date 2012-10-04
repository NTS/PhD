#!/bin/sh

# This script is called from the ../Makefile

source ~/.profile

# Where we are
BASE_DIR="$(pwd)"

# DEV: Version and Date in Title
GITHASH="$(git log -1 --pretty=format:"%H")"
echo "" > "Version.markdown"
echo "> Version: \`\`$GITHASH\`\`  " >> "Version.markdown"
#echo "> Datum: \`\`$(date)\`\`  " >> "Version.markdown"
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
	
    if ( ls "$PAPER"/*.markdown >/dev/null )
        then echo Y
    else echo N
    fi
    
    echo "    [#] Generating PDF: $PAPER ..."
    
    # if there is a local imprint
    if [[ -e "$PAPER"_Impressum.markdown ]] 
    then
        # convert to latex
        ~/.cabal/bin/pandoc ""$PAPER"_Impressum.markdown" \
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
        --include-in-header=.papermill/nts-header.latex \
        --no-tex-ligatures \
        --variable=lang:german \
        --variable=urlcolor:black \
        --variable=linkcolor:black \
        --variable=verbatim-in-note:true \
        --variable=title-meta:"Als ich Künstler war" \
        --variable=biblio-title:"Biliographie" \
		\
		--include-before-body="_After-Title.generated.latex" \
		--include-before-body="Version.generated.latex" \
		--include-after-body="$IMPRINT" \
		\
		--output=""$PAPER".pdf"
		
		#--variable=links-as-notes:true
        #--template="./.papermill/nts.latex" \

	} && {
	    echo "SUCCESS"
        mv ""$PAPER".pdf" ""$PAPER"_"$GITHASH".pdf"
		cp ""$PAPER"_"$GITHASH".pdf" ~/"Dropbox/MFA+NTS/PHD.NTS-output"
		open ""$PAPER"_"$GITHASH".pdf"
	}
	
    [[ -e ""$PAPER"_Impressum.generated.latex" ]] && rm ""$PAPER"_Impressum.generated.latex"
    
	echo "[<] Finished processing "$PAPER"..."
	# END Process MARKDOWN Files
	
done

# CLEANUP
rm "_After-Title.generated.latex" *"_Impressum.generated.latex" "Version.markdown" "Version.generated.latex"
