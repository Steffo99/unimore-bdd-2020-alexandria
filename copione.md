_____
*Chiara*

### Titolo

Buongiorno a tutti, noi siamo Chiara Calzolari e Stefano Pigozzi e in questo video presenteremo Alexandria, il nostro progetto per la classe di Basi di Dati.

_____
*Steffo*

### Perchè Alexandria

Perché Il progetto si chiama proprio Alexandria? Beh, il nostro progetto consiste nella base di dati di un sito web che permetta a più utenti di creare e condividere la propria libreria multimediale, come è possibile fare su altri siti web, quali aNobii,MyAnimeList e The Backloggery.

Per essere pubblicato su GitHub, un progetto ha bisogno di un nome che lo contraddistingua;
se il nome è univoco, risulterà molto più facile da trovare nelle ricerche.

Cercavamo quindi un nome chiaro e indicativo, e perciò si è pensato di dargli il nome di Alexandria, come il nome della città in cui si trovava la più grande biblioteca dell'antichità.

_____
*Chiara*
### Schema Scheletro - pagina principale

Il sito sarà suddiviso in sezioni, ciascuna riguardante un media diverso:
Libri e audiolibri, Film o Videogiochi. Anche lo schema scheletro del progetto, quindi, è diviso in sezioni secondo questo criterio.

### Schema Scheletro - generico

Questa è la prima sezione, in cui descriviamo il fatto che gli utenti potranno aggiungere _elementi_ alla loro raccolta multimediale, e recensirli.

Un elemento rappresenta una copia di un libro, di un film o di un videogioco posseduta da un utente. In questa sezione elementi differenti verranno trattati allo stesso modo, la differenziazione avrà luogo nelle altre sezioni.

### Schema Scheletro - pagina principale (mentre switchiamo verso libro)

A questo punto, l'entità Elemento si divide in tre entità figlie: Elemento(libro), Elemento(film) e Elemento(gioco).

### Schema Scheletro - libro

Questa è la sezione in cui ci occupiamo dei libri, e eventualmente degli audiolibri.

Ogni libro avrà una sua pagina in cui sarà presente il titolo originale, gli autori, i generi, un breve riassunto della trama, l'elenco di tutte le sue edizioni, e opzionalmente una lista di opere correlate, come i sequel, prequel, libri ambientati nello stesso universo, etc.

Anche le diverse edizioni di uno stesso libro avranno una loro pagina, identificata dal loro codice ISBN. In questa pagina saranno presenti ulteriori informazioni, quali il suo titolo, la copertina, la casa editrice e il numero di pagine (o la durata in minuti, se parliamo di audiolibri). Nelle edizioni audio verrà inoltre indicata la voce narrante.

### Schema Scheletro - Film

In questa sezione si gestiscono invece i film, e infatti vengono raccolte informazioni quali il titolo originale, i titoli nelle varie lingue, una sinossi della trama, la durata, la casa produttrice, il cast (con annesso il suo ruolo, come potete vedere in questa ternaria), e, come per i libri, una lista opzionale di pellicole correlate.

I film saranno identificati dal loro codice EIDR.

### Schema Scheletro - Videogiochi

Arriviamo infine all'ultima sezione, la sezione Videogiochi.

Ogni videogioco avrà una sua pagina in cui sarà presente il titolo, lo sviluppatore, il publisher, una breve descrizione del gioco, l'elenco di tutte le piattaforme in cui esso è disponibile e, come per libri e film, un elenco di altri giochi correlati.

Per ogni piattaforma sarà disponibile una sottopagina, che conterrà la box art di quella versione, il nome dello studio che ha effettuato il porting, ed eventualmente il titolo, se diverso da quello principale. 

_____
*Steffo*

### Spazio idee

Qui invece sono raccolti i nostri contributi allo spazio idee

### autoassociazioni

Cominciamo dalle autoassociazioni: le avete già viste nello schema scheletro, comunque in alexandria sono presenti tre autoassociazioni che rappresentano tutte e tre lo stesso concetto: ogni libro, film o videogioco può essere associato ad altre entità del suo stesso tipo a cui è correlato.

Inizialmente, si è considerato di aggiungere una unica autoassociazione alla entità Elemento, ma si è poi giunti alla conclusione che questo approccio sarebbe stato sbagliato: si sarebbero dovuti associare tutti i singoli Elementi creati da ciascun Utente, creando una quantità a crescita esponenziale di correlazioni!

La nostra soluzione è quindi stata quella che vedete in figura.

### chiavi primarie esterne

In Alexandria, sono stati aggiunti due identificatori esterni

### chiavi primarie esterne - recensione

In `alexandria`, ogni utente potrà pubblicare una recensione riguardante un qualsiasi elemento della sua libreria, con un testo e una valutazione da 0 a 100. Le recensioni di ogni utente saranno poi visualizzate nella pagina dell'elemento che esse riguardano.

Si è pensato sarebbe stato appropriato permettere alle recensioni di essere associate agli elementi della libreria di ogni utente. Si è quindi creata l'identificazione esterna che vedete in figura, ed è stata assegnata come chiave dell'entità `Recensione` l'ID dell'`Elemento` che riguarda.

### Chiavi primarie esterne - localizzazione

Alexandria permette di specificare i titoli in lingue straniere di libri, film e giochi. 

Mentre libri e giochi gestiscono questa funzionalità attraverso le entità Edizione, per i film che non sono dotati di questo meccanismo abbiamo dovuto prendere una strada diversa.
Abbiamo quindi creato un'entità Localizzazione  che usa come identificatore il codice EIDR del film e un codice di due lettere che identifica la lingua, ad esempio ti per l'italiano e en per l'inglese.

### gerarchie
Nel progetto sono state inserite due gerarchie IsA:

### gerarchie - elemento

Il tipo di dato alla base di alexandria è l'Elemento.

Un Elemento rappresenta una aggiunta da parte di un utente alla propria libreria di un libro, film o videogioco.

Nella descrizione si specifica che tutti gli Elementi devono avere uno stato e una provenienza specifici al tipo di Elemento; è quindi necessaria la distinzione dei vari tipi di Elemento e creando così una gerarchia esclusiva (un Elemento non può essere sia un libro sia un film allo stesso tempo).

Si è deciso di rendere non totale la gerarchia in modo da permettere l'introduzione di nuovi tipi di Elementi in futuro.

### gerarchie - edizione

La seconda gerarchia inserita riguarda invece le diverse edizioni di un libro: pur se relative allo stesso libro, le edizioni possono essere sia edizioni caracee (o ebook) sia edizioni audio
 
La descrizione prevede che le edizioni dei libri e degli audiolibri abbiano attributi diversi: i libri hanno il numero di pagine e l'immagine della loro copertina, mentre gli audiolibri hanno la durata e la cover art ad essi associata;sono invece accomunate da tutte le altre relazioni, ad esempio l'essere relative ad uno stesso lbro. 

Si viene a creare così una gerarchia totale (un'Edizione è o libro o audiolibro) ed esclusiva (una edizione non può essere sia libro sia audiolibro)

_____
*Chiara*

### dato derivato

In `alexandria` non sono presenti molti dati quantitativi. Un dato derivato aggiungibile, però, è il numero di libri, film o videogame presenti nella libreria multimediale di un utente.

Per sapere se conviene mantenere questo dato derivato, effettuiamo un'analisi dei costi:

### dati iniziali

In seguito verranno calcolati i costi di mantenimento solo di uno dei tre dati derivati, perché il costo e il procedimento sono sempre gli stessi.

Valuteremo il costo di due operazioni:
- Operazione 1: Inserimento di un nuovo libro/film/videogame nella tabella
- Operazione 2: Visualizzazione dei dati di un utente, compreso il numero di libri/film/videogame presenti nella sua libreria multimediale

Le tabelle dei volumi sono state create in base a statistiche trovate ricercando online: Ogni anno in media una persona legge 12 libri, guarda 60 film e compra 24 videogame, per un totale di  96 elementi per ogni utente, circa. Immaginandoci 100 utenti, avremo quindi 9600 elementi:

La tabella degli accessi non sarà ricavata: i dati verranno analizzati in funzione di quest'ultima come conclusione.


### Con dato derivato:
Operazione 1: Inserisco una nuova tupla nella tabella Elemento, e poi aggiorno l'apposito attributo nella tabella Utente, passando per l'associazione Possiede.

Ogni elemento è posseduto da un unico utente, quindi l'associazione in questo caso è 1 a 1. Ne segue che occorreranno un aggiornamento per Possiede e uno per Utente, quindi due aggiornamenti in tutto.

1 write + (2 read + 2 write) = 7 per operazione

Operazione 2: Leggo il dato dalla tabella Utente

1 read = 1

### Senza dato derivato:
*Operazione 1*: Inserisco una nuova tupla nella tabella elemento, senza aggiornare altro

1 write = 2 per operazione

Operazione 2: Passando per l'associazione Possiede, calcolo la quantità di elementi del tipo desiderato. Poniamo che, per calcolare la quantità di elementi che soddisfano una condizione, sia necessario e sufficiente leggerli tutti.

Ogni utente possiede in media N elementi, quindi occorreranno un numero 2*N di operazioni read. Occorre quindi calcolare la cardinalità di passaggio fra Utente e Possiede:

Card(Utente -> Possiede) = Vol(Possiede) / Vol(Utente), quindi 9600 / 100, che fa 96

Il costo sarà quindi 96 read = 96 per operazione

### Risultato finale

Abbiamo calcolato i costi singoli di ciascuna operazione, adesso calcoliamo quale rapporto devono avere le due operazioni perché convenga il dato derivato.

Al momento abbiamo queste due equazioni che rappresentano i costi totali:

CostoCon e CostoSenza, che rappresentano le equazioni dei costi con e senza il dato derivato, in funzione della frequenza di esecuzione delle due operazioni principali.

Ponendo CostoCon < CostoSenza e facendo tutti i calcoli del caso, risulta che il rapporto fra Op1 e Op2 deve essere strettamente minore di 94/5. Ne consegue che, perché convenga tenere il dato derivato, le operazioni di inserimento di un nuovo dato devono essere al massimo 19 volte di più delle operazioni di visualizzazione. 

___
*Steffo*

### Switchando verso il titolo
Bene, questo è tutto, grazie perla vostra attenzione, arrivederci.

___