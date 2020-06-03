# Creazione tabelle

Dopo aver creato il database, il secondo passo della progettazione fisica è stato quello di convertire lo schema logico in un database Postgres.

In generale:

- Le **entità** sono diventate _TABLES_ (tabelle);
- Gli **attributi opzionali** sono diventati _COLUMNS_ (colonne);
- Gli **attributi obbligatori** sono diventati _COLUMNS_ con il vincolo _NOT NULL_;
- Le **chiavi primarie** sono state implementate come _PRIMARY KEYS_ (chiavi primarie);
- Le **chiavi esterne** sono state implementate come _FOREIGN KEYS_ (chiavi esterne);
- Le **chiavi surrogate** sono state implementate come _PRIMARY KEYS_ autoincrementate tramite _SEQUENCES_ (sequenze);
- I **dati derivati** sono stati implementati come _COLUMNS_ aventi dei _TRIGGER_ che le aggiornino.

## Schema dei nomi delle tabelle

Tutte le tabelle sono state istanziate con il nome che le corrispondenti entità avevano nello schema logico, sostituendo tutte le lettere maiuscole con **lettere minuscole** `a-z`, spazi con **underscore** `_` e rimuovendo le parentesi con il loro contenuto.

Inoltre, a tutte le tabelle tranne `utente` è stato dato un nome prefissato da `libro_`, `audiolibro_`, `film_` e `gioco_` per indicare la categoria a cui le entità appartenevano nello schema logico.

### Esempi

| Entità | Tabella |
|--------|---------|
| [`Utente`](4-5-schema-logico.md#utente) | `utente` |
| [`Libro`](4-5-schema-logico.md#libro) | `libro` |
| [`Edizione (libro)`](4-5-schema-logico.md#edizione-libro) | `libro_edizione` |
| [`Cast`](4-5-schema-logico.md#cast) | `film_cast` |

## Creazione tabelle

Si riportano solo le tabelle con qualche particolarità; le tabelle per la quale la conversione è banale sono omesse da questo file (ma non dal file [`5-database.sql`](5-database.sql)).

### `audiolibro_edizione`

```sql
CREATE TABLE public.audiolibro_edizione (
    isbn integer NOT NULL,
    titolo character varying NOT NULL,
    durata interval,
    immagine bytea,
    relativa_a integer NOT NULL
);
```

L'immagine relativa all'audiolibro è archiviata nella base di dati come un blob binario di dati.

### `utente`

```sql
CREATE TABLE public.utente (
    username character varying NOT NULL,
    password bytea NOT NULL,
    email character varying,
    is_admin boolean DEFAULT false NOT NULL,
    is_banned boolean DEFAULT false NOT NULL,
    libro_elementi_posseduti integer DEFAULT 0 NOT NULL,
    audiolibro_elementi_posseduti integer DEFAULT 0 NOT NULL,
    film_elementi_posseduti integer DEFAULT 0 NOT NULL,
    gioco_elementi_posseduti integer DEFAULT 0 NOT NULL
);
```

La password, essendo un [hash](https://it.wikipedia.org/wiki/Funzione_di_hash), è rappresentata come un dato binario (_bytea_).

Le colonne `is_admin` e `is_banned` hanno un valore di default di _false_, in quanto alla creazione gli utenti non saranno amministratori o bannati.

Le colonne `*_elementi_posseduti` sono i dati derivati che rappresentano quanti elementi di ogni tipo possiede un dato utente: per i nuovi utenti, questo valore sarà 0.
