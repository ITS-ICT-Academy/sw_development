# Installazione di Jupyter Lab nel container `its_dev` #

[Jupyter Lab](https://jupyter.org/) è un ambiente per lo sviluppo interattivo di codice Python, molto utilizzato in ambito Data Science.

Dato che l'installazione avviene come un pacchetto Python da PyPI, bisognerà procedere a modificare il file `${USER_BASE_FOLDER}/${CONFIG_PATH}/dev/python_requirements.txt` ed aggiungere, alla lista dei pacchetti Python da installare, `jupyterlab==<versione>`.

Questo è un esempio del contenuto del file a valle della modifica.

`${USER_BASE_FOLDER}/${CONFIG_PATH}/dev/python_requirements.txt`:
```
# Add here the list of Python libraries you want to install from PyPI

psycopg[binary]==3.2.6  # Driver Python per PostgreSQL
beartype==0.20.2
jupyterlab==4.4.10
```

Si noti che è stato dichiarato di voler installare la versione 4.4.10, che è la versione corrente al momento della scrittura di questo tutorial. Sebbene l'indicazione della versione possa essere omessa (e quindi scrivere solo `jupyterlab`), questa non è una buona pratica. 
Difatti, omettere la versione equivale ad installare sempre l'ultima versione disponibile (al momento dell'avvio del container, se viene data l'opzione `--build` al comando `docker compose up`), e questo può rendere il software dell'utente scritto in passato non più eseguibile, a causa di incompatibilità non note con la nuova versione.

## Configurazione di Jupyter ##

Jupyter è installato, ma va configurato opportunamente affinché il suo webserver sia accessibile dal browser della macchina host.

All'avvio, Jupyter legge un file di configurazione (che è un semplice programma Python che assegna valori ad alcune variabili). 
Jupyter cerca il proprio file di configurazione nella directory puntata dalla variabile d'ambiente `JUPYTER_CONFIG_DIR`.

Dobbiamo quindi fare in modo che, all'avvio di ogni shell `bash` del container `its_dev`, la variabile d'ambiente `JUPYTER_CONFIG_DIR` sia impostata alla directory dove vogliamo salvare il file di configurazione di Jupyter. 
Nel seguito, tale directory sarà impostata alla directory `${CONFIG_PATH}/dev`, ovvero la stessa dove si trovano gli altri file di configurazione dell'immagine `its_dev`. 
Ricordiamo che tale directory è accessibile, all'interno del container, al percorso `/home/${CONFIG_PATH}/dev`.

Per fare ciò. creiamo dunque il file `04-jupyter.sh` nella directory `${USER_BASE_FOLDER}/${CONFIG_PATH}/dev` con il seguente contenuto:

```
#!/bin/bash

# Append the following code to the RC_FILE
cat << EOF >> "/root/.bashrc"
	export JUPYTER_CONFIG_DIR=/home/${CONFIG_PATH}/dev
EOF
```

Questo script `bash` verrà eseguito durante la creazione dell'immagine del container `its_dev`, e aggiungerà il comando `export JUPYTER_CONFIG_DIR=/home/${CONFIG_PATH}/dev` al file `/root/.bashrc` all'interno del container. 
Ricordiamo che il file `.bashrc` viene eseguito all'avvio della shell `bash`.
Il comando `export` definisce una variabile d'ambiente nella shell di nome `JUPYTER_CONFIG_DIR` e di valore `/home/${CONFIG_PATH}/dev`.

Osserviamo che il file di configurazione di Jupyter non è ancora presente nella directory scelta. Potremmo generarne uno a mano rispettando la sintassi richiesta, ma Jupyter permette un approccio più semplice: permette infatti di generare, proprio nella directory `JUPYTER_CONFIG_DIR`, un file di configurazione di default, che potremo quindi modificare a nostro piacimento.

Per generare il file di configurazione, dovremo eseguire un comando apposito di Jupyter. Per farlo, dobbiamo prima creare le nuove immagini dei container dell'ecosistema Docker (che avranno anche Jupyter installato).

Quindi, [terminiamo (se dovesse essere avviato) e riavviamo](../README_start_stop.md) l'ecosistema Docker.

Successivamente, entriamo in una shell `bash` nel container `its_dev` con 
```
	docker exec -it its_dev bash
```

Al prompt di `bash` lanciamo il comando

```
	jupyter server --generate-config
```

Nella directory `${USER_BASE_FOLDER}/${CONFIG_PATH}/dev` della macchina host (che è montata al percorso `JUPYTER_CONFIG_DIR` all'interno del container) troveremo il nuovo file `jupyter_server_config.py`, che possiamo procedere a modificare in tutta comodità con un qualunque editor di testo.

Il file è molto lungo, ed è composto interamente di commenti! 
L'idea è che solo le righe di codice che definiscono le variabili di configurazione di cui vogliamo personalizzare il valore vanno abilitate.

Dovremo operare le seguenti personalizzazioni:

1. Abilitare la possibilità per l'utente root (utente di default del container) di avviare Jupyter. Questo è disabilitato per default, in quanto, in un ambiente non basato su Docker, sarebbe molto pericoloso eseguire codice Python come utente `root`.

```
	## Whether to allow the user to run the server as root.
	#  Default: False
	# c.ServerApp.allow_root = False
	c.ServerApp.allow_root = True
```

2. Abilitare la possibilità, per il webserver di Jupyter, di accettare connessioni da qualunque IP. Per motivi di sicurezza, infatti, Jupyter accetta per default solo connessioni da `localhost`. In un ambiente Docker tuttavia, dobbiamo fare in modo che accetti connessioni almeno dalla macchina host (`localhost` è il container stesso, e noi vogliamo utilizzare un browser della macchina host). L'uso di `0.0.0.0` permette l'accesso libero.

```
	## The IP address the Jupyter server will listen on.
	#  Default: 'localhost'
	# c.ServerApp.ip = 'localhost'
	c.ServerApp.ip = '0.0.0.0'
```

3. Definire la porta del container sulla quale il webserver di Jupyter è in ascolto per ricevere connessioni. Tale porta non deve essere già utilizzata da un altro servizio che esegue nel container `its_dev`, e deve anche essere esposta dall'ecosistema Docker alla macchina host, altrimenti non sarebbe accessibile da quest'ultima.

	L'ecosistema Docker (si veda il file `.env` ottenuto duplicando `.env_example`), definisce un intervallo di porte chiamato `AUTO_MAPPED_PORTS` (dalla 10000 alla 10099).
	Tali porte vengono automaticamente esposte all host.

	Per Jupyter, dobbiamo scegliere quindi una porta (non utilizzata né nel container né nell host) in quell'intervallo. Decidiamo di usare la porta `10000`.

	```
		## The port the server will listen on (env: JUPYTER_PORT).
		#  Default: 0
		c.ServerApp.port = 10000
	```

La configurazione è terminata.



# Esecuzione di Jupyter Lab 

Siamo ora pronti ad avviare il server di Jupyter Lab.
Da una shell `bash`, basterà eseguire:

```
	jupyter lab
```

Il programma ci darà un output del tipo:

```
jupyter lab        
[I 2025-11-02 14:16:22.281 ServerApp] jupyter_lsp | extension was successfully linked.
[I 2025-11-02 14:16:22.282 ServerApp] jupyter_server_terminals | extension was successfully linked.
[I 2025-11-02 14:16:22.284 ServerApp] jupyterlab | extension was successfully linked.
[I 2025-11-02 14:16:22.368 ServerApp] notebook_shim | extension was successfully linked.
[I 2025-11-02 14:16:22.374 ServerApp] notebook_shim | extension was successfully loaded.
[I 2025-11-02 14:16:22.375 ServerApp] jupyter_lsp | extension was successfully loaded.
[I 2025-11-02 14:16:22.375 ServerApp] jupyter_server_terminals | extension was successfully loaded.
[I 2025-11-02 14:16:22.376 LabApp] JupyterLab extension loaded from /root/.pyenv/versions/3.13.5/lib/python3.13/site-packages/jupyterlab
[I 2025-11-02 14:16:22.376 LabApp] JupyterLab application directory is /root/.pyenv/versions/3.13.5/share/jupyter/lab
[I 2025-11-02 14:16:22.376 LabApp] Extension Manager is 'pypi'.
[I 2025-11-02 14:16:22.396 ServerApp] jupyterlab | extension was successfully loaded.
[I 2025-11-02 14:16:22.397 ServerApp] Serving notebooks from local directory: /home
[I 2025-11-02 14:16:22.397 ServerApp] Jupyter Server 2.17.0 is running at:
[I 2025-11-02 14:16:22.397 ServerApp] http://b9afd302e756:10000/lab?token=22a1f06f3dd9573e1114afb731014d44d62a19c5b6e67bc7
[I 2025-11-02 14:16:22.397 ServerApp]     http://127.0.0.1:10000/lab?token=22a1f06f3dd9573e1114afb731014d44d62a19c5b6e67bc7
[I 2025-11-02 14:16:22.397 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[W 2025-11-02 14:16:22.399 ServerApp] No web browser found: Error('could not locate runnable browser').
[C 2025-11-02 14:16:22.399 ServerApp] 
    
    To access the server, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/jpserver-782-open.html
    Or copy and paste one of these URLs:
        http://b9afd302e756:10000/lab?token=22a1f06f3dd9573e1114afb731014d44d62a19c5b6e67bc7
        http://127.0.0.1:10000/lab?token=22a1f06f3dd9573e1114afb731014d44d62a19c5b6e67bc7
```

In particolare, l'ultima riga `http://127.0.0.1:10000/lab?...` è la URL che dovremo inserire in un browser che esegue sull'host per accedere al webserver di Jupyter (si ricorda che `127.0.0.1` è l'indirizzo IP che denota la macchina locale, esattamente come `localhost`).