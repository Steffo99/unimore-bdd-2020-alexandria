<!--Da quanto ho capito qui dobbiamo scrivere tutto all'impersonale...-->

# Descrizione

Si vuole realizzare una base di dati a supporto di un sito web che permetta la creazione, gestione e condivisione della propria raccolta multimediale, in modo simile ad altri siti web come [aNobii](https://www.anobii.com/), [MyAnimeList](https://myanimelist.net/) e [The Backloggery](https://backloggery.com/)<!--Aggiungere altri esempi?-->.

Il sito è suddiviso in sezioni, ciascuna riguardante un [media](https://it.wikipedia.org/wiki/Mezzo_di_comunicazione_di_massa) diverso:

| Sezione | Contenuto |
|---------|-----------|
| `books` | [Libri](https://it.wikipedia.org/wiki/Libro) e [audiolibri](https://it.wikipedia.org/wiki/Audiolibro) |
| `movies` | [Film](https://it.wikipedia.org/wiki/Film) |
| `games` | [Videogiochi](https://it.wikipedia.org/wiki/Videogioco) |
| `tv-series` | [Serie televisive](https://it.wikipedia.org/wiki/Fiction_televisiva#Serie_televisiva) e qualsiasi media a episodi | 

## Utenti

Una persona può registrarsi al sito web scegliendo un username univoco e inserendo una password segreta (sarà [hashata](https://it.wikipedia.org/wiki/Funzione_di_hash) con l'algoritmo [bcrypt](https://it.wikipedia.org/wiki/Bcrypt) prima che venga inserita nel database), creando così un utente.

Ogni utente avrà una sua raccolta multimediale, in cui potrà liberamente aggiungervi, modificarvi o eliminarvi elementi.

<!--To be continued-->

