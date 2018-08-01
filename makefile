# From Stack-Exchange user DevSolar, with modifications to work with markdown
# workflow:
#        https://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project
#
# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
.PHONY: main.pdf all clean chapters

.SUFFIXES:
.SUFFIXES: .tex .markdown .pdf

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interaction=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.
main.pdf: main.tex chapters
	latexmk -f -pdf -lualatex -use-make main.tex

chapters:
	( cd chapters; $(MAKE) all || exit 1 )

all: main.pdf chapters

clean:
	latexmk -CA

veryclean:
	( latexmk -CA; cd chapters; rm *.tex )
