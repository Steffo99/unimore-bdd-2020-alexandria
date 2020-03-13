# Utenti DBMS

| Utente DBMS | Permessi |
|-------------|----------|
| Applicazione | |
| Moderatore | |
| Amministratore | |

# Schemas

| Schemas | Contenuti |
|---------|-----------|
| `public` | Contiene le cose in comune tra tutto il database, come gli utenti del sito |
| `books` | Contiene le tabelle relative ai libri |
| `audiobooks` | Contiene le tablele relative agli audiolibri |
| `movies` | Contiene le tabelle relative ai film |
| `games` | Contiene le tabelle relative ai giochi |
| ... | ... |

## Schema `public`

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Utente | **id**, username, hash_password, email | | | Questi sono gli utenti finali, che interagiscono con il database solo tramite applicazione. | 

## Schema `books`

| Nome | Dati | Sinonimi | Collegamenti | Note |
|------|------|----------|--------------|------|
| Libro | **isbn**, nome, pagine, sinossi, ... | | posseduto da Utente, scritto da Autore, pubblicato da Editore | |
| Autore | | | | |
| Editore | | | | |

## Schema `audiobooks`

## Schema `movies`

## Schema `games`
