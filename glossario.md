# Glossario 

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
| ... | ... |

### Schema `public`

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Utente | **id**, username, hash_password, email | | | Questi sono gli utenti finali, che interagiscono con il database solo tramite applicazione. | 

### Schema `books`

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Libro | **isbn**, nome, pagine, sinossi, ... | | posseduto da Utenti, scritto da Autori, pubblicato da Editore | |
| Autore | **_id interno_**, nome, cognome, ... | | scrive dei Libri | |
| Editore | **isbn_id**, nome | | pubblica dei Libri | |
| Recensione | **_id interno_**, valutazione, testo | | scritta da Utente, riguardante un Libro |

### Schema `audiobooks`

<span style="color: orange;">TODO</span>

### Schema `movies`

<span style="color: orange;">TODO</span>

### Schema `games`

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Gioco | **_id interno_**, nome | | posseduto da Utenti, sviluppato da Aziende, pubblicato da Azienda, appartenente a Generi | |
| Generi | **_id interno_**, nome | | a cui appartengono Giochi | |
| Azienda | **_id interno_**, nome | | che ha sviluppato Giochi, che ha pubblicato Giochi | |
| Recensione | **_id interno_**, valutazione, testo | | scritta da Utente, riguardante un Gioco |
