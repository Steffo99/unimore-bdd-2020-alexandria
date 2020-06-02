# Creazione dello schema logico

Di seguito si riporta l'intero schema logico dopo aver effettuato tutte le trasformazioni previste dalla fase di progettazione logica.

## Legenda

- Entità
    - **Chiave primaria**
    - → [Chiave esterna](#legenda)
    - _Opzionale_

## Generale

### Utente
- **Username**
- Password
- _Email_
- È amministratore
- È bannato

## Condiviso tra libri e audiolibri

### Libro
- **ID**
- Titolo primario
- _Sinossi_

### Appartenenza a genere (libro)
- **ID Genere** → [Genere (libro)](#genere-libro)
- **ID Libro** → [Libro](#libro)

### Autore
- **ID**
- Nome

### Correlazioni (libro)
- **ID1** → [Libro](#libro)
- **ID2** → [Libro](#libro)

### Editore
- **Parte ISBN**
- Nome

### Genere (libro)
- **ID**
- Nome

### Scritto da
- **ID Autore** → [Autore](#autore)
- **ID Libro** → [Libro](#libro)

## Schema dei libri

### Edizione (libro)
- **ISBN**
- Titolo
- _Pagine_
- _Copertina_
- Relativa a → [Libro](#libro)

### Elemento (libro)
- **ID**
- Istanza di → [Edizione (libro)](#edizione-libro)
- Appartiene a → [Utente](#utente)
- _Stato_
- _Provenienza_

### Recensione (libro)
- **ID** → [Elemento (libro)](#elemento-libro)
- Commento
- Valutazione
- Data

## Schema degli audiolibri

### Edizione (audiolibro)
- **ISBN**
- Titolo
- _Durata_
- _Immagine_
- Relativa a → [Libro](#libro)

### Elemento (audiolibro)
- **ID**
- Istanza di → [Edizione (audiolibro)](#edizione-audiolibro)
- Appartiene a → [Utente](#utente)
- _Stato_
- _Provenienza_

### Narrata da
- **ID Edizione** → [Edizione (audiolibro)](#edizione-audiolibro)
- **ID Narratore** → [Narratore](#narratore)

### Narratore
- **ID**
- Nome

### Recensione (audiolibro)
- **ID** → [Elemento (audiolibro)](#elemento-audiolibro)
- Commento
- Valutazione
- Data

## Film

### Film
- **EIDR**
- Titolo
- _Sinossi_
- _Durata_
- _Locanddina_

### Appartenenza a genere (film)
- **ID Genere** → [Genere](#genere-film)
- **EIDR** → [Film](#film)

### Cast
- **ID**
- Nome

### Correlazioni (film)
- **EIDR1** → [Film](#film)
- **EIDR2** → [Film](#film)

### Elemento (film)
- **ID**
- _Stato_
- _Provenienza_
- Istanza di → [Film](#film)
- Appartiene a → [Utente](#utente)

### Genere (film)
- **ID**
- Nome

### Localizzazione
- **Lingua**
- **EIDR** → [Film](#film)
- Titolo localizzato

### Prodotto da
- **ID Studio** → [Studio](#studio-film)
- **EIDR** → [Film](#film)

### Recensione (film)
- **ID** → [Recensione (film)](#elemento-film)
- Commento
- Valutazione
- Data

### Ruolo
- **ID**
- Nome

### Studio (film)
- **ID**
- Nome

### Vi ha preso parte
- **EIDR** → [Film](#film)
- **ID Cast** → [Cast](#cast)
- **ID Ruolo** → [Ruolo](#ruolo)

## Giochi

### Gioco
- **ID**
- Nome
- _Descrizione_

### Appartenenza a genere (gioco)
- **ID Gioco** → [Gioco](#gioco)
- **ID Genere** → [Genere (gioco)](#genere-gioco)

### Correlazioni (gioco)
- **ID1** → [Gioco](#gioco)
- **ID2** → [Gioco](#gioco)

### Edizione (gioco)
- **ID**
- _Titolo alternativo_
- Piattaforma
- _Box art_
- Relativa a → [Gioco](#gioco)

### Elemento (gioco)
- **ID**
- _Stato_
- _Provenienza_
- Istanza di → [Edizione (gioco)](#edizione-gioco)
- Appartiene a → [Utente](#utente)

### Genere (gioco)
- **ID**
- Nome

### Portato da
- **ID Edizione** → [Edizione (gioco)](#edizione-gioco)
- **ID Studio** → [Studio (gioco)](#studio-gioco)

### Prodotto da
- **ID Gioco** → [Gioco](#gioco)
- **ID Studio** → [Studio (gioco)](#studio-gioco)

### Recensione (gioco)
- **ID** → [Recensione (gioco)](#elemento-gioco)
- Commento
- Valutazione
- Data

### Studio (gioco)
- **ID**
- Nome

### Sviluppato da
- **ID Gioco** → [Gioco](#gioco)
- **ID Studio** → [Studio (gioco)](#studio-gioco)

