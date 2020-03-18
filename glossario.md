# Glossario 

## Idee

### [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page)

Si potrebbe usare l'id Wikidata di varie entità per ottenere dinamicamente informazioni su di esse...

Ad esempio, se per ogni autore salviamo l'id wikidata abbiamo automaticamente immagine, luogo di nascita, account twitter e un sacco di altra roba!

Però non so quanto possa piacere al prof., e magari c'è anche qualche altra controindicazione...

### Giochi su più piattaforme

Come si potrebbero gestire i giochi posseduti su piattaforme diverse?

### Template di Wikipedia

I template di Wikipedia danno un sacco di idee interessanti per dati che si possono mettere nelle varie tabelle...

Ad esempio: [Template:FictionTV](https://it.wikipedia.org/wiki/Template:FictionTV)

### Audiolibri

Gli audiolibri alla fine sono edizioni diverse di libri, giusto? Se ricordo bene, anche loro hanno un isbn...

## Utenti DBMS

| Utente DBMS | Permessi |
|-------------|----------|
| Applicazione | |
| Moderatore | |
| Amministratore | |

## Schemas

| Schemas | Contenuti |
|---------|-----------|
| `public` | Contiene le cose in comune tra tutto il database, come gli utenti del sito |
| `books` | Contiene le tabelle relative ai libri |
| `movies` | Contiene le tabelle relative ai film |
| `games` | Contiene le tabelle relative ai giochi |
| `tv-series` | Contiene le serie TV (inclusi anime) | 

### Schema `public`

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Utente | id, username, hash_password, email | | | Questi sono gli utenti finali, che interagiscono con il database solo tramite applicazione. | 

### Schema `books`

> [Template:Libro](https://it.wikipedia.org/wiki/Template:Libro)

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Libro | titolo originale, sinossi | testo, saggio, romanzo, opuscolo | scritto da Autori, con più Edizioni, con più Audioedizioni | |
| Edizione | isbn, titolo, pagine, copertina | _Libro_ (ambiguo), pubblicazione, stampa | di un Libro, posseduta da più Utenti, pubblicata da un Editore | il titolo originale non serve perchè distinguiamo tra i libri con gli ISBN |
| Audioedizione | isbn, titolo, durata | | di un Libro, posseduta da più Utenti, pubblicata da un Editore, narrata da uno o più Narratori | 
| Autore | nome | scrittore | scrive dei Libri | |
| Editore | nome | | pubblica delle Edizioni | |
| Narratore | nome | voce narrante | narra delle Audioedizioni | |
| Recensione | valutazione, testo, data | commento | scritta da Utente, riguardante un Libro posseduto |

### Schema `movies`

> [Template:Film](https://it.wikipedia.org/wiki/Template:Film)

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Film | nome, durata, immagine | | Guardato da Utenti, recitato da Attori, diretto da Regista, prodotto da Azienda, appartenente a Generi, scritto da Sceneggiatori | |
| Genere | nome | | a cui appartengono i Film | |
| _qualcuno che ha lavorato in un film_ | nome | "attore", "regista", "scenografo", "produttore esecutivo" | ruolo nel film | I ruoli sono specificati nella tabella Ruolo |
| Ruolo | nome | | di _qualcuno che ha lavorato in un film_ | |
| Recensione | valutazione, testo, data | commento | scritta da Utente, riguardante un Film guardato |

### Schema `games`

> [Template:Videogioco](https://it.wikipedia.org/wiki/Template:Videogioco)

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Gioco | nome, banner | videogioco, videogame | sviluppato da Aziende, pubblicato da Azienda, appartenente a Generi, con più Edizioni | |
| Edizioni | piattaforma | | di un Gioco, giocata da Utenti | | 
| Generi | nome | | a cui appartengono Giochi | |
| Azienda | nome | | che ha sviluppato Giochi, che ha pubblicato Giochi | |
| Recensione | valutazione, testo, data, ore di gioco | commento | scritta da Utente, riguardante una Edizione giocata |

### Schema `tv-series`

> [Template:FictionTV](https://it.wikipedia.org/wiki/Template:FictionTV)

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Serie TV | nome, immagine | telefilm, fiction | guardata da Utenti, prodotto da Casa produzione, suddivisa in Stagioni | |
| Stagione | nome, immagine | | di una Serie TV, contiene più Episodi | |
| Episodio | numero, durata, nome | puntata | di una Stagione | | 
| Casa produzione | nome | | produce Serie TV | |
| Recensione | valutazione, testo, data | commento | scritta da Utente, riguardante una Serie TV guardata |
