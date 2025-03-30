# Ecosistema Docker per i corsi ITS ICT Academy #

Questa repository contiene un ecosistema di container Docker per supportare le attività didattiche relative ai corsi tecnici erogati da ITS ICT Academy.


# Installazione #

Clonare il repository in una directory locale.

# Configurazione #

1. Aprire un terminale nella directory `sw_development`.

2. Copiare il file `.env_example` in `.env`, ad esempio tramite il comando

```
cp .env_example .env
```

3. Aprire il file `.env` con un file di testo e modificare: 

   1. la stringa assegnata alla variabile `USER_BASE_FOLDER` con il percorso assoluto della directory radice dove è presente il proprio codice e dati che si vogliono rendere disponibili ai container.
   2. la stringa assegnata alla variabile `PYTHON_PIP_REQUIREMENTS` con il percorso assoluto al file che contiene la lista dei pacchetti python da installare secondo la sintassi pip. Attenzione: il file deve essere all'interno della cartella `USER_BASE_FOLDER`.

Ad esempio:

```
# File .env
...
USER_BASE_FOLDER=~/Documents/its
PYTHON_PIP_REQUIREMENTS=${USER_BASE_FOLDER}/python_requirements.txt 
...
```

con la directory `~/Documents/its` che contiene, ad esempio:

```
python.1/
	esercizio_1.1/
		main.py
python.2
	esercizio_2.1/
		main.py
	esercizio_2.2/
		main.py
```


# Avviare i container #
Lanciare da terminale il seguente comando (dalla directory che contiene il file `docker-compose.yaml`):

```
docker compose up --build -d
```

L'output del comando dovrebbe terminare con qualcosa del tipo:

```
[+] Running 6/6
 ✔ dev                       Built     0.0s 
 ✔ postgresql                Built     0.0s 
 ✔ Network its_network       Created   0.0s 
 ✔ Container its_dev         Started   0.1s 
 ✔ Container its_pgadmin     Started   0.1s 
 ✔ Container its_postgresql  Started   0.1s 
```

# Container avviati #

Verranno avviati i seguenti container:

## its_postgresql: PostgreSQL ##
Il DBMS PostgreSQL, nella versione riportata nella prima riga del file `postgresql/Dockerfile`.

## its_pgadmin: PGAdmin ##
Il sistema web PGAdmin per la gestione di servizi PostgreSQL, nella versione riportata nella prima riga del file `pgadmin/Dockerfile`.

## its_dev: ambiente per lo sviluppo in Python ## 
L'interprete Python, che viene installato con le librerie (e versioni) elencate nel file `dev/python_requirements.txt`.


È possibile elencare i container attivi tramite il comando `docker ps`. Il risultato dovrebbe essere:

```
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS          PORTS                           NAMES
eb68b1524613   dpage/pgadmin4:latest   "/entrypoint.sh"         47 seconds ago   Up 47 seconds   443/tcp, 0.0.0.0:8000->80/tcp   its_pgadmin
f08940bf14c2   its-postgresql          "docker-entrypoint.s…"   47 seconds ago   Up 47 seconds   0.0.0.0:5432->5432/tcp          its_postgresql
4bfb833bc083   its-dev                 "python3"                47 seconds ago   Up 47 seconds                                   its_dev
```

# Persistenza dei dati #

Al primo avvio, il comando `docker compose up ...` creerà due volumi: `sw_development_config_postgresql` e `sw_development_config_pgadmin`. Questi conterranno, rispettivamente, i database di PostgreSQL ed i file di configurazione di PGAdmin. 

Cancellare questi volumi significa riportare il PostgreSQL e PGAdmin alle impostazioni iniziali, in particolare *perdendo tutti i propri database*.


# Esecuzione di codice Python #

Per eseguire il programma Python presente nel file `USER_BASE_FOLDER/subfolder1/.../subfolderN/nome_file.py`, basterà lanciare il seguente comando:

```
docker exec -it -w /home/subfolder1/.../subfolderN its_dev python nome_file.py [OPTIONS]
```

sostituendo a `nome_file.py` il nome del file Python che si vuole eseguire, ed aggiungere eventuali opzioni da riga di comando.

Il comando `python nome_file.py [OPTIONS]` verrà eseguito all'interno del container, nella directory specificata dall'opzione `-w`.

Continuando con l'esempio precedente, per eseguire il programma `~/Documents/its/python.1/esercizio_1.1/main.py` (con `USER_BASE_FOLDER=~/Documents/its`), basterà eseguire:

```
docker exec -it -w /home/python.1/esercizio_1.1 its_dev python main.py [OPTIONS]
```

# Test #

Il file `.env` ottenuto copiando `.env_example` e senza effettuare alcuna modifica, definisce `USER_BASE_FOLDER=./test`. 
In tale cartella è presente un piccolo programma di test: `test/simple_test/test.py`.

Per eseguirlo (se non si è modificato `.env`), basterà quindi lanciare il comando:

```
docker exec -it -w /home/simple_test its_dev python test.py
```

# Terminare i container #

Per terminare i container, basterà eseguire il seguente comando:

```
docker compose down
```

Il contenuto della cartella `USER_BASE_FOLDER` resterà invariato tra una esecuzione dei container e l'altra.


### Autori ###

* Leonardo Picchiami ([picchiami@di.uniroma1.it](picchiami@di.uniroma1.it))
* Toni Mancini ([tmancini@di.uniroma1.it](tmancini@di.uniroma1.it))
