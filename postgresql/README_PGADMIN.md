# Il container `its_pgadmin` #

Questo container contiene una installazione del software PGAdmin, un'app web per la gestione di basi di dati in PostgreSQL. 

## Accesso a PGAdmin ##

Puntare un browser all'indirizzo https://localhost:PPPP, dove PPPP è il numero di porta salvata nella variabile `PGADMIN_EXPOSED_PORT` del file `.env`.

Le credenziali da utilizzare per l'accesso sono:
 * nome utente: `admin@pgadmin.org`
 * password: `admin`


### Prima configurazione di PGAdmin ###

La prima volta che si accede alla console di PGAdmin, bisognerà configurare la connessione ad almeno un server PostgreSQL. 

Per permettere la connessione al server PostgreSQL compreso in questo ecosistema, procedere come segue:

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


## Utilizzo di PGADmin ##

Espandendo il server nella barra di navigazione a sinistra, si possono elencare i database presenti nel DBMS. 
Dovrebbe esistere solo il database `postgres`, ovvero il database di servizio del DBMS che ospita i metadati e che non va mai utilizzato.

È possibile creare un nuovo database cliccando con il tasto destro e scegliendo `Create -> Database`, oppure, dopo aver selezionato il server, dal menu "Object".

Una volta selezionato (nella barra di navigazione) il database a cui ci si vuole connettere, utilizzare lo strumento "Query Tool", disponibile come pulsante nella parte alta della barra di navigazione oppure dal menu "Tool". Si aprirà una tab il cui titolo menziona il server a cui si è connessi, il nome utente e il database a cui ci si è connessi.

Il query tool permette di inviare comandi SQL. Scrivere uno o più comandi (separati da `;`) e cliccare sul pulsante "Execute script" nella barra degli strumenti.

## Documentazione specifica ##
Per ulteriori dettagli su PGAdmin, consultare la [documentazione specifica](https://www.pgadmin.org/docs/pgadmin4/latest/index.html).


----------

[Home](../README.md)
* [Il container `its_postgresql`](README.md)
