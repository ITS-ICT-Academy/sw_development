# Prima installazione e configurazione iniziale #

## Installazione ##
1. Clonare il repository in una directory locale in. modalità `HTTPS` oppure `SSH`. 

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

	
2. Entrare nella directory `sw_development` tramite il comando `cd sw_development`.

3. Copiare il file `.env_example` in `.env`, ad esempio tramite il comando

```
cp .env_example .env
```

## Test iniziale ##

L'ecosistema è fornito di un piccola raccolta di programmi di test.
Per eseguirli, lanciare i seguenti comandi:

1. [Avviare i container](README_start_stop.md)

2. Lanciare il test per Python e connessione a PostgreSQL:
	```
	docker exec -it -w /home/simple_test its_dev python test.py
	```

3. [Terminare i container](README_start_stop.md)



## Configurazione iniziale ##

Se il test ha avuto successo, si raccomanda di procedere alla configurazione iniziale dell'ecosistema.

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

---------

[Home](README.md)