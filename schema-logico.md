# Schema logico

Legenda:
- **Grassetto**: Chiave primaria
- → (Freccia): Chiave esterna
- _Corsivo_: Attributo opzionale

<!--TODO: Gestire le gerarchie, capire se è possibile usare il prefisso ISBN per identificare l'editore-->

## Generale

### Utente
- **Username**
- Password
- Email
- Amministratore
- Bannato

### Elemento
- **UUID Elemento**
- Username → Utente
- Stato
- Provenienza

### Recensione
- **UUID Elemento** → Elemento
- Commento
- Valutazione
- Data

## Giochi

### Gioco
- **UUID Gioco**
- Nome
- Descrizione

### Edizione
- **UUID Edizione**
- UUID Gioco → Gioco
- Titolo edizione
- Piattaforma
- Box art

### Correlato a 
- **UUID Gioco 1** → Gioco (UUID Gioco)
- **UUID Gioco 2** → Gioco (UUID Gioco)

### Genere
- **UUID Genere**
- Nome

### Appartiene a
- **UUID Gioco** → Gioco
- **UUID Genere** → Genere

### Studio 
- **UUID Studio**
- Nome

### Portato da
- **UUID Edizione** → Edizione
- **UUID Studio** → Studio

### Sviluppato da 
- **UUID Gioco** → Gioco
- **UUID Studio** → Studio

### Pubblicato da 
- **UUID Gioco** → Gioco
- **UUID Studio** → Studio

## Film

### Film
- **EIDR**
- Titolo
- Sinossi
- Durata
- Locandina

### Genere
- **UUID Genere**
- Nome

### Appartiene a
- **EIDR** → Film
- **UUID Genere** → Genere

### Localizzazione
- **Lingua**
- EIDR → Film
- Titolo localizzato

### Studio
- **UUID Studio**
- Nome

### Prodotto da
- **EIDR** → Film
- **UUID Studio** → Studio

### Correlato a 
- **UUID Film 1** → Film (UUID Film)
- **UUID Film 2** → Film (UUID Film)

### Ruolo
- **UUID Ruolo**
- Nome

### Cast
- **UUID Cast**
- Nome

### Ha preso parte al film
- **EIDR** → Film
- **UUID Cast** → Cast
- **UUID Ruolo** → Ruolo

## Libri

### Libro
- **UUID Libro**
- Titolo originale
- Sinossi

### Editore
- **Prefisso ISBN**
- Nome

### Edizione
- **ISBN Editore** → Editore
- **ISBN Resto**
- UUID Libro → Libro
- Titolo edizione

### Correlato a 
- **UUID Libro 1** → Libro (UUID Libro)
- **UUID Libro 2** → Libro (UUID Libro)

### Autore
- **UUID Autore**
- Nome

### Scritto da
- **UUID Libro** → Libro
- **UUID Autore** → Autore

