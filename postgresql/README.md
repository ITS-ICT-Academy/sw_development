# Il container `its_postgresql` #

Questo container contiene una installazione del [DBMS PostgreSQL](https://www.postgresql.org).

## Connessione da terminale a PostgreSQL ##

PostgreSQL possiede una potente interfaccia da riga di comando. 
Per connettersi, utilizzare il seguente comando:

```
docker exec -it its_postgresql psql -U postgres
```

Il comando avvia (`docker exec`) l'eseguibile `psql` (con l'opzione `-U postgres` che fissa il nome utente) nel container `its_postgresql` in una sessione interattiva (`-it`).

Si raccomanda di consultare la [documentazione specifica di psql](https://www.postgresql.org/docs/current/app-psql.html).


## Connessione a PostgreSQL tramite API ##

Il server PostgreSQL è accessibile tramite API:
 * Da software eseguito in un container parte dell'ecosistema Docker (ad es., il container `dev`), connettendosi all'host `postgresql` (il nome del container) sulla porta `5432`. Si veda il codice Python di esempio, che utilizza il driver `psycopg`.

 * Da software eseguito direttamente nella macchina host, connettendosi all'host `localhost` sulla porta salvata nella variabile d'ambiente `POSTGRESQL_EXPOSED_PORT` del file `.env`.


## PGAdmin ##
PGAdmin è un'app web che facilita la gestione di basi di dati in PostgreSQL. [PGAdmin è già compreso in questo ecosistema Docker, nel container `pgadmin`](README_pgadmin.md).




 ------

[Home](../README.md)