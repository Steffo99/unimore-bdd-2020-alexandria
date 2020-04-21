all: descrizione.pdf glossario.pdf autoassociazione.pdf chiaviprimarieesterne.pdf

descrizione.pdf: descrizione.md
	pandoc -o descrizione.pdf descrizione.md

glossario.pdf: glossario.md
	pandoc -o glossario.pdf glossario.md

autoassociazione.pdf: autoassociazione.md img/autoassociazione.png
	pandoc -o autoassociazione.pdf autoassociazione.md

chiaviprimarieesterne.pdf: chiaviprimarieesterne.md img/chiaveprimariaesterna.png
	pandoc -o chiaviprimarieesterne.pdf chiaviprimarieesterne.md

gerarchia.pdf: gerarchia.md img/gerarchia1.png img/gerarchia2.png
	pandoc -o gerarchia.pdf gerarchia.md
