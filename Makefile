LATEX    = pdflatex
BIBTEX   = bibtex
DVIPS    = dvips

BASENAME = OffShell_References

default: OffShell_References

OffShell_References: OffShell_References.tex
	${LATEX}  ${BASENAME}
#	${LATEX}  ${BASENAME}
	${BIBTEX} ${BASENAME}
	${LATEX}  ${BASENAME}
	${LATEX}  ${BASENAME}
#	dvipdf -sPAPERSIZE=a4 -dPDFSETTINGS=/prepress ${BASENAME}

testpdflatex:
	pdflatex  ${BASENAME}
	pdflatex  ${BASENAME}
	bibtex    ${BASENAME}
	pdflatex  ${BASENAME}
	pdflatex  ${BASENAME}

#
# standard Latex targets
#

%.dvi:  %.tex
	$(LATEX) $<

%.bbl:  %.tex *.bib
	$(LATEX) $*
	$(BIBTEX) $*

%.ps:   %.dvi
	$(DVIPS) $< -o $@

%.pdf:  %.tex
	$(PDFLATEX) $<

.PHONY: clean

pandoc:
	export PATH="${PATH}:/home/rclsa/PanDoc/pandoc-2.9.2.1/bin/"
	pandoc --bibliography OffShell_References.bib --csl reviews-of-modern-physics-with-titles.csl --filter pandoc-citeproc OffShell_References.tex -o README.html
	mv README.html README.md

clean:
	rm -f *.aux *.log *.bbl *.blg *.brf *.cb *.ind *.idx *.ilg  \
	      *.inx *.dvi *.toc *.out *~ ~* spellTmp
