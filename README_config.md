# Configurazione #

Dopo aver eseguito l'[installazione ](README_install.md), procedere con la configurazione dell'ecosistema al proprio ambiente di lavoro.

L'obiettivo è quello di fare in modo che l'ecosistema Docker possa accedere ad una directory della macchina host scelta dall'utente (e fuori dalla directory `sw_development`), che contenga:

* la configurazione personale e
* il codice sviluppato. 

In questo modo, la directory `sw_development` potrà essere cancellata senza perdere i propri dati, oppure aggiornata in caso fosse disponibile una nuova versione dell'ecosistema.

Procedere come segue:

1. Scegliere (o creare) una directory (fuori da `sw_development`) dove si vuole salvare il codice che si intende eseguire nell'ecosistema Docker e la configurazione personale dell'ecosistema stesso. 
Ad esempio, la directory `~/Documents/its`, ovvero la directory `its` all'interno della directory `Documents` nella propria home directory.
Se la directory non dovesse esistere, è possibile crearla con `mkdir -p ~/Documents/its`.

2. Copiare la directory `sw_development/sample_user_base_folder/config` (che contiene una configurazione iniziale base) nella directory scelta al punto precedente.

3. Aprire il file `.env` (nella directory `sw_development`) con un file di testo (questo file è stato creato durante la procedura di test duplicando il file `.env_example`) e modificare: 

   * La stringa assegnata alla variabile `USER_BASE_FOLDER` con il percorso assoluto della directory radice dove è presente il proprio codice e dati che si vogliono rendere disponibili ai container (ad es., `~/Documents/its`).


## Esempio di configurazione iniziale ##

Assumendo di aver scelto, come directory base per il proprio codice e dati di configurazione, la directory `~/Documents/its`, il file `.env` dovrebbe essere così:

```
# File .env
COMPOSE_PROJECT_NAME="its"

# Pointer to the root directory to be mounted in all containers as /home/
USER_BASE_FOLDER='~/Documents/its'
...
```

La directory base (`~/Documents/its`) conterrà tutto il codice che si vuole rendere accessibile dall'interno dell'ecosistema Docker e la sottodirectory `config/` con la configurazione del proprio ambiente.

La propria directory base dovrebbe apparire così:

```
config/
	dev/
		01-base-packages.sh
		02-python.sh
		...
		main.sh
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

La configurazione del proprio ecosistema sarà quindi definita in due posizioni:

* Il file `sw_development/.env` che contiene i valori per alcune variabili d'ambiente, tra cui `USER_BASE_FOLDER`

* La directory `${USER_BASE_FOLDER}/config`.


## Personalizzazione del file `sw_development/.env` ##

Questo file deve essere sempre presente nella directory `sw_development`, e **non sarà sovrascritto** in caso di [aggiornamento](README_update.md).

Permette di definire le seguenti variabili d'ambiente, che sono utilizzate dall'ecosistema Docker in fase di avvio e di utilizzo:

* `USER_BASE_FOLDER`: la directory base dove è disponibile il codice dell'utente e il resto della configurazione. Questa directory sarà montata nella posizione `/home` all'interno dei container.

* `CONFIG_PATH`: il nome della sottodirectory di `USER_BASE_FOLDER` dove è presente il resto della configurazione. Il valore di default è `config`.


## Personalizzazione della directory `${USER_BASE_FOLDER}/${CONFIG_PATH}`

Questa directory contiene uno o più script bash che vengono eseguiti alla creazione dei diversi container.

In particolare, lo script `main.sh` nella sottodirectory `XXX` sarà eseguito durante la creazione del container `its_XXX`.

Questi script si prestano ad essere modificati dall'utente per installare, nei diversi container, ulteriore software.


---------

[Home](README.md)