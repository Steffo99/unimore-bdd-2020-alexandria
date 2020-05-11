# Classificazione delle gerarchie

Nello schema scheletro di `alexandria` compaiono due gerarchie IsA, rappresentate da frecce continue blu.

## Gerarchia degli _Elementi_

![](img/3-2-gerarchie/gerarchia-1.png)

Il tipo di dato alla base di `alexandria` è l'_Elemento_.

Un Elemento rappresenta una aggiunta da parte di un utente alla propria libreria di un libro, film o videogioco.

Nella [descrizione](1-descrizione.md) si specifica che tutti gli Elementi devono avere uno _stato_ e una _provenienza_ specifici al tipo di Elemento; è quindi necessaria la distinzione dei vari tipi di Elemento e creando così una gerarchia **esclusiva** (un Elemento non può essere sia un libro sia un film allo stesso tempo).

Si è deciso di rendere **non totale** la gerarchia in modo da permettere l'introduzione di nuovi tipi di Elementi in futuro.

## Gerarchia delle _Edizioni_

![](img/3-2-gerarchie/gerarchia-2.png)

La [descrizione](1-descrizione.md) prevede che le edizioni dei libri e degli audiolibri abbiano attributi diversi: i libri hanno il _numero di pagine_ e l'immagine della loro _copertina_, mentre gli audiolibri hanno la _durata_ e la _cover art_ ad essi associata.

Si viene a creare così una gerarchia **totale** (un'Edizione è o libro o audiolibro) ed **esclusiva** (una edizione non può essere sia libro sia audiolibro).
