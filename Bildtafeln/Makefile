PUNCH = ../.papermill/node_modules/punch/bin/punch

default:
	$(PUNCH) generate
	@#iconv -f ISO-8859-1 -t UTF-8 Bilder.html > Bilder-generated.markdown && \
	@#rm Bilder.html
	mv Bilder.html Bilder.generated.markdown
	#
	mkdir -p ../Bildtafeln_ohneRechteDritter
	mv Bilder_ohneRechteDritter.html ../Bildtafeln_ohneRechteDritter/Bilder_ohneRechteDritter.generated.markdown
