# Identificazione delle autoassociazioni

Nel progetto `alexandria`, ogni libro, film o videogioco è collegato ad una sua pagina in cui vengono visualizzate alcune informazioni salienti su di esso quali l'autore, la casa produttrice o simili.

Oltre alle informazioni già presenti in ciascuna pagina, si è pensato che sarebbe stato utile all'utente avere, per ogni libro, film o videogioco, anche una lista di elementi ad esso correlati, come ad esempio i sequel di un film, o altri libri ambientati nello stesso universo narrativo.

Pertanto si è deciso di inserire, per ognuna di queste tre categorie, una autoassociazione come quella in figura:

![](img/autoassociazione.png)

Un altra opzione precedentemente presa in considerazione fu quella di inserire un'unica autoassociazione, in corrispondenza dell'entità Elemento.

Questa opzione venne però scartata per ragioni di logica. L'entità Elemento, infatti, rappresenta una singola _istanza_ di un libro, film o videogioco, e sarebbe stato insensato collegare ciascuna istanza a tutte le altre, in quanto ciò avrebbe portato a un numero elevatissimo di collegamenti.
