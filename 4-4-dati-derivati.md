# Dati derivati

In Alexandria non sono presenti molti dati quantitativi: la maggior parte degli attributi sono infatti qualitativi, e come tali meglio descritti da stringhe.

![](img/4-4-dati-derivati/con-e-senza.png)

Si è considerata la possibilità di inserire nella base di dati un attributo contenente il **conteggio** di `Elementi` posseduti da un utente, ma dopo un'analisi dei costi l'ipotesi è stata scartata perchè **non conveniente**.
 
Si riportano sotto tutti i calcoli effettuati.
 
## Tabella dei volumi

Secondo una stima effettuata, l'utente medio di Alexandria leggerà all'anno 18 libri, ascolterà 6 audiolibri, guarderà 52 film e giocherà a 24 giochi, per un totale di circa 100 `Elementi` per `Utente` all'anno.

Si ottiene, dunque, la seguente tabella dei volumi:

| Concetto | Tipo | Volume |
|----------|------|--------|
| `Utente` | Entità | **1**/utente |
| `Elemento (audiolibri)` | Entità | **6**/utente/anno |
| `Elemento (libro)` | Entità | **18**/utente/anno |
| `Elemento (film)` | Entità | **52**/utente/anno |
| `Elemento (gioco)` | Entità | **24**/utente/anno |

## Tabella delle operazioni

Si stima che ogni utente riceverà circa 500 visite alla suo profilo all'anno.

Si sono valutate due diverse operazioni:

| Operazione | Descrizione | Tipo | Frequenza | Schema |
|------------|-------------|------|-----------|--------|
| __OP1__ | Creazione di un nuovo `Elemento` (di un tipo qualunque) | Interattiva | **100**/utente/anno | `Elemento` |
| __OP2__ | Visualizzazione del conteggio di `Elementi` di qualsiasi tipo creati da un `Utente` specifico | Interattiva | **500**/utente/anno | `Elemento` |

## Tabella dei costi

### Senza dato derivato

| Operazione | Procedura | Costi | Costo totale |
|------------|-----------|-------|--------------|
| __OP1__ | Si inserisce una nuova tupla nella tabella `Elemento` corrispondente. | 1 write | **2** |
| __OP2__ | Si interrogano le tabelle degli `Elementi`, filtrando quelle che non sono state create dall'utente richiesto, e conteggiando le tuple restituite. | 6 read + 18 read + 52 read + 24 read | **100** |

### Con dato derivato

| Operazione | Procedura | Costi | Costo totale |
|------------|-----------|-------|--------------|
| __OP1__ | Si inserisce una nuova tupla nella tabella `Elemento` corrispondente e si aggiorna il dato derivato della tupla dell'`Utente` creatore. | 1 write + 1 write | **4** |
| __OP2__ | Si va a vedere il dato derivato nella tabella dell'`Utente` interessato. | 1 read | **1** |

## Risultato

| Metodo | Costo __OP1__ | Costo __OP2__ | Costo totale |
|--------|---------------|---------------|--------------|
| Senza dato derivato | 2 * 100 | 100 * 500 | 50200 |
| Con dato derivato | 4 * 100 | 1 * 500 | 900 |

<!--Wait, questa è una contraddizione!-->
