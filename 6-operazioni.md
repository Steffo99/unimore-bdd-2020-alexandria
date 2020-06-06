# Query preprogrammate per l'utilizzo del database

Si sono inserite in questo capitolo della relazione alcuni esempi di query che permetteranno al sito web di interagire con la base di dati.

Come nel caso della [creazione tabelle](5-3-creazione-tabelle.md), si elencano solo le query più significative.

## Creazione di un nuovo utente

```sql
INSERT INTO utente (username, password, email) VALUES ($username, $hashed_password, $email);
```

## Promozione di un utente ad amministratore

```sql
UPDATE utente SET is_admin = true WHERE username = $username;
```

## Creazione di un elemento relativo a un libro non esistente nel database

```sql
INSERT INTO libro (titolo_primario) VALUES ($titolo);

INSERT INTO libro_edizione (isbn, titolo_edizione, relativa_a) VALUES ($isbn, $titolo, currval('libro_id_seq'));

INSERT INTO libro_elemento (istanza_di, appartiene_a) VALUES ($isbn, $username);
```

## Creazione di una recensione relativa a un elemento

```sql
INSERT INTO libro_recensione (id, commento, data, valutazione) VALUES ($isbn, $commento, now(), $valutazione); 
```

## Conteggio degli elementi posseduti da un utente

```sql
SELECT 
    libro_elementi_posseduti libri,
    audiolibro_elementi_posseduti audiolibri,
    film_elementi_posseduti film, 
    gioco_elementi_posseduti giochi,
    (libro_elementi_posseduti + audiolibro_elementi_posseduti + film_elementi_posseduti + gioco_elementi_posseduti) totale
FROM utente
WHERE username = $username;
```

## Conteggio del numero totale di edizioni di libri presenti nel database

```sql
SELECT COUNT(*) FROM libro_edizione;
```

## Conteggio del numero totale di edizioni di libri di ogni autore

```sql
SELECT COUNT(*)
FROM libro_edizione
WHERE relativa_a IN (
    SELECT l.id 
    FROM libro l
    JOIN libro_scritto_da lsd on l.id = lsd.id_libro
    JOIN libro_autore la on lsd.id_autore = la.id
    WHERE la.id = $id_autore
);
```

## Visualizzazione della valutazione media di un gioco

```sql
SELECT AVG(gr.valutazione)
FROM gioco_recensione gr
JOIN gioco_elemento gel on gr.id = gel.id
JOIN gioco_edizione ge on gel.istanza_di = ge.id
JOIN gioco g on ge.relativa_a = g.id
WHERE g.id = $id_gioco;
```

## Visualizzazione di tutte le edizioni di un dato editore

```sql
SELECT * 
    FROM libro_editore ld 
    JOIN libro_edizione lz 
        ON ld.parte_isbn = substr(lz.isbn, 6, length(ld.parte_isbn))
    WHERE ld.nome = $nome_editore;
```
