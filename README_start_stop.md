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

### its_dev: ambiente per lo sviluppo --> [Guida per l'uso](dev/README.md) ###
L'ambiente di sviluppo è già configurato per poter eseguire:

* Codice Python. L'interprete Python viene installato con le librerie (e versioni) elencate nel file `dev/python_requirements.txt`.

* Codice Javascript per applicazioni web utilizzando NodeJS & ReactJS.

L'ambiente di sviluppo è estendibile dall'utente.

-------

### its_postgresql: PostgreSQL --> [Guida per l'uso](postgresql/README.md) ###
Il DBMS PostgreSQL, nella versione riportata nella prima riga del file `postgresql/Dockerfile`.

-------

### its_pgadmin: PGAdmin --> [Guida per l'uso](postgresql/README.md) ###
Il sistema web PGAdmin per la gestione di servizi PostgreSQL, nella versione riportata nella prima riga del file `pgadmin/Dockerfile`.

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

I volumi possono essere visualizzati tramite il comando `docker volume ls`, che restituirà qualcosa del tipo:

```
DRIVER    VOLUME NAME
local     its_sw_development_config_pgadmin
local     its_sw_development_config_postgresql
```

Cancellare questi volumi (mediante il comando `docker volume rm <VOLUME_NAME>`) significa riportare il PostgreSQL e PGAdmin alle impostazioni iniziali, in particolare *perdendo tutti i propri database*.



# Terminare i container #

Per terminare i container, basterà eseguire il seguente comando:

```
docker compose down
```

Il contenuto della cartella `USER_BASE_FOLDER` resterà disponibile per la successiva esecuzione dei container.

---------

[Home](README.md)