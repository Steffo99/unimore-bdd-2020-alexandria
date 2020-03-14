# Glossario 

## Idee

### [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page)

Si potrebbe usare l'id Wikidata di varie entità per ottenere dinamicamente informazioni su di esse...

Ad esempio, se per ogni autore salviamo l'id wikidata abbiamo automaticamente immagine, luogo di nascita, account twitter e un sacco di altra roba!

Però non so quanto possa piacere al prof., e magari c'è anche qualche altra controindicazione...

### Brainstorming

Io (Steffo) sto mettendo tutte le idee che mi vengono in mente, ma immagino che un bel po' di cose andranno tagliate per mantenere la quantità di lavoro fattibile...

### Giochi su più piattaforme

Come si potrebbero gestire i giochi posseduti su piattaforme diverse?

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
| `audiobooks` | Contiene le tablele relative agli audiolibri |
| `movies` | Contiene le tabelle relative ai film |
| `games` | Contiene le tabelle relative ai giochi |
| `tv-series` | Contiene le serie TV (inclusi anime) | 

### Schema `public`

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Utente | **id**, username, hash_password, email | | | Questi sono gli utenti finali, che interagiscono con il database solo tramite applicazione. | 

### Schema `books`

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Libro | **isbn**, nome, pagine, sinossi, ... | | posseduto da Utenti, scritto da Autori, pubblicato da Editore | |
| Autore | **_id interno_**, nome, ... | | scrive dei Libri | |
| Editore | **isbn_id**, nome | | pubblica dei Libri | |
| Recensione | **_id interno_**, valutazione, testo | | scritta da Utente, riguardante un Libro |

### Schema `audiobooks`

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| ... | ... | ... | ... | ... | ... |

### Schema `movies`

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Film | **_id_**, nome, durata | | Posseduto da Utenti, recitato da Attori, diretto da Regista, prodotto da Azienda, appartenente a Generi |  |
| Generi | **_id interno_**, nome | | a cui appartengono Film | |
| Regista | **_id interno_**, nome, ... | | dirige il Film | |
| Azienda | **_id interno_**, nome | | Casa produttrice di Film | |
| Attori | ... |  | Recitano nel Film |potrebbero venirci buone statistiche coi dati derivati, o può diventare un caos |
| Recensione | **_id interno_**, valutazione, testo | | scritta da Utente, riguardante un Film |

### Schema `games`

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Gioco | **_id interno_**, nome | | posseduto da Utenti, sviluppato da Aziende, pubblicato da Azienda, appartenente a Generi | |
| Generi | **_id interno_**, nome | | a cui appartengono Giochi | |
| Azienda | **_id interno_**, nome | | che ha sviluppato Giochi, che ha pubblicato Giochi | |
| Recensione | **_id interno_**, valutazione, testo | | scritta da Utente, riguardante un Gioco |

### Schema `tv-series`

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Tv-Serie | **_id interno_**, nome, episodi, durata_episodio |  | Posseduto da Utenti, prodotto da Azienda, ... |  |
| Azienda | **_id interno_**, nome | | Casa produttrice di Tv-Serie | |
