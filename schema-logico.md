# Schema logico

## Generale

**Utente** (**Username**, Password, Email, Amministratore, Bannato)  
// TODO: gestire la gerarchia

**Elemento** (**UUID**, Stato, Provenienza, Username)  
FK: Username → Utente

**Recensione** (**ID recensione**, Commento, Valutazione, Data, ID Interno)  
FK: ID Interno → Elemento

## Gioco

**Gioco** (**ID gioco**, nome, descrizione)

**Edizione** (**ID Edizione**, titolo alternativo, piattaforma, box art, ID gioco)  
FK: ID gioco → Gioco

**Correlato a** (**ID gioco 1, ID gioco 2**)  
FK: ID gioco 1 → Gioco  
FK: ID gioco 2 → Gioco

**Genere** (**ID/Nome**)

**Appartiene a** (**ID Gioco**, **ID/Nome**)  
FK: ID Gioco → Gioco  
FK: Id/Nome → Genere

**Studio** (**ID studio**, Nome)

**Portato da** (**ID edizione**, **ID studio**)  
FK: ID edizione → Edizione  
FK: ID studio → Studio

**Sviluppato da** (**ID gioco**, **ID studio**)  
FK: ID gioco → Gioco  
FK: ID studio → Studio

**Pubblicato da** (**ID gioco**, **ID studio**)  
FK: ID gioco → Gioco  
FK: ID studio → Studio
