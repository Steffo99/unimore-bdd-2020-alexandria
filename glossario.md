# Glossario 

## Utenti

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Utente | id, username, hash_password, email | | _tanti_ | Questi sono gli utenti finali, che interagiscono con il database solo tramite applicazione. |

## Libri

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Libro | titolo originale, sinossi | testo, saggio, romanzo, opuscolo | scritto da Autori, con più Edizioni, con più Audioedizioni | |
| Edizione | isbn, titolo, pagine, copertina | _Libro_ (ambiguo), pubblicazione, stampa | di un Libro, posseduta da più Utenti, pubblicata da un Editore | il titolo originale non serve perchè distinguiamo tra i libri con gli ISBN |
| Audioedizione | isbn, titolo, durata | | di un Libro, posseduta da più Utenti, pubblicata da un Editore, narrata da uno o più Narratori | 
| Autore | nome | scrittore | scrive dei Libri | |
| Editore | nome | | pubblica delle Edizioni | |
| Narratore | nome | voce narrante | narra delle Audioedizioni | |
| Recensione | valutazione, testo, data | commento | scritta da Utente, riguardante una Edizione posseduta |

## Film

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Film | nome, durata, immagine | | Guardato da Utenti, recitato da Attori, diretto da Regista, prodotto da Azienda, appartenente a Generi, scritto da Sceneggiatori | |
| Genere | nome | | a cui appartengono i Film | |
| _qualcuno che ha lavorato in un film_ | nome | "attore", "regista", "scenografo", "produttore esecutivo" | ruolo nel film | I ruoli sono specificati nella tabella Ruolo |
| Ruolo | nome | | di _qualcuno che ha lavorato in un film_ | |
| Recensione | valutazione, testo, data | commento | scritta da Utente, riguardante un Film guardato |

## Giochi

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Gioco | nome, banner | videogioco, videogame | sviluppato da Aziende, pubblicato da Azienda, appartenente a Generi, con più Edizioni | |
| Edizioni | piattaforma | | di un Gioco, giocata da Utenti | | 
| Generi | nome | | a cui appartengono Giochi | |
| Azienda | nome | | che ha sviluppato Giochi, che ha pubblicato Giochi | |
| Recensione | valutazione, testo, data, ore di gioco | commento | scritta da Utente, riguardante una Edizione giocata |

# Serie TV

| Serie TV | nome, immagine | telefilm, fiction | guardata da Utenti, prodotto da Casa produzione, suddivisa in Stagioni | |
| Stagione | nome, immagine | | di una Serie TV, contiene più Episodi | |
| Episodio | numero, durata, nome | puntata | di una Stagione | | 
| Casa produzione | nome | | produce Serie TV | |
| Recensione | valutazione, testo, data | commento | scritta da Utente, riguardante una Serie TV guardata |
