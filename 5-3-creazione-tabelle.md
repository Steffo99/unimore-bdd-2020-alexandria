# Creazione tabelle

Dopo aver creato il database, il secondo passo della progettazione fisica è stato quello di convertire lo schema logico in un database Postgres.

In generale:

- Le **entità** sono diventate _TABLES_;
- Gli **attributi** sono diventati _COLUMNS_;
- Le **chiavi primarie** sono state implementate come _PRIMARY KEYS_;
- Le **chiavi esterne** sono state implementate come _FOREIGN KEYS_;
- Le **chiavi surrogate** sono state implementate come _PRIMARY KEYS_ autoincrementate tramite _SEQUENCES_;
- I **dati derivati** sono stati implementati come _COLUMNS_ aventi dei _TRIGGER_ che le aggiornassero;
