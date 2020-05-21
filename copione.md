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

Lo schema scheletro del progetto sarà suddiviso in sezioni, ciascuna riguardante un media diverso: Libri e audiolibri, Film o Videogiochi.

### Schema Scheletro - generico

Questa è la sezione principale, in cui descriviamo il fatto che gli utenti potranno aggiungere elementi alla loro raccolta multimediale, e recensirli. A questo punto, l'entità Elemento si divide in tre entità figlie: libro, film e videogioco.

### Schema Scheletro - libro

Questa è la sezione in cui ci occupiamo di libri e audiolibri.
Per ogni libro vengono raccolte alcune informazioni salienti, come gli autori, i generi e la trama. Invece, altre info come il numero di pagine sono definite per singola edizione.

### Schema Scheletro - Film

In questa sezione si gestiscono invece i film. Vengono raccolti il titolo, il codice EIDR e altre informazioni classiche, ma una cosa degna di nota è questa ternaria, che elenca il cast di un film e, per ogni membro, il ruolo che ha svolto.

### Schema Scheletro - Videogiochi

Arriviamo infine all'ultima sezione, la sezione Videogiochi. Anche qui vengono raccolte informazioni sul videogioco in generale, come lo sviluppatore e il publisher, e altre informazioni vengono invece distinte per ogni piattaforma.

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

Valuteremo il costo di due operazioni: l'Inserimento di un nuovo libro/film/videogame nella tabella, e la visualizzazione completa dei dati di un utente

La tabella dei volumi è stata creata in base a statistiche trovate su internet, mentre la tabella degli accessi non sarà ricavata.

Con il dato derivato, per eseguire l'operazione 1, inserisco una nuova tupla nella tabella Elemento, e poi aggiorno la tabella Utente, passando per Possiede. Occorreranno un write, un aggiornamento per Possiede e uno per Utente, quindi 3 write e 2 read. Per l'operazione 2 leggo semplicemente il dato dalla tabella Utente, quindi 1 read 

Senza dato derivato, per l'Operazione 1 inserisco una nuova tupla senza aggiornare altro, quindi 1 write. Per l'Operazione 2 invece, passando per Possiede, devo calcolare la quantità di elementi del tipo desiderato. Occorre calcolare la cardinalità di passaggio fra Utente e Possiede, che risulta essere 96. Il costo sarà quindi di ben 96 read.

### Risultato finale
Abbiamo calcolato i costi singoli di ciascuna operazione, adesso calcoliamo quale rapporto devono avere perché convenga il dato derivato.

Confrontando i due costi in funzione delle operazioni, perché convenga tenere il dato derivato, le operazioni di inserimento devono essere al massimo 94/5 in più di quelle di visualizzazione (quindi circa 19 volte tanto).
___
*Steffo*

### Switchando verso il titolo
Bene, questo è tutto, grazie per la vostra attenzione, arrivederci.

___
