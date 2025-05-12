# Ecosistema Docker per i corsi ITS ICT Academy #

Questa repository contiene un ecosistema di container Docker per supportare le attività didattiche relative ai corsi tecnici erogati da ITS ICT Academy.

*Attenzione*: questo ecosistema di container è pre-configurato per operare in ambiente di sviluppo. Pertanto è completamente disarmato e va configurato diversamente prima di dispiegarlo in un ambiente di produzione.


# Installazione #

Clonare il repository in una directory locale.


Per clonare il repository con `HTTPS`, aprire il terminale ed eseguire il comando:

```
git clone --branch 2024-2026 https://github.com/ITS-ICT-Academy/sw_development.git 
```

o, in alternativa, per clonare il repository con `SSH`, aprire il terminale ed eseguire il comando:

```
git clone --branch 2024-2026 git@github.com:ITS-ICT-Academy/sw_development.git 
```

# Configurazione #

1. Aprire un terminale nella directory `sw_development`.

2. Copiare il file `.env_example` in `.env`, ad esempio tramite il comando

```
cp .env_example .env
```

3. Aprire il file `.env` con un file di testo e modificare: 

   1. la stringa assegnata alla variabile `USER_BASE_FOLDER` con il percorso assoluto della directory radice dove è presente il proprio codice e dati che si vogliono rendere disponibili ai container.
   2. la stringa assegnata alla variabile `CONFIG_PATH` con il percorso relativo alla cartella `USER_BASE_FOLDER` che contiene i file richiesti dal Dockerfile per la configurazione dei container. I file richiesti sono:
       * Uno script bash `dev.sh` che esegue una configurazione completa del filesystem virtualizzato durante la build dell'immagine Docker. 
       * Tutti i file richiesti dallo script `dev.sh` per la configurazione.
   
        Il file `dev.sh` fornito come template dalla repository richiede, in aggiunta, la presenza di un file di testo contenente la lista dei pacchetti python da installare secondo la sintassi pip. Attenzione: la cartella `CONFIG_PATH` deve essere all'interno della cartella `USER_BASE_FOLDER`.
   3. la stringa assegnata alla variabile `PYTHONPATH` con il percorso assoluto della directory da inserire come libreria Python nell'ambiente di sviluppo.

Ad esempio:

```
# File .env
...
USER_BASE_FOLDER=~/Documents/its
CONFIG_PATH=config 
...
```

con la directory `~/Documents/its` che contiene, ad esempio:

```
config/
	dev.sh
	python_requirements.txt
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

## Container avviati ##

Verranno avviati i seguenti container:

### its_postgresql: PostgreSQL ###
Il DBMS PostgreSQL, nella versione riportata nella prima riga del file `postgresql/Dockerfile`.

### its_pgadmin: PGAdmin ###
Il sistema web PGAdmin per la gestione di servizi PostgreSQL, nella versione riportata nella prima riga del file `pgadmin/Dockerfile`.

### its_dev: ambiente per lo sviluppo in Python ###
L'interprete Python, che viene installato con le librerie (e versioni) elencate nel file `dev/python_requirements.txt`.


È possibile elencare i container attivi tramite il comando `docker ps`. Il risultato dovrebbe essere:

```
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS          PORTS                           NAMES
eb68b1524613   dpage/pgadmin4:latest   "/entrypoint.sh"         47 seconds ago   Up 47 seconds   443/tcp, 0.0.0.0:8000->80/tcp   its_pgadmin
f08940bf14c2   its-postgresql          "docker-entrypoint.s…"   47 seconds ago   Up 47 seconds   0.0.0.0:5432->5432/tcp          its_postgresql
4bfb833bc083   its-dev                 "python3"                47 seconds ago   Up 47 seconds                                   its_dev
```

## Persistenza dei dati ##

Al primo avvio, il comando `docker compose up ...` creerà due volumi: `sw_development_config_postgresql` e `sw_development_config_pgadmin`. Questi conterranno, rispettivamente, i database di PostgreSQL ed i file di configurazione di PGAdmin. 

Cancellare questi volumi significa riportare il PostgreSQL e PGAdmin alle impostazioni iniziali, in particolare *perdendo tutti i propri database*.


## Test ##

Il file `.env` ottenuto copiando `.env_example` e senza effettuare alcuna modifica, definisce `USER_BASE_FOLDER=./test`. 
In tale cartella è presente un piccolo programma di test: `test/simple_test/test.py`.

Per eseguirlo (se non si è modificato `.env`), basterà quindi lanciare il comando:

```
docker exec -it -w /home/simple_test its_dev python test.py
```

# Utilizzo dei container #

## Esecuzione di codice Python ##

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


## Gestione di basi di dati in PostgreSQL utilizzando PGAdmin ##

Puntando un browser all'indirizzo https://localhost:PPPP (dove PPPP è il numero di porta salvata nella variabile `PGADMIN_EXPOSED_PORT` del file `.env`) si accederà a PGAdmin, un sistema di gestione di server PostgreSQL.

Le credenziali da utilizzare per l'accesso sono:
 * nome utente: `admin@pgadmin.org`
 * password: `admin`

Una volta acceduto alla console di PGAdmin, bisognerà configurare la connessione ad almeno un server PostgreSQL. Per permettere la connessione al server PostgreSQL compreso in questo ecosistema, procedere come segue:
 * Scegliere lo strumento "Add New Server" dalla home page
 * Nella tab "General":
	 * Name: il nome che si vuole dare al server, ad esempio `postgresql`
	 * Lasciare le altre impostazioni al loro default
 * Nella tab "Connection":
	 * Host name/address: impostare l'indirizzo IP o l'hostname del server a cui ci si vuole connettere. Nel caso di connessione al server PostgreSQL incluso nell'ecosistema Docker, utilizzare il nome del servizio PostgreSQL, come configurato nel file `docker-compose.yaml`, ovvero `postgresql`
	 * Username: utilizzare il nome utente di default dell'immagine Docker di PostgreSQL, ovvero `postgres`
	 * Password: la password di default dell'account: `postgres`
	 * Save password: Sì
	 * Lasciare le altre impostazioni al loro default
 * Salvare.

A questo punto nella barra	di navigazione a sinistra, sarà presente il nuovo server (`postgresql`, se si è utilizzato il nome suggerito).

Espandendo il server nella barra di navigazione a sinistra, si possono elencare i database presenti nel DBMS. Dovrebbe esistere solo il database `postgres`, ovvero il database di servizio del DBMS che ospita i metadati e che non va mai utilizzato.

È possibile creare un nuovo database cliccando con il tasto destro e scegliendo `Create -> Database`, oppure, dopo aver selezionato il server, dal menu "Object".

Una volta selezionato (nella barra di navigazione) il database a cui ci si vuole connettere, utilizzare lo strumento "Query Tool", disponibile come pulsante nella parte alta della barra di navigazione oppure dal menu "Tool". Si aprirà una tab il cui titolo menziona il server a cui si è connessi, il nome utente e il database a cui ci si è connessi.

Il query tool permette di inviare comandi SQL. Scrivere uno o più comandi (separati da `;`) e cliccare sul pulsante "Execute script" nella barra degli strumenti.

Per ulteriori dettagli su PGAdmin, consultare la [documentazione specifica](https://www.pgadmin.org/docs/pgadmin4/latest/index.html).

## Connessione da terminale a PostgreSQL ##

PostgreSQL possiede una potente interfaccia da riga di comando. Per connettersi, utilizzare il seguente comando:

```
docker exec -it its_postgresql psql -U postgres
```

Il comando avvia (`docker exec`) l'eseguibile `psql` (con l'opzione `-U postgres` che fissa il nome utente) nel container `its_postgresql` in una sessione interattiva (`-it`).

Si raccomanda di consultare la [documentazione specifica di psql](https://www.postgresql.org/docs/current/app-psql.html).


## Connessione a PostgreSQL tramite API ##

Il server PostgreSQL è accessibile tramite API:
 * Da software eseguito in un container parte dell'ecosistema Docker (ad es., il container `dev`), connettendosi all'host `postgresql` (il nome del container) sulla porta `5432`. Si veda il codice Python di esempio, che utilizza il driver `psycopg`.

 * Da software eseguito direttamente nella macchina host, connettendosi all'host `localhost` sulla porta salvata nella variabile d'ambiente `POSTGRESQL_EXPOSED_PORT` del file `.env`.


# Terminare i container #

Per terminare i container, basterà eseguire il seguente comando:

```
docker compose down
```

Il contenuto della cartella `USER_BASE_FOLDER` resterà invariato tra una esecuzione dei container e l'altra.


### Autori ###

* Leonardo Picchiami ([picchiami@di.uniroma1.it](picchiami@di.uniroma1.it))
* Toni Mancini ([tmancini@di.uniroma1.it](tmancini@di.uniroma1.it))
