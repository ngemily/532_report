OBJ=src/main
SRC=$(OBJ).md
PDF=$(OBJ).pdf
TEX=$(OBJ).tex

SECS := $(patsubst %.md,%.tex,$(wildcard src/*.md))

all: $(SECS)
	pandoc --standalone -o $(TEX) $(SRC)
	rubber --module=biber --pdf $(OBJ)

%.tex : %.md
	pandoc $< -o $@

preview:
	qlmanage -p $(PDF) &> /dev/null

clean:
	find . -type f -name '*.tex' -delete
	find . -type f -name '*.aux' -delete
	find . -type f -maxdepth 1 -name 'main*' -delete

## Produce PDFs from all Markdown files in a directory
## Lincoln Mullen | http://lincolnmullen.com | lincoln@lincolnmullen.com
#
## List files to be made by finding all *.md files and appending .pdf
#PDFS := $(patsubst %.md,%.md.pdf,$(wildcard *.md))
#
## The all rule makes all the PDF files listed
#all : $(PDFS)
#                        
## This generic rule accepts PDF targets with corresponding Markdown 
## source, and makes them using pandoc
#%.md.pdf : %.md
#	pandoc $< -o $@
#
## Remove all PDF outputs
#clean :
#	rm $(PDFS)
#
## Remove all PDF outputs then build them again
#rebuild : clean all
