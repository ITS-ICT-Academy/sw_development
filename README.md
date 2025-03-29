# Ecosistema Docker per i corsi ITS ICT Academy #

Questa repository contiene un ecosistema di container Docker per supportare le attività didattiche relative ai corsi tecnici erogati da ITS ICT Academy.


# Installazione #

Clonare il repository in una directory locale.


# Avviare i container #
Lanciare da terminale il seguente comando (dalla directory che contiene il file `docker-compose.yaml`):

```
docker compose up --build -d
```

# Container avviati #

Verranno avviati i seguenti container:

## its_postgresql: PostgreSQL ##
Il DBMS PostgreSQL, nella versione riportata nella prima riga del file `postgresql/Dockerfile`.

## its_pgadmin: PGAdmin ##
Il sistema web PGAdmin per la gestione di servizi PostgreSQL, nella versione riportata nella prima riga del file `pgadmin/Dockerfile`.

## its_dev: ambiente per lo sviluppo in Python ## 
L'interprete Python, che viene installato con le librerie (e versioni) elencate nel file `python/requirements.txt`.


# Directory di servizio #

Il repository contiene due directory:

## `code` ## 
In questa directory andrà scritto il proprio codice. Questa directory sarà accessibile, all'interno del container, alla posizione `/home/code`.


## `data` ## 
In questa directory potranno essere salvati i dati di interesse per il programa. 
Questa directory sarà accessibile, all'interno del container, alla posizione `/home/data`.

La sotto-cartella `data/internal_data` verrà invece popolata dai container con i dati interni del DBMS e i dati di configurazione di PGAdmin, e non deve essere toccata.


# Esecuzione di codice Python #

Per eseguire il programma Python presente nel file `code/path/to/subfolder/nome_file.py`, basterà lanciare il seguente comando:

```
docker exec -it -w /home/code/path/to/subfolder its_dev python nome_file.py [OPTIONS]
```

sostituendo a `nome_file.py` il nome del file Python (nella directory `code`) che volete eseguire, ed aggiungere eventuali opzioni da riga di comando.

Il comando `python nome_file.py [OPTIONS]` verrà eseguito all'interno del container, nella directory `/home/code`.

La cartella `data`, che contiene i dati di interesse, sarà accessibile, dall'interno del container, al percorso `/home/data`.

Ad esempio, per eseguire il programma `code/test/main.py`, basterà lanciare il comando:

```
docker exec -it -w /home/code/test its_dev python main.py
```


# Terminare i container #

Per terminare i container, basterà eseguire il seguente comando:

```
docker compose down
```



### Autori ###

* Leonardo Picchiami ([picchiami@di.uniroma1.it](picchiami@di.uniroma1.it))
* Toni Mancini ([tmancini@di.uniroma1.it](tmancini@di.uniroma1.it))