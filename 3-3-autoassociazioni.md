# Classificazione delle autoassociazioni

Alexandria prevede la possibilità di marcare come correlate due opere in modo tale da far apparire sulla pagina di una un collegamento all'altra.

Si è deciso di sviluppare questa funzionalità utilizzando delle **autoassociazioni**: ogni `Libro`, `Film` o `Videogioco` sarà correlato ad altre entità del suo stesso tipo tramite la relazione `è correlato a`. 

![](img/3-3-autoassociazioni/autoassociazione.png)

> Inizialmente, si è considerato di aggiungere una unica autoassociazione alla entità `Elemento`, ma si è poi giunti alla conclusione che questo approccio sarebbe stato sbagliato: si sarebbero dovuti associare tutti i singoli `Elementi` creati da ciascun `Utente`, creando una quantità  di correlazioni a crescita esponenziale!

> Una possibile estensione alla funzionalità si potrebbe ottenere aggiungendo un attributo _Tipo_ alla relazione `è correlato a`: esso permetterebbe agli `Utenti` di descrivere come due opere sono correlate tra loro ("sequel", "prequel", "stesso universo", etc...).
