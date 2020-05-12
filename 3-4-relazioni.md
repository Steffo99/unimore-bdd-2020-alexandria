# Relazioni e attributi

## Legenda

![](img/3-4-relazioni/legenda.png)

## Utenti

> Chiunque può registrarsi al sito web scegliendo un username univoco e inserendo una password segreta (sarà [hashata](https://it.wikipedia.org/wiki/Funzione_di_hash) con l'algoritmo [bcrypt](https://it.wikipedia.org/wiki/Bcrypt) prima che venga inserita nel database), creando così un utente.
>
> Esisterà una tipologia particolare di utente: l'utente **amministratore**.
> 
> Inoltre, potranno decidere di __bannare__ utenti dal sito, impedendo loro di effettuare l'accesso e di conseguenza di interagire con la loro raccolta.

![](img/3-4-relazioni/utente.png)

Per gli Utenti, si sono aggiunti gli attributi all'entità seguendo strettamente le specifiche, e aggiungendo un attributo opzionale "email" per funzioni di recupero dell'account.

## Elementi

> Gli utenti potranno aggiungere _elementi_ alla loro raccolta multimediale.
>
> Un elemento rappresenta una copia di un libro, di un film o di un videogioco posseduta da un utente.
>
> Ogni elemento avrà associato uno **stato** da una lista di opzioni diversa per ogni tipologia: [...]
>
> Inoltre, ogni elemento avrà associata una **provenienza** da un'altra lista: [...]

> Un utente potrà lasciare una recensione ad ogni elemento presente nella sua raccolta.
>
> La recensione sarà composta da una valutazione (tra 0 e 100, dove 100 è la valutazione migliore), un commento e la data di pubblicazione.

![](img/3-4-relazioni/elemento.png)

### Sottoentità

![](img/3-2-gerarchie/gerarchia-1.png)

Gli Elementi sono stati suddivisi in tre sottoentità _Elemento (Libro)_, _Elemento (film)_ ed _Elemento (gioco)_ per permettere loro di possedere attributi e relazioni di tipo diverso gli uni dagli altri; infatti, ognuna delle tre sottoentità è dotata di una associazione "istanza di" che le collega rispettivamente alle entità "Edizione (di un libro)", "Film" e "Edizione (di un gioco)".

Attributi e relazioni di queste sottoentità saranno descritte in seguito nel paragrafo dedicato.

### Recensioni

![](img/3-4-relazioni/recensioni.png)

Le Recensioni sono collegate agli Elementi attraverso la relazione "riguardante".

Sono un caso di **chiave primaria esterna**: le Recensioni infatti usano come chiave primaria l'*_id_ dell'Elemento a cui si riferiscono. 

Si può inoltre dire che le Recensioni siano una **entità debole** rispetto agli Elementi, in quanto senza il suo relativo Elemento, una Recensione non sarebbe più dotata di chiave (e non avrebbe più senso di esistere in quanto si riferirebbe a qualcosa di inesistente).

## Libri

> Ogni libro avrà una sua pagina in cui sarà presente il titolo originale, gli autori, i generi, un breve riassunto della trama, l'elenco di tutte le sue edizioni (sia in formato libro sia in formato audiolibro) e [...].
> 
> Ciascuna edizione del libro avrà una seconda pagina con ulteriori informazioni, quali il suo titolo, la copertina, la casa editrice e il numero di pagine; ciascuna edizione sarà identificata da il relativo [codice ISBN](https://it.wikipedia.org/wiki/ISBN).
> 
> Le edizioni in formato audiolibro avranno attributi diversi: invece che avere il numero di pagine e la copertina, essi avranno la durata in minuti e secondi della registrazione e opzionalmente un'immagine che rappresenti l'audiolibro.

![](img/3-4-relazioni/libri.png)

Lo schema dei Libri è stato realizzato seguendo in buona parte le specifiche; si sono però realizzate alcune aggiunte:
- Le Edizioni di un libro sono dotate anch'esse di un titolo, che rappresenta il titolo dell'Edizione specifica (titolo tradotto, edizione speciale...);
- [Come menzionato in precedenza](3-2-gerarchie.md), è stata istituita una **gerarchia IsA** con le Edizioni di Libri e Audiolibri;
- Le Edizioni di un Audiolibro possono avere associato uno o più Narratori.

### Una ricorrenza nelle relazioni: il pattern "1NN0"

![](img/3-4-relazioni/inno-1.png)
![](img/3-4-relazioni/inno-2.png)

Osservando lo schema, si nota che le relazioni "narrata da" e "scritto da" sono molto simili tra loro: tutte e due sono **0 a N** nel lato che si collega al Libro (o a una sua Edizione), sono **1 a N** dall'altro lato e si ricollegano a una entità con due soli attributi, _Nome_ e _ID_.

Definiamo questa struttura _1NN0_, in quanto essa ricorrerà frequentemente in tutto lo schema.

<!--Il nome gliel'ho dato io, dici che può andare bene?-->

Si è deciso di usare l'associazione **0 a N** nel lato del Libro perchè gli utenti possano non compilare tutti i dettagli di un libro nel momento in cui lo aggiungono ma anche perchè possano compilare accuratamente tutti i campi, ad esempio permettendo l'inserimento di un testo in più generi.

Dato che si è voluto rendere possibili query come "quali libri ha scritto questo autore" o "quali libri ha narrato questo narratore" e che inserire nel database autori o narratori a cui non appartiene nessun libro non avrebbe alcun senso, si è scelto di usare una relazione **1 a N** nell'altro lato della relazione.

Infine, per l'entità connessa al lato _1 a N_ della relazione, si è deciso di usare un **ID interno** come chiave dell'entità, in modo da permettere la modifica del _Nome_ associato senza dover andare a modificare tutti i Libri (o Edizioni).

### I generi

![](img/3-4-relazioni/generi-libri.png)

Notiamo che la relazione che associa un libro a un genere è molto simile alla struttura _1NN0_, ma con una associazione **0 a N** anche dal lato dell'entità Genere.

Questo perchè si intende aggiungere alcuni generi predefiniti al database (come Fantasy, Giallo o Western) tra cui gli utenti possano scegliere prima ancora che esistano dei libri.

### Editori e ISBN

![](img/3-4-relazioni/editore.png)

Tutti i codici ISBN contengono al loro interno [un codice univoco che identifica l'editore](https://it.wikipedia.org/wiki/ISBN#Editore) di un libro; si è quindi deciso di usare questo codice per identificare l'entità Editore, in quanto esso soddisfa tutti i requisiti per essere una chiave.

### Libri correlati 

> [...] e opzionalmente una lista di opere correlate (sequel, prequel, libri ambientati nello stesso universo, etc)

![](img/3-4-relazioni/autoassoc-libri.png)

Come menzionato [in precedenza](3-3-autoassociazioni.md), l'entità Libro è dotata di una autoassociazione che permette di identificare gli elementi correlati ad essa.

## Film

> Ogni film avrà una sua pagina in cui sarà presente il titolo originale, i titoli nelle varie lingue (identificati dal [codice ISO 639 della lingua](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)), una sinossi della trama, la durata, la casa produttrice, il cast, e, come per i libri, una lista opzionale di pellicole correlate.
> 
> I film saranno identificati dal loro [codice EIDR](https://ui.eidr.org/search), e per ciascuno di essi verrà calcolata la valutazione media dalle recensioni, che sarà visualizzata sulla pagina assieme a un campione di recensioni.

![](img/3-4-relazioni/film.png)

### Il pattern _1NN0_ nei film

![](img/3-4-relazioni/inno-3.png)

Nello schema dei film, si può notare un'altra applicazione del pattern _1NN0_ menzionato in precedenza: "prodotto da".

### Vi ha preso parte: una relazione 1NN0 ternaria

![](img/3-4-relazioni/ternaria.png)

Nello schema dei film è presente la relazione ternaria "vi ha preso parte".  
Essa associa una persona a un film, specificando il ruolo ("attore", "regista", "sceneggiatore"...) per cui ella vi ha preso parte. 

È stata modellata così in modo da permettere query avanzate sul cast di un film: ad esempio, "in quali film Quentin Tarantino ha avuto il ruolo di regista", oppure "che ruoli ha ricoperto Johnny Depp".

### Generi

![](img/3-4-relazioni/generi-film.png) 

Come per i libri, la relazione "appartiene a" è un _1NN0_ con una associazione **0 a N** dal lato del Genere.

### Film correlati 

![](img/3-4-relazioni/autoassoc-film.png)

Come i Libri, anche i Film hanno un'autoassociazione per determinare i film correlati.

### Localizzazione: una entità debole

![](img/3-4-relazioni/entita-debole.png)

Simile al pattern _1NN0_, ma fondamentalmente diversa è la relazione "in altre lingue": essa infatti ha un'associazione _0 a N_ dal lato Film, ma una _1 a 1_ dal lato Localizzazione, e in più, l'associazione è parte della chiave primaria di Localizzazione.

L'entità Localizzazione rappresenta il titolo di un film tradotto in una lingua diversa dall'originale: ad esempio, _Il Padrino_ potrebbe essere una localizzazione in `it` (italiano) di _The Godfather_.  
La sua chiave è composta dal codice della lingua e dall'identificatore del film a cui essa si riferisce: è dunque una **entità debole**.

## Giochi

> Ogni videogioco avrà una sua pagina in cui sarà presente il titolo, lo sviluppatore, il publisher, una breve descrizione del gioco, l'elenco di tutte le piattaforme in cui esso è disponibile e, come per libri e film, un elenco di altri giochi correlati.
> 
> Per ogni piattaforma sarà disponibile una sottopagina, che conterrà la [box art](https://vgboxart.com/) di quella versione, il nome dello studio che ha effettuato il [porting](https://en.wikipedia.org/wiki/Porting#Porting_of_video_games) ed eventualmente il titolo [se diverso da quello principale](https://it.wikipedia.org/wiki/Payday_2#Crimewave_Edition). 

![](img/3-4-relazioni/giochi.png)

### Giochi e Edizioni

![](img/3-4-relazioni/giochi-e-edizioni.png)

Quelle che [nella descrizione](/1-descrizione.md) vengono chiamate _sottopagine_ sono state realizzate nello schema attraverso l'entità Edizione: una Edizione rappresenta una versione di un gioco pubblicata su una piattaforma specifica.

Come per i libri, gli Elementi riferiti a un gioco verranno istanziati relativamente a una specifica Edizione di un gioco.

### Il pattern 1NN0 nei Giochi

![](img/3-4-relazioni/inno-4.png)

Il pattern _1NN0_ ricorre anche all'interno dello schema dei Giochi: si possono notare infatti le relazioni "sviluppato da", "pubblicato da" e "portato da", che collegano uno o più Studios a uno o più Giochi (o loro Edizioni).

### Generi

![](img/3-4-relazioni/generi-giochi.png)

Come per Libri e Film, anche i Giochi hanno una relazione "appartiene a" che li collega a uno o più Generi.

### Giochi correlati 

![](img/3-4-relazioni/autoassoc-giochi.png)

Come Libri e Film, anche i Giochi hanno un'autoassociazione per determinare i giochi correlati.
