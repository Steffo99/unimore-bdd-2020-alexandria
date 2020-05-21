_____
*Chiara*

### Titolo

Buongiorno a tutti, noi siamo Chiara Calzolari e Stefano Pigozzi e in questo video presenteremo Alexandria, il nostro progetto per la classe di Basi di Dati.

_____
*Steffo*

### Perchè Alexandria

Volevamo realizzare un sito web che permettesse agli utenti di creare e condividere la loro libreria multimediale, composta dai libri che hanno letto, film che hanno visto e videogiochi a cui hanno giocato. 

Volevamo pubblicare il progetto su GitHub, e per farlo, avevamo bisogno di un nome da dargli che fosse facile da ricordare.

Allora, dato che parte del progetto riguardava i libri, abbiamo deciso di dargli il nome di Alexandria, come il nome della città in cui si trovava la più grande biblioteca dell'antichità.

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

Queste invece sono tutte le cose che abbiamo contribuito allo spazio idee.

### autoassociazioni

Partiamo dalle autoassociazioni. 

In Alexandria, le autoassociazioni vengono usate per rappresentare correlazioni tra libri, film e videogiochi.

Esempi di correlazioni possono essere i sequel, i prequel, oppure opere ambientate nello stesso universo, come ad esempio, L'Impero Colpisce Ancora, che sarà correlato con Una Nuova Speranza e Il Ritorno dello Jedi.

### Identificatori esterni

In quanto agli identificatori esterni, in Alexandria ne abbiamo due casi.

### Identificatori esterni - recensione

Il primo sono le recensioni pubblicate dagli utenti relative a un elemento, che sono identificate dall'ID dell'elemento a cui si riferiscono.

### Identificatori esterni - localizzazione

Il secondo, invece, sono i film che hanno titoli diversi per ogni lingua.

Mentre nei libri e nei giochi gestiamo questa possibilità attraverso le entità edizione, non possiamo fare lo stesso nei film, che non ne sono dotati.

Abbiamo quindi creato l'entità Localizzazione: essa usa un identificatore composto dal codice EIDR del film e dal codice ISO della lingua (dove, ad esempio, l'italiano corrisponde a it).

### gerarchie

In quanto alle gerarchie, invece, ne abbiamo due.

### gerarchie - elemento

La prima sta alla base dell'intero sistema di Alexandria.

Essa rappresenta una specializzazione di ogni elemento esclusivamente in un tipo.

Utilizzando la gerarchia, possiamo avere attributi e relazioni generalizzati per ogni elemento, ma possiamo anche avere specializzazioni necessarie ad esempio a collegare ogni elemento al suo corrispettivo libro film o gioco. 

### gerarchie - edizione

La seconda gerarchia invece riguarda la distinzione tra libri e audiolibri.

Entrambi, infatti, hanno relazioni in comune, ma anche attributi come "durata" o relazioni come "narrato da" che riguardano uno ma non l'altro.

Si viene a creare così una gerarchia totale ed esclusiva.

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
