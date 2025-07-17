# Ecosistema Docker per i corsi ITS ICT Academy #

Questa repository contiene un ecosistema di container Docker per supportare le attività didattiche relative ai corsi tecnici erogati da ITS ICT Academy.

------
**Attenzione**: Questo ecosistema di container è pre-configurato per operare in ambiente di sviluppo. Pertanto è completamente disarmato e va configurato diversamente prima di dispiegarlo in un ambiente di produzione.

------

# Installazione #

Clonare il repository in una directory locale in. modalità `HTTPS` oppure `SSH`. 

 * **Modalità `HTTPS`**: 
 	Aprire il terminale in una directory all'interno della quale si vuole clonare il repository, ed eseguire il comando:

	```
	git clone --branch 2024-2026 https://github.com/ITS-ICT-Academy/sw_development.git 
	```

	Il repository sarà clonato in una sottodirectory `sw_development` della directory scelta.

 * **Modalità `SSH`**:
	La modalità `SSH` è pensata per un utilizzo ripetuto. Per essere utilizzata, è necessario salvare la chiave pubblica `SSH` dell'utente corrente della macchina locale nella piattaforma GIT su web.

	Una volta salvate la propria chiave pubblica `SSH`, procedere come sopra, ma utilizzando il comando seguente:

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

   1. La stringa assegnata alla variabile `USER_BASE_FOLDER` con il percorso assoluto della directory radice dove è presente il proprio codice e dati che si vogliono rendere disponibili ai container.
   2. La stringa assegnata alla variabile `CONFIG_PATH` con il percorso relativo alla cartella `USER_BASE_FOLDER` che contiene i file richiesti dal Dockerfile per la configurazione dei container. I file richiesti sono:
       * Uno script bash `dev.sh` che esegue una configurazione completa del filesystem virtualizzato durante la build dell'immagine Docker. 
       * Tutti i file richiesti dallo script `dev.sh` per la configurazione.
   
        Il file `dev.sh` fornito come template dalla repository richiede, in aggiunta, la presenza di un file di testo contenente la lista dei pacchetti python da installare secondo la sintassi pip. Attenzione: la cartella `CONFIG_PATH` deve essere all'interno della cartella `USER_BASE_FOLDER`.
   3. La stringa assegnata alla variabile `PYTHONPATH` con il percorso assoluto della directory da inserire come libreria Python nell'ambiente di sviluppo.

## Esempio di configurazione ##

```
# File .env
...
# Questa directory sarà montata nel container dev 
# nella posizione /home
USER_BASE_FOLDER=~/Documents/its 

# Questa directory, all'interno di ${USER_BASE_FOLDER}, 
# conterrà la configurazione del proprio ambiente
CONFIG_PATH=config 
...
```

La directory `~/Documents/its` conterrà la sottodirectory `config/` con la configurazione del proprio ambiente, e tutto il codice che si vuole rendere accessibile dall'interno del container `dev`. Ad esempio:

```
config/
	dev.sh
	python_requirements.txt
python.1/
	esercizio_1.1/
		main.py
python.2/
	esercizio_2.1/
		main.py
	esercizio_2.2/
		main.py
web.2/
	app-react-1/
		...		
java.1/
	esercizio_1.1.java
	...

```


# Avviare i container #
Lanciare da terminale il seguente comando (dalla directory `sw_development`, che contiene il file `docker-compose.yaml`):

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

-------

### its_dev: ambiente per lo sviluppo ###
L'ambiente di sviluppo contiene:
* L'interprete Python, che viene installato con le librerie (e versioni) elencate nel file `dev/python_requirements.txt`.
* L'ambiente di sviluppo NodeJS & ReactJS per la creazione e sviluppo di applicazioni web.

**Guida per l'uso**: Il file [`dev/README.md`](dev/README.md) contiene una guida dettagliata su come utilizzare questo container.

-------

### its_postgresql: PostgreSQL ###
Il DBMS PostgreSQL, nella versione riportata nella prima riga del file `postgresql/Dockerfile`.

**Guida per l'uso**: Il file [`postgresql/README.md`](postgresql/README.md) contiene una guida dettagliata su come utilizzare questo container.

-------

### its_pgadmin: PGAdmin ###
Il sistema web PGAdmin per la gestione di servizi PostgreSQL, nella versione riportata nella prima riga del file `pgadmin/Dockerfile`.

**Guida per l'uso**: Il file [`postgresql/README.md`](postgresql/README.md) contiene una guida dettagliata anche su come utilizzare PGAdmin.


---------

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


# Terminare i container #

Per terminare i container, basterà eseguire il seguente comando:

```
docker compose down
```

Il contenuto della cartella `USER_BASE_FOLDER` resterà disponibile per la successiva esecuzione dei container.


### Autori ###

* Leonardo Picchiami ([picchiami@di.uniroma1.it](picchiami@di.uniroma1.it))
* Toni Mancini ([tmancini@di.uniroma1.it](tmancini@di.uniroma1.it))
