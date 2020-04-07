# Esempio di autoassociazione

Nel progetto alexandria, ogni elemento (libro, film o videogioco che sia) è collegato ad una sua pagina in cui vengono visualizzate alcune informazioni salienti quali l'autore, la casa produttrice o simili.

Oltre alle informazioni già presenti in ciascuna pagina, sarebbe stato utile all'utente avere, per ogni libro, film o videogioco, anche una lista di elementi ad esso correlati, come ad esempio il sequel di un film, o un libro ambientato nello stesso universo narrativo.

Perciò è stato deciso di inserire, per ognuna di queste tre categorie, una autoassociazione come quella in figura:

![](https://raw.githubusercontent.com/Steffo99/alexandria/master/Images/Autoassociazione.png)

Un altra opzione precedentemente presa in considerazione fu quella di inserire un'unica autoassociazione, in corrispondenza dell'entità Elemento.

Questa opzione venne però scartata per ragioni di logica. L'entità Elemento, infatti, rappresenta una singola _istanza_ di un libro, film o videogioco, e sarebbe stato insensato collegare ciascuna istanza a tutte le altre, servivano entità più generali.