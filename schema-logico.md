# Schema logico

## Generale

### Utente
- **Username**
- Password
- Email
- Amministratore
- Bannato

// TODO: gestire la gerarchia

### Elemento
- **UUID Elemento**
- _Username_ → Utente
- Stato
- Provenienza

### Recensione
- _**UUID Elemento**_ → Elemento
- Commento
- Valutazione
- Data

## Gioco

### Gioco
- **UUID Gioco**
- Nome
- Descrizione

### Edizione
- **UUID Edizione**
- _UUID Gioco_ → Gioco
- Titolo edizione
- Piattaforma
- Box art

### Correlato a 
- _**UUID Gioco 1**_ → Gioco (UUID Gioco)
- _**UUID Gioco 2**_ → Gioco (UUID Gioco)

### Genere
- **UUID Genere**
- Nome

### Appartiene a
- _**UUID Gioco**_ → Gioco
- _**UUID Genere**_ → Genere

### Studio 
- **UUID Studio**
- Nome

### Portato da
- _**UUID Edizione**_ → Edizione
- _**UUID Studio**_ → Studio

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
- _**EIDR**_ → Film
- _**UUID Genere**_ → Genere

### Localizzazione
- **Lingua**
- _EIDR_ → Film
- Titolo localizzato

### Studio
- **UUID Studio**
- Nome

### Prodotto da
- _**EIDR**_ → Film
- _**UUID Studio**_ → Studio

### Correlato a 
- _**UUID Film 1**_ → Film (UUID Film)
- _**UUID Film 2**_ → Film (UUID Film)

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
