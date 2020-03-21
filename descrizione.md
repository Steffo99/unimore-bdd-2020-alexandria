<!--Da quanto ho capito qui dobbiamo scrivere tutto all'impersonale...-->

# Descrizione

Si vuole realizzare una base di dati a supporto di un sito web che permetta la creazione, gestione e condivisione della propria raccolta multimediale, come è possibile fare su altri siti web, quali [aNobii](https://www.anobii.com/), [MyAnimeList](https://myanimelist.net/) e [The Backloggery](https://backloggery.com/)<!--Aggiungere altri esempi?-->.

Il sito sarà suddiviso in sezioni, ciascuna riguardante un [media](https://it.wikipedia.org/wiki/Mezzo_di_comunicazione_di_massa) diverso:

- [Libri](https://it.wikipedia.org/wiki/Libro) e [audiolibri](https://it.wikipedia.org/wiki/Audiolibro)
- [Film](https://it.wikipedia.org/wiki/Film)
- [Videogiochi](https://it.wikipedia.org/wiki/Videogioco)
- [Serie televisive](https://it.wikipedia.org/wiki/Fiction_televisiva#Serie_televisiva)

## Utenti

Chiunque può registrarsi al sito web scegliendo un username univoco e inserendo una password segreta (sarà [hashata](https://it.wikipedia.org/wiki/Funzione_di_hash) con l'algoritmo [bcrypt](https://it.wikipedia.org/wiki/Bcrypt) prima che venga inserita nel database), creando così un utente.

Ogni utente avrà una sua raccolta multimediale, in cui potrà aggiungere, modificare e rimuovere elementi.

## Elementi

Gli elementi <span style="background-color: yellow; color: black;">(Quali elementi? Qui forse serve qualche complemento generale per descriverli)</span> saranno suddivisi in quattro macrocategorie:
- [Libri](https://it.wikipedia.org/wiki/Libro) e [audiolibri](https://it.wikipedia.org/wiki/Audiolibro)
- [Film](https://it.wikipedia.org/wiki/Film)
- [Videogiochi](https://it.wikipedia.org/wiki/Videogioco)
- [Serie televisive](https://it.wikipedia.org/wiki/Fiction_televisiva#Serie_televisiva).

Ogni elemento avrà una sua pagina con le informazioni salienti, e potrà ricevere una recensione (vedi sotto) da parte dell'utente

## Recensioni

Ogni utente può lasciare la sua recensione ad un elemento, composta da una valutazione (un numero da 0 a 100) e un commento. Le recensioni vengono scritte dagli utenti, e possono essere modificate o eliminate dai Moderatori e Amministratori, se essi credono non siano adeguate o inerenti.
<span style="background-color: yellow; color: black;">Le recensioni di un dato elemento saranno poi visualizzabili nella sua pagina. (sarà così?)</span>

## Libri ed edizioni

<!--https://it.wikipedia.org/wiki/Template:Libro-->

Ogni libro avrà una pagina dove sarà presente il titolo originale, l'autore, un breve riassunto della trama e l'elenco di tutte le sue edizioni.

Ciascuna edizione del libro avrà varie informazioni associate, quali il suo titolo, la copertina e il numero di pagine, e sarà identificata da il relativo [codice ISBN](https://it.wikipedia.org/wiki/ISBN).

## Film

<!--https://it.wikipedia.org/wiki/Template:Film-->

<span style="background-color: yellow; color: black;">TODO</span>

## Videogiochi

<!--https://it.wikipedia.org/wiki/Template:Videogioco-->

<span style="background-color: yellow; color: black;">TODO</span>

## Serie televisive

<!--https://it.wikipedia.org/wiki/Template:FictionTV-->

<span style="background-color: yellow; color: black;">TODO</span>
