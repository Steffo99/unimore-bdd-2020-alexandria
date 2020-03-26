# Glossario 

## Utenti

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Utente | id, username, hash della password, email, è amministratore, è bannato | user, admin, amministratore | possiede Elementi | |

## Elementi

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Elemento | stato, provenienza | | di una copia di un Libro / Film / Videogioco, posseduto da un Utente | |

## Recensioni

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Recensione | valutazione (0-100), commento, data, è nascosto | valutazione, commento, post | riguardante un Elemento | |

## Libri

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Libro | titolo originale, sinossi | testo, saggio, romanzo, opuscolo | scritto da uno o più Autori, appartenente a uno o più Generi, con più Edizioni (libro, audio) | |
| Genere | nome | | a cui appartengono i Libri | |
| Edizione (libro) | **isbn**, titolo localizzato, pagine, copertina | _Libro_ (ambiguo), pubblicazione, stampa | di un Libro, posseduta da più Utenti (_Elemento_), pubblicata da un Editore | |
| Edizione (audio) | **isbn**, titolo localizzato, durata, immagine | | di un Libro, posseduta da più Utenti (_Elemento_), pubblicata da un Editore, narrata da uno o più Narratori | |
| Autore | nome | scrittore | scrive dei Libri | |
| Editore | nome | | pubblica delle Edizioni (libro, audio) | |
| Narratore | nome | voce narrante | narra delle Edizioni (audio) | |

## Film

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Film | **eidr**, titolo originale, sinossi, durata, immagine | | guardato da Utenti, realizzato da Cast, prodotto da Studio, appartenente a Generi, scritto da Sceneggiatori | |
| Genere | nome | | a cui appartengono i Film | |
| Cast | nome | "attore", "regista", "scenografo", "produttore esecutivo" | ruolo nel film | I ruoli sono specificati nella tabella Ruolo |
| Ruolo | nome | | di _qualcuno che ha lavorato in un film_ | |
| Studio | nome | azienda, casa produttrice | che ha prodotto un Film | |
| Titolo tradotto | titolo alternativo, lingua | titolo | relativo a un Film | |

## Giochi

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Gioco | titolo, descrizione | videogioco, videogame | sviluppato da Sviluppatore, pubblicato da Publisher, appartenente a Generi, con più Edizioni | |
| Edizioni | piattaforma, box art, studio porting, nome2 (opz.) | | di un Gioco, giocata da Utenti | | 
| Generi | nome | | a cui appartengono Giochi | |
| Sviluppatore | nome | | che ha sviluppato Giochi | |
| Publisher | nome | | che ha pubblicato Giochi | |