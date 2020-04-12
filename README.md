# `alexandria`

A database for an hypotetical website for users to organize and share their media library.

Made as a collaboration between [@Steffo99](https://github.com/Steffo99/) and [@Cookie-CHR](https://github.com/Cookie-CHR) for the [Basi di Dati](http://personale.unimore.it/rubrica/contenutiad/rmartoglia/2019/58030/N0/N0/9999) exam at [Unimore](https://www.unimore.it/).

> This project is still a work in progress!

> Parts of this project may be in Italian, as the Basi di Dati course is in Italian.

## Specification

The specification for the project is available [in the `spec.pdf` file](/spec.pdf).

## Tasks

- [x] [Descrizione](/descrizione.md)
- [x] [Glossario](/glossario.md)
- [x] [Schema scheletro](/schema-scheletro.drawio)
- [x] [Identificazione delle autoassociazioni](/autoassociazione.md)
- [x] [Identificazione delle chiavi esterne](/chiaviesterne.md)
- [ ] ...?
- [x] [Schema finale](/schema-finale.drawio)

## Compiling

### Requirements

- [Pandoc](https://pandoc.org/)
- [MiKTeX](https://miktex.org/)

### Instructions

To create PDF files from the Markdown sources in this project, you can run the Makefile with the `make` command, or compile them manually with the following command:

```bash
pandoc -o filename.pdf filename.md
```
