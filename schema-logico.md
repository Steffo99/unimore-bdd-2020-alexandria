## Schema generico

**Utente** (<ins>Username</ins>, Password, Email, è amministratore, è bannato)

// TODO: gestire la gerarchia

**Elemento** (<ins>ID interno</ins>, Stato, Provenienza, Username)

Fk: Username ref Utente 

**Recensione** (<ins>ID recensione</ins>, Commento, Valutazione, Data, ID Interno)

Fk: ID Interno ref Elemento



## Schema Gioco

**Gioco** (<ins>ID gioco</ins>, nome, descrizione)

**Edizione** (<ins>ID Edizione</ins>, titolo alternativo, piattaforma, box art, ID gioco)

Fk: ID gioco ref Gioco

**Correlato a** (<ins>ID gioco 1, ID gioco 2</ins>)

Fk: ID gioco 1 ref Gioco

Fk: ID gioco 2 ref Gioco

**Genere** (<ins>ID/Nome</ins>)

**Appartiene a** (<ins>ID Gioco, ID/Nome</ins>)

Fk: ID Gioco ref Gioco

Fk: Id/Nome ref Genere

**Studio** (<ins>ID studio,</ins> Nome)

**Portato da** (<ins>ID edizione, ID studio</ins>)

Fk: ID edizione ref Edizione

FK: ID studio ref Studio

**Sviluppato da** (<ins>ID gioco, ID studio</ins>)

Fk: ID gioco ref Gioco

FK: ID studio ref Studio

**Pubblicato da** (<ins>ID gioco, ID studio</ins>)

Fk: ID gioco ref Gioco

FK: ID studio ref Studio
