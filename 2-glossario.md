# Glossario 

## Generale

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Utente | username, hash della password, email, è amministratore, è bannato | user, admin, amministratore | possiede Elementi | |
| Elemento | stato, provenienza | | di una copia di un Libro / Film / Videogioco, posseduto da un Utente | |
| Recensione | valutazione (0-100), commento, data, è nascosto | valutazione, commento, post | riguardante un Elemento | |

## Libri

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Libro | titolo originale, sinossi | testo, saggio, romanzo, opuscolo | scritto da uno o più Autori, appartenente a uno o più Generi, con più Edizioni (libro, audio), correlato ad altri Libri | |
| Genere | nome | | a cui appartengono i Libri | |
| Edizione (libro) | **isbn**, titolo localizzato, pagine, copertina | _Libro_ (ambiguo), pubblicazione, stampa | di un Libro, posseduta da più Utenti (_Elemento_), pubblicata da un Editore | |
| Edizione (audio) | **isbn**, titolo localizzato, durata, immagine | | di un Libro, posseduta da più Utenti (_Elemento_), pubblicata da un Editore, narrata da uno o più Narratori | |
| Autore | nome | scrittore | scrive dei Libri | |
| Editore | nome | | pubblica delle Edizioni (libro, audio) | |
| Narratore | nome | voce narrante | narra delle Edizioni (audio) | |

## Film

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Film | **eidr**, titolo originale, sinossi, durata, locandina | pellicola | guardato da Utenti (_Elemento_), realizzato da Cast, prodotto da Studio, appartenente a Generi, scritto da Sceneggiatori, correlato ad altri Film | |
| Genere | nome | | a cui appartengono i Film | |
| Cast | nome | "attore", "regista", "scenografo", "produttore esecutivo" | Prende parte al Film, ha un Ruolo | I ruoli sono specificati nella tabella Ruolo |
| Ruolo | nome | | di Cast | Il ruolo è un attributo! |
| Studio | nome | azienda, casa produttrice | che ha prodotto un Film | |
| Localizzazione | titolo alternativo, lingua | titolo | relativo a un Film | |

## Giochi

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Gioco | titolo, descrizione | videogioco, videogame | sviluppato da uno o più Studio, pubblicato da uno o più Studio, appartenente a Generi, con più Edizioni | |
| Edizioni | piattaforma, box art, titolo alternativo | | di un Gioco, giocata da Utenti (_Elemento_), portato da uno o più Studio | | 
| Generi | nome | | a cui appartengono Giochi | |
| Studio | nome | | che ha sviluppato Giochi, che ha portato Edizioni | |
