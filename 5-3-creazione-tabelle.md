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
    isbn character(13) NOT NULL,
    titolo character varying NOT NULL,
    durata interval,
    immagine bytea,
    relativa_a integer NOT NULL,
    CONSTRAINT durata_check CHECK ((date_part('epoch'::text, durata) >= (0)::double precision))
);

ALTER TABLE ONLY public.audiolibro_edizione
    ADD CONSTRAINT audiolibro_edizione_pkey PRIMARY KEY (isbn);
```

La durata delle edizioni degli audiolibri è di tipo _interval_, che rappresenta un intervallo di tempo con la precisione di centesimi di secondo; l'immagine dell'audiolibro ha invece tipo _bytea_, e sarà salvata nel database come un blob binario di dati.

Inoltre, la durata è dotata di un _CHECK_ che impedisce che essa sia minore di 0, convertendo l'_interval_ in secondi e controllando che essi siano maggiori di 0.

### `audiolibro_recensione`

```sql
CREATE TABLE public.audiolibro_recensione (
    id bigint NOT NULL,
    commento text NOT NULL,
    valutazione smallint NOT NULL,
    data timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT audiolibro_recensione_valutazione_check CHECK (((valutazione >= 0) AND (valutazione <= 100)))
);

ALTER TABLE ONLY public.audiolibro_recensione
    ADD CONSTRAINT audiolibro_recensione_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.audiolibro_recensione
    ADD CONSTRAINT id FOREIGN KEY (id) REFERENCES public.audiolibro_elemento(id);
```

Per minimizzare valori nulli, si è tradotta l'associazione binaria 1 a 1 `relativa a` in due tabelle separate, usando in una delle due una chiave esterna come chiave primaria.  
Si notino dunque i due _CONSTRAINT_ `audiolibro_recensione_pkey` e `id`.

La valutazione delle recensioni deve essere obbligatoriamente tra 0 e 100: a tale scopo, è stato introdotto un _CHECK_ sulla tabella che verifichi questa condizione.

La data di pubblicazione è rappresentata da un _timestamp_, tipo che rappresenta un istante specifico di tempo con precisione fino ai microsecondi.

### `film`

```sql
CREATE TABLE public.film (
    eidr character(34) NOT NULL,
    titolo character varying NOT NULL,
    sinossi text,
    locandina bytea,
    durata interval,
    CONSTRAINT durata_check CHECK ((date_part('epoch'::text, durata) > (0)::double precision))
);

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_pkey PRIMARY KEY (eidr);
```

Nella tabella `film` compare nuovamente il _CHECK_ utilizzato nelle `audiolibro_edizioni` per la durata, e lo stesso tipo _bytea_ per la locandina.

Si può notare nella tabella compare il tipo _char(34)_: essendo gli EIDR sempre lunghi 34 caratteri, si è scelto si minimizzare lo spazio di archiviazione utilizzato rendendo il campo a lunghezza non variabile.

### `film_correlazioni`

```sql
CREATE TABLE public.film_correlazioni (
    eidr_1 character(34) NOT NULL,
    eidr_2 character(34) NOT NULL
);

ALTER TABLE ONLY public.film_correlazioni
    ADD CONSTRAINT film_correlazioni_pkey PRIMARY KEY (eidr_1, eidr_2);

ALTER TABLE ONLY public.film_correlazioni
    ADD CONSTRAINT eidr_1 FOREIGN KEY (eidr_1) REFERENCES public.film(eidr);

ALTER TABLE ONLY public.film_correlazioni
    ADD CONSTRAINT eidr_2 FOREIGN KEY (eidr_2) REFERENCES public.film(eidr);
```

L'autoassociazione delle correlazioni è stata implementata attraverso una **tabella ponte** che collega due film attraverso i loro `eidr`.

`eidr_1` ed `eidr_2` sono due chiavi esterne separate, e insieme formano la **chiave primaria composta** della tabella.

### `film_vi_ha_preso_parte`

```sql
CREATE TABLE public.film_vi_ha_preso_parte (
    eidr character(34) NOT NULL,
    id_cast integer NOT NULL,
    id_ruolo integer NOT NULL
);

ALTER TABLE ONLY public.film_vi_ha_preso_parte
    ADD CONSTRAINT film_vi_ha_preso_parte_pkey PRIMARY KEY (eidr, id_cast, id_ruolo);

ALTER TABLE ONLY public.film_vi_ha_preso_parte
    ADD CONSTRAINT eidr FOREIGN KEY (eidr) REFERENCES public.film(eidr);

ALTER TABLE ONLY public.film_vi_ha_preso_parte
    ADD CONSTRAINT id_cast FOREIGN KEY (id_cast) REFERENCES public.film_cast(id);

ALTER TABLE ONLY public.film_vi_ha_preso_parte
    ADD CONSTRAINT id_ruolo FOREIGN KEY (id_ruolo) REFERENCES public.film_ruolo(id);
```

L'associazione ternaria è stata realizzata con un'altra **tabella ponte**, avente una **chiave primaria composta** e tre chiavi esterne separate.

### `elemento_id_seq`

```sql
CREATE SEQUENCE public.elemento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
```

Si è deciso di rendere **univoci** gli `id` di **tutti gli elementi**, qualsiasi fosse il loro tipo.

Per realizzare ciò si è creata una _SEQUENCE_ unica che viene poi usata da tutte le tabelle `*_elemento` per generare i nuovi id.

### Stato e provenienza

```sql
CREATE TYPE public.gioco_provenienza AS ENUM (
    'GRATUITO',
    'ACQUISTATO',
    'IN_ABBONAMENTO',
    'PRESO_IN_PRESTITO',
    'NON_PIU_POSSEDUTO',
    'ALTRO'
);

CREATE TYPE public.gioco_stato AS ENUM (
    'DA_INIZIARE',
    'INIZIATO',
    'FINITO',
    'COMPLETATO',
    'NON_APPLICABILE'
);
```

Gli stati e le provenienze dei vari elementi sono state realizzate creando _ENUM_ contenenti tutte le possibili opzioni selezionabili dall'utente, e utilizzandoli come tipo delle relative colonne; in questo modo, si impedisce l'immissione di valori non validi nelle colonne.

### `gioco_elemento`

```sql
CREATE TABLE public.gioco_elemento (
    id bigint DEFAULT nextval('public.elemento_id_seq'::regclass) NOT NULL,
    stato public.gioco_stato,
    provenienza public.gioco_provenienza,
    istanza_di integer NOT NULL,
    appartiene_a character varying NOT NULL
);

ALTER TABLE ONLY public.gioco_elemento
    ADD CONSTRAINT gioco_elemento_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.gioco_elemento
    ADD CONSTRAINT appartiene_a FOREIGN KEY (appartiene_a) REFERENCES public.utente(username);

ALTER TABLE ONLY public.gioco_elemento
    ADD CONSTRAINT istanza_di FOREIGN KEY (istanza_di) REFERENCES public.gioco_edizione(id);

CREATE FUNCTION public.update_n_giochi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
        IF (TG_OP = 'DELETE') THEN
            UPDATE utente
                SET gioco_elementi_posseduti = gioco_elementi_posseduti - 1
                WHERE utente.username = old.appartiene_a;
            RETURN old;
        ELSIF (TG_OP = 'INSERT') THEN
            UPDATE utente
                SET gioco_elementi_posseduti = gioco_elementi_posseduti + 1
                WHERE utente.username = new.appartiene_a;
            RETURN new;
        END IF;
    END;
    $$;


CREATE TRIGGER numero_giochi_trigger BEFORE INSERT OR DELETE 
    ON public.gioco_elemento 
    FOR EACH ROW EXECUTE PROCEDURE public.update_n_giochi();
```

Le colonne `stato` e `provenienza` utilizzano il relativo _ENUM_ creato in precedenza.

La colonna `id` ha un valore di _DEFAULT_ particolare: `nextval('public.elemento_id_seq'::regclass)`.  
Ciò significa che, se non viene specificato un `id` durante un inserimento, alla riga verrà assegnato automaticamente il valore corrente della _SEQUENCE_ `public.elemento_id_seq` descritta in precedenza, aumentandone inoltre il valore di 1.

Nella tabella è presente anche un _TRIGGER_, che incrementa o decrementa il conteggio degli elementi dell'utente a cui essi appartengono quando uno o più elementi vengono inseriti o rimossi.

### `libro_edizione`

```sql
CREATE FUNCTION public.is_numeric(text character varying) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$DECLARE x NUMERIC;
    BEGIN
        x = $1::NUMERIC;
        RETURN TRUE;
    EXCEPTION WHEN others THEN
        RETURN FALSE;
    END;$_$;

CREATE TABLE public.libro_edizione (
    isbn character(13) NOT NULL,
    titolo_edizione character varying NOT NULL,
    pagine integer,
    copertina bytea,
    relativa_a integer NOT NULL,
    CONSTRAINT libro_edizione_isbn_check CHECK ((public.is_numeric(("substring"((isbn)::text, 1, 12))::character varying) AND (public.is_numeric(("right"((isbn)::text, 1))::character varying) OR ("right"((isbn)::text, 1) ~~ '%X'::text)))),
    CONSTRAINT libro_edizione_pagine_check CHECK ((pagine >= 0))
);

ALTER TABLE ONLY public.libro_edizione
    ADD CONSTRAINT libro_edizione_pkey PRIMARY KEY (isbn);

ALTER TABLE ONLY public.libro_edizione
    ADD CONSTRAINT relativa_a FOREIGN KEY (relativa_a) REFERENCES public.libro(id);
```

La tabella delle edizioni di un libro include due _CHECK_: uno che controlla che le pagine, se specificate, siano un numero positivo, e un'altro che controlla che gli ISBN siano in un formato valido.

In particolare, per quest'ultimo, è stata creata una funzione di utilità `is_numeric`, che verifica che tutti i caratteri di una stringa siano numerici: questa funzione viene poi usata per controllare che tutti i caratteri dell'ISBN siano numeri, permettendo però anche una `X` in ultima posizione (l'ultima cifra degli ISBN più vecchi era in base-11 e utilizzava la lettera X come 10). 

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

ALTER TABLE ONLY public.utente
    ADD CONSTRAINT username PRIMARY KEY (username);
```

La password, essendo un [hash](https://it.wikipedia.org/wiki/Funzione_di_hash), è rappresentata come un dato binario (_bytea_).

Le colonne `is_admin` e `is_banned` hanno un valore di default di _false_, in quanto alla creazione gli utenti non saranno amministratori o bannati.

Le colonne `*_elementi_posseduti` sono i dati derivati che rappresentano quanti elementi di ogni tipo possiede un dato utente: per i nuovi utenti, questo valore sarà 0.  
Queste colonne saranno poi incrementate dai trigger presenti nelle quattro tabelle `*_elemento`.
