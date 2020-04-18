# Aggiunta di gerarchie


Nel progetto `alexandria` sono state inserite due gerarchie:

![](/img/Gerarchia1.png)

Ogni utente, nel suo profilo, ha la possibilità di gestire e aggiornare una lista di elementi da lui posseduti: questi elementi possono essere libri, film o videogiochi. Siccome questi elementi hanno attributi e relazioni diverse, ma sono accomunati dall'essere posseduti dall'utente ed essere oggetto di recensioni, è sembrato opportuno rappresentarli come una gerarchia, in cui "Elemento" è l'entità padre, mentre le entità figlio sono rispettivamente "Elemento (libro)", "Elemento (film)", e "Elemento(gioco)".

![](/img/Gerarchia2.png)

La seconda gerarchia inserita riguarda invece le diverse edizioni di un libro: pur se relative allo stesso libro, le edizioni possono essere sia edizioni caracee (o ebook) sia edizioni audio. Le due categorie hanno attributi diversi: delle edizioni audio occorre sapere la durata in minuti, un'immagine rappresentativa e la voce narrante (che viene trattata come un'entità a parte), mentre nelle edizioni libro si vuole sapere il numero di pagine e la copertina; sono invece accomunate da tutte le altre relazioni, ad esempio l'essere relative ad uno stesso lbro. 