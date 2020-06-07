============================================
Alexandria
============================================

Un database per un ipotetico sito web di gestione libreria multimediale

Realizzato in collaborazione tra Stefano Pigozzi e Chiara Calzolari per l'esame di Basi di Dati dell'Unimore.

--------------------------------------------
Specifiche
--------------------------------------------

Le specifiche di questo progetto sono disponibili nel file spec.pdf.

--------------------------------------------
Capitoli della relazione
--------------------------------------------

1. Descrizione
2. Glossario
3. Progettazione concettuale
    i. Schema scheletro iniziale
    ii. Classificazione delle gerarchie
    iii. Identificazione delle autoassociazioni
    iv. Schema scheletro finale
4. Progettazione logica
    i. Eliminazione delle gerarchie
    ii. Eliminazione delle chiavi esterne
    iii. Trasformazione degli attributi composti
    iv. Dati derivati
    v. Schema logico
    vi. Verifica di normalizzazione
5. Schema del database
    i. Tecnologia database
    ii. Creazione database
    iii. Creazione tabelle
6. Query preprogrammate per l'utilizzo del database

--------------------------------------------
Formati alternativi
--------------------------------------------

La relazione è disponibile anche in [formato `.odt`](relazione.odt) e in [formato `.pdf`](relazione.pdf).

--------------------------------------------
Riproduzione del database
--------------------------------------------

Su una macchina con PostgreSQL 10.12 o superiore installato, eseguire in un terminale / prompt il seguente comando:

pg_restore --dbname="alexandria" --schema="public" --file="5-database.sql"

La procedura per creare una copia del database è descritta in dettaglio nel file 5-1-tecnologia-database.md.
