PUNCH = ../.papermill/node_modules/punch/bin/punch

default:
	$(PUNCH) generate
	iconv -f ISO-8859-1 -t UTF-8 Bilder.html > Bilder-generated.markdown && \
	rm Bilder.html