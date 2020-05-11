# ![Alexandria](img/0-README/alexandria.png)

A database for an hypotetical website for users to organize and share their media library.

Made as a collaboration between [@Steffo99](https://github.com/Steffo99/) and [@Cookie-CHR](https://github.com/Cookie-CHR) for the [Basi di Dati](http://personale.unimore.it/rubrica/contenutiad/rmartoglia/2019/58030/N0/N0/9999) exam at [Unimore](https://www.unimore.it/).

> This project is still a work in progress!

> Parts of this project may be in Italian, as the Basi di Dati course is in Italian.

## Specification

The specification for the project is available [in the `spec.pdf` file](/spec.pdf).

## Report structure

1. **[Descrizione](1-descrizione.md)**
2. **[Glossario](2-glossario.md)**
3. **Progettazione concettuale**
    1. [Schema scheletro iniziale](3-1-schema-scheletro.md)
    2. [Classificazione delle gerarchie](3-2-gerarchie.md)
    3. [Identificazione delle autoassociazioni](3-3-autoassociazioni.md)
    4. [Classificazione delle relazioni](3-4-relazioni.md)
    5. [Schema scheletro finale](3-5-schema-finale.md)

## Compiling

### Requirements

- [Pandoc](https://pandoc.org/)
- [MiKTeX](https://miktex.org/)

### Instructions

To create PDF files from the Markdown sources in this project, you can run the Makefile with the `make` command, or compile them manually with the following command:

```bash
pandoc -o filename.pdf filename.md
```
