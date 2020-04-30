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
- _**ID Edizione**_ → Edizione
- _**ID Studio**_ → Studio

### Sviluppato da 
- **ID Gioco** → Gioco
- **ID Studio** → Studio

### Pubblicato da 
- **ID Gioco** → Gioco
- **ID Studio** → Studio
