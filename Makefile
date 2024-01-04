PROJECT = main

PDFLATEX_FLAGS  = -halt-on-error -output-directory obj/

TEX_FILES = $(shell find . -name '*.tex' -or -name '*.sty' -or -name '*.cls')
BIB_FILES = $(shell find . -name '*.bib')
BST_FILES = $(shell find . -name '*.bst')
IMG_FILES = $(shell find . -path '*.jpg' -or -path '*.png' -or \( \! -path './obj/*.pdf' -path '*.pdf' \) )

report: obj/$(PROJECT).pdf

clean:
	rm -rf obj/

obj/:
	mkdir -p obj/

obj/$(PROJECT).aux: $(TEX_FILES) $(IMG_FILES) | obj/
	xelatex $(PDFLATEX_FLAGS) $(PROJECT)

obj/$(PROJECT).bbl: $(BIB_FILES) | obj/$(PROJECT).aux
	bibtex obj/$(PROJECT)
	xelatex $(PDFLATEX_FLAGS) $(PROJECT)
	
obj/$(PROJECT).pdf: obj/$(PROJECT).aux $(if $(BIB_FILES), obj/$(PROJECT).bbl)
	xelatex $(PDFLATEX_FLAGS) $(PROJECT)
