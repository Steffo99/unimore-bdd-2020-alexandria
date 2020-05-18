# Creazione dello schema logico

## Legenda

- Entità
    - **Chiave primaria**
    - → [Chiave esterna](#legenda)
    - _Opzionale_

## Schema generale

### Utente
- **Username**
- Password
- _Email_
- È amministratore
- È bannato

## Schema condiviso tra libri e audiolibri

### Libro
- **ID**
- Titolo primario
- _Sinossi_

### Editore
- **Parte ISBN**
- Nome

### Autore
- **ID**
- Nome

### Genere (libro)
- **ID**
- Nome

### Correlazioni (libro)
- **ID1** → [Libro](#libro)
- **ID2** → [Libro](#libro)

### Appartenenza a genere (libro)
- **ID Genere** → [Genere (libro)](#genere-libro)
- **ID Libro** → [Libro](#libro)

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
- _Stato_
- _Provenienza_

### Recensione (audiolibro)
- **ID** → [Elemento (audiolibro)](#elemento-audiolibro)
- Commento
- Valutazione
- Data

### Narratore
- **ID**
- Nome

### Narrata da
- **ID Edizione** → [Edizione (audiolibro)](#edizione-audiolibro)
- **ID Narratore** → [Narratore](#narratore)

## Schema dei film

### Film
- **EIDR**
- Titolo
- _Sinossi_
- _Durata_
- _Locanddina_

### Genere (film)
- **ID**
- Nome

### Localizzazione
- **Lingua**
- **EIDR** → [Film](#film)
- Titolo localizzato

### Studio (film)
- **ID**
- Nome

### Cast
- **ID**
- Nome

### Ruolo
- **ID**
- Nome

### Elemento (film)
- **ID**
- _Stato_
- _Provenienza_
- Istanza di → [Film](#film)

### Appartenenza a genere (film)
- **ID Genere** → [Genere](#genere-film)
- **EIDR** → [Film](#film)

### Prodotto da
- **ID Studio** → [Studio](#studio-film)
- **EIDR** → [Film](#film)

### Vi ha preso parte
- **EIDR** → [Film](#film)
- **ID Cast** → [Cast](#cast)
- **ID Ruolo** → [Ruolo](#ruolo)

### Correlazioni (film)
- **EIDR1** → [Film](#film)
- **EIDR2** → [Film](#film)

## Schema dei giochi

### Gioco
- **ID**
- Nome
- _Descrizione_

### Correlazioni (gioco)
- **ID1** → [Gioco](#gioco)
- **ID2** → [Gioco](#gioco)

### Genere (gioco)
- **ID**
- Nome

### Appartenenza a genere (gioco)
- **ID Gioco** → [Gioco](#gioco)
- **ID Genere** → [Genere (gioco)](#genere-gioco)

### Studio (gioco)
- **ID**
- Nome

### Sviluppato da
- **ID Gioco** → [Gioco](#gioco)
- **ID Studio** → [Studio (gioco)](#studio-gioco)

### Prodotto da
- **ID Gioco** → [Gioco](#gioco)
- **ID Studio** → [Studio (gioco)](#studio-gioco)

### Edizione (gioco)
- **ID**
- _Titolo alternativo_
- Piattaforma
- _Box art_
- Relativa a → [Gioco](#gioco)

### Portato da
- **ID Edizione** → [Edizione (gioco)](#edizione-gioco)
- **ID Studio** → [Studio (gioco)](#studio-gioco)

### Elemento (gioco)
- **ID**
- _Stato_
- _Provenienza_
- Istanza di → [Edizione (gioco)](#edizione-gioco)
