all: descrizione.pdf glossario.pdf autoassociazione.pdf chiaviesterne.pdf

descrizione.pdf: descrizione.md
	pandoc -o descrizione.pdf descrizione.md

glossario.pdf: glossario.md
	pandoc -o glossario.pdf glossario.md

autoassociazione.pdf: autoassociazione.md
	pandoc -o autoassociazione.pdf autoassociazione.md

chiaviesterne.pdf: chiaviesterne.md
	pandoc -o chiaviesterne.pdf chiaviesterne.md
