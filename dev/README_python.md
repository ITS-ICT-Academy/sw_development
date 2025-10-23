# Esecuzione di codice Python #

È possibile aprire una shell `bash` nel container con il comando:

```
docker exec -it its_dev bash
```

Si osservi come il prompt cambierà in qualcosa del tipo:

```
root@a3eb9e517663:/home#
```
indicando che ci si trova nel container di id `a3eb9e517663` e si sta impersonando l'utente root.

La shell viene aperta nella directory `/home`, che, come spiegato, monta la directory della macchina host puntata dalla variabile d'ambiente `USER_BASE_FOLDER` (definita nel file `sw_development/.env`).

Da questo prompt è possibile eseguire normali comandi `bash`, ad esempio per:
* navigare nella directory desiderata (utilizzando il comando `cd`)
* elencare i file nella directory corrente (utilizzando il comando `ls`)
* eseguire l'interprete `python`.

## Esempio ##
Per eseguire il programma che, nella macchina host, risiede in:
```
~/Documents/its/python.1/esercizio_1.1/main.py "argomento 1" "argomento 2"
```

(con `USER_BASE_FOLDER=~/Documents/its`), basterà eseguire, all'interno della shell `bash` del container:

```
cd python.1/esercizio_1.1
python main.py "argomento 1" "argomento 2"
```

--------


## Chiusura della shell `bash` del container ##
Eseguire il comando `exit`.



---------

[Home](../README.md)
 * [Il container `dev`](./README.md)

