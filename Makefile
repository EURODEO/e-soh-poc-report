SHELL := /bin/bash 

PANDOC = /usr/bin/pandoc
HTMLFILE = e-soh-poc-doc.html
BROWSER = chromium

html: pandoc

pandoc:
	echo "<h1>E-SOH PoC document</h1>" > pandoc-heading.TMP
	echo "<p>Generated (using Pandoc) from Git at: `date -u +'%F %T UTC'`." >> pandoc-heading.TMP
	echo "<p>Github repository: <a href=\"https://github.com/EURODEO/e-soh-poc-report\">https://github.com/EURODEO/e-soh-poc-report</a></p>" >> pandoc-heading.TMP	
	cat introduction/* >> pandoc.TMP
	echo "" >> pandoc.TMP
	cat poc-experiments/poc-experiments.md >> pandoc.TMP
	echo "" >> pandoc.TMP
	cat poc-experiments/datastore/datastore.md >> pandoc.TMP
	echo "" >> pandoc.TMP
	cat poc-experiments/datastore-elastic/datastore-elastic.md >> pandoc.TMP
	echo "" >> pandoc.TMP
	cat poc-experiments/datastore-sqlvsfiles/datastore-sqlvsfiles.md >> pandoc.TMP
	echo "" >> pandoc.TMP
	cat poc-experiments/event-streaming/event-streaming.md >> pandoc.TMP
	echo "" >> pandoc.TMP
	cat poc-experiments/wis2box/* >> pandoc.TMP
	echo "" >> pandoc.TMP
	cat previous-exp/previous-exp.md >> pandoc.TMP
	echo "" >> pandoc.TMP
	cat previous-exp/3rdpartyPGIS-at-FMI.md >> pandoc.TMP
	echo "" >> pandoc.TMP
	cat previous-exp/3rdparty-GeomesaS3-at-FMI.md >> pandoc.TMP
	echo "" >> pandoc.TMP
	cat previous-exp/EDR-at-FMI.md >> pandoc.TMP
	echo "" >> pandoc.TMP
	cat previous-exp/EDR-at-KNMI.md >> pandoc.TMP
	echo "" >> pandoc.TMP
	cat conclusion/* >> pandoc.TMP
	echo "" >> pandoc.TMP
	$(PANDOC) -s -N -B pandoc-heading.TMP --metadata title="E-SOH PoC report" --toc --toc-depth=2 -c pandoc.css -f markdown -t html pandoc.TMP > $(HTMLFILE)
	rm pandoc.TMP
	rm pandoc-heading.TMP
# 	$(BROWSER) $(HTMLFILE)

clean:
	rm -f $(HTMLFILE)

