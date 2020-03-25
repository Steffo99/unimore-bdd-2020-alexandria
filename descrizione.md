<!--Da quanto ho capito qui dobbiamo scrivere tutto all'impersonale...-->

# Descrizione

Si vuole realizzare una base di dati a supporto di un sito web che permetta la creazione, gestione e condivisione della propria raccolta multimediale, come è possibile fare su altri siti web, quali [aNobii](https://www.anobii.com/), [MyAnimeList](https://myanimelist.net/) e [The Backloggery](https://backloggery.com/).

Il sito sarà suddiviso in sezioni, ciascuna riguardante un [media](https://it.wikipedia.org/wiki/Mezzo_di_comunicazione_di_massa) diverso:

- [Libri](https://it.wikipedia.org/wiki/Libro) e [audiolibri](https://it.wikipedia.org/wiki/Audiolibro)
- [Film](https://it.wikipedia.org/wiki/Film)
- [Videogiochi](https://it.wikipedia.org/wiki/Videogioco)
- [Serie televisive](https://it.wikipedia.org/wiki/Fiction_televisiva#Serie_televisiva)

## Utenti

Chiunque può registrarsi al sito web scegliendo un username univoco e inserendo una password segreta (sarà [hashata](https://it.wikipedia.org/wiki/Funzione_di_hash) con l'algoritmo [bcrypt](https://it.wikipedia.org/wiki/Bcrypt) prima che venga inserita nel database), creando così un utente.

Ogni utente avrà una sua raccolta multimediale, in cui potrà aggiungere, modificare e rimuovere elementi.

### Amministratori

Esisterà una tipologia particolare di utente: l'utente **amministratore**.

Gli amministratori potranno modificare le raccolte multimediali di tutti gli utenti, in aggiunta alla propria.

<!--Ho tolto i moderatori per semplificare.-->

Inoltre, potranno decidere di __bannare__ <!--Bandire?--> utenti dal sito, impedendo loro di effettuare l'accesso e di conseguenza di interagire con la loro raccolta.

## Elementi

Gli utenti potranno aggiungere _elementi_ alla loro raccolta multimediale.

Un elemento rappresenta una copia di un libro, di un film, di una stagione di una serie TV o di un videogioco posseduta da un utente.

Ogni elemento avrà associato uno **stato** da una lista di opzioni diversa per ogni tipologia:

- Libro
    - Da iniziare
    - Iniziato
    - Finito
    - Abbandonato
- Film
    - Da vedere
    - Visto
- Serie TV
    - Da iniziare
    - Iniziata
    - Finita
    - Abbandonata
- Videogioco
    - Da iniziare
    - Iniziato
    - Finito
    - Completato al 100%

Inoltre, ogni elemento avrà associata una **provenienza** da un'altra lista:

- Libro
    - Acquistato (su supporto fisico)
    - Acquistato (su supporto digitale)
    - Preso in prestito (da restituire)
    - Perso / Venduto / Restituito / Non più posseduto
    - Altro 1 <!--Piratato, ma non si può dire apertamente-->
    - Altro 2
    - Altro 3
- Film
    - Acquistato (su supporto fisico)
    - Visto al cinema
    - Visto in televisione
    - Visto su un servizio di streaming
    - Preso in prestito (da restituire) <!--C'è ancora qualcuno che prende film in prestito?-->
    - Perso / Venduto / Restituito / Non più posseduto
    - Altro 1 <!--Piratato, ma non si può dire apertamente-->
    - Altro 2
    - Altro 3
- Serie TV
    - Acquistata (su supporto fisico)
    - Vista in televisione
    - Vista su un servizio di streaming
    - Presa in prestito (da restituire)
    - Persa / Venduta / Non più posseduto
    - Altro 1 <!--Piratato, ma non si può dire apertamente-->
    - Altro 2
    - Altro 3
- Videogioco 
    - Gratuito
    - Acquistato
    - Giocato in abbonamento
    - Preso in prestito (da restituire)
    - Perso / Venduto / Restituito / Non più posseduto
    - Altro 1 <!--Piratato, ma non si può dire apertamente-->
    - Altro 2
    - Altro 3

## Recensioni

Un utente potrà lasciare una recensione ad ogni elemento presente nella sua raccolta.

La recensione sarà composta da una valutazione (tra 0 e 100, dove 100 è la valutazione migliore) e un commento.

La media delle valutazioni delle recensioni relativa a un dato libro / film / serie TV / videogioco sarà poi visualizzata nella relativa pagina, assieme ad alcune recensioni selezionate casualmente.

<!--Permettere alle recensioni di essere eliminate potrebbe portare a corruzione, meglio permettere solo di marcarle come nascoste, come fa Steam...-->

Gli utenti potranno decidere in qualsiasi momento di eliminare una loro recensione.

Gli amministratori **non potranno eliminare recensioni**, ma potranno marcarle come _nascoste_ nel caso le considerino inappropriate o non inerenti.

Le recensioni nascoste potranno apparire nel sito, ma avranno un aspetto diverso e il commento all'interno non sarà visibile a meno che l'utente non clicchi un tasto.

## Libri ed edizioni

Ogni libro avrà una sua pagina in cui sarà presente il titolo originale, l'autore,i generi, un breve riassunto della trama, l'elenco di tutte le sue edizioni, sia in formato libro sia in formato audiolibro.

Ciascuna edizione del libro avrà una seconda pagina con ulteriori informazioni, quali il suo titolo, la copertina, la casa editrice e il numero di pagine; ciascuna edizione sarà identificata da il relativo [codice ISBN](https://it.wikipedia.org/wiki/ISBN).

Le edizioni in formato audiolibro avranno attributi diversi: invece che avere il numero di pagine e la copertina, essi avranno la durata in minuti e secondi della registrazione e opzionalmente un'immagine che rappresenti l'audiolibro.

Recensioni e valutazione media saranno calcolate sia per libro, sia per edizione.

## Film

<!--https://it.wikipedia.org/wiki/Template:Film-->

Ogni film avrà una sua pagina in cui sarà presente il titolo originale, i titoli nelle varie lingue (identificati dal [codice ISO 639 della lingua](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)), una sinossi della trama, la casa produttrice e l'elenco delle persone che compaiono nei crediti del film, assieme al loro ruolo.

I film saranno identificati dal loro [codice EIDR](https://ui.eidr.org/search), e per ciascuno di essi verrà calcolata dalle recensioni la valutazione media, che sarà visualizzata sulla pagina assieme a un campione di recensioni.

## Videogiochi

<!--https://it.wikipedia.org/wiki/Template:Videogioco-->

Ogni videogioco avrà una sua pagina in cui sarà presente il titolo, lo sviluppatore, il publisher, una breve descrizione del gioco e l'elenco di tutte le piattaforme in cui è disponibile.

Per ogni piattaforma sarà disponibile una sottopagina, che conterrà la [box art](https://vgboxart.com/) di quella versione, il nome dello studio che ha effettuato il [porting](https://en.wikipedia.org/wiki/Porting#Porting_of_video_games) ed eventualmente il titolo [se diverso da quello principale](https://it.wikipedia.org/wiki/Payday_2#Crimewave_Edition). 

Recensioni e valutazione media saranno disponibili sia per ogni singola piattaforma, sia per il gioco nel suo complesso.

## Serie televisive

<!--https://it.wikipedia.org/wiki/Template:FictionTV-->

Ogni serie TV avrà una sua pagina in cui sarà presente il suo titolo, un'immagine che la rappresenti, una breve descrizione, l'elenco delle stagioni della serie e opzionalmente un elenco di serie TV correlate.

Ogni stagione di una serie TV avrà un'altra pagina con titolo, immagine e descrizione della stagione, e un elenco di 