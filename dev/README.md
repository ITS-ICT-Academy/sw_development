# Il container `its_dev` #

Il container `its_dev` è basato su una distribuzione linux (si veda il relativo [`Dockerfile`](Dockerfile)) e contiene un ambiente di sviluppo per eseguire programmi in diversi linguaggi di programmazione.


### Lo script `${USER_BASE_FOLDER}/${CONFIG_PATH}/dev/main.sh` ###

Come spiegato nella sezione [Configurazione](../README_config.md), lo script `main.sh` presente nella directory `${USER_BASE_FOLDER}/${CONFIG_PATH}/dev` viene eseguito alla creazione del container `its_dev`.

Nella sua versione di default, si occupa di eseguire gli ulteriori script `.sh` il cui nome inizia per un numero, nel loro ordine (`01-base-packages.sh`, `02-python.sh`, etc.)
A loro volta, ognuno di questi script installa e configura un unico tool, ovvero:

* `01-base-packages.sh` installa alcuni pacchetti di uso comune

* `02-python.sh`: 
	* installa [`pyenv`](https://github.com/pyenv/pyenv), un tool che permette di installare e configurare una o più versioni dell'interprete Python
	* installa, tramite `pyenv`, una specifica versione di Python (si veda lo script per conoscere la versione esatta) e la contrassegna come versione di default
	* installa, per la versione di Python di cui sopra, le librerie elencate nel file `${USER_BASE_FOLDER}/${CONFIG_PATH}/dev/python_requirements.txt`.

* `03-node-react.sh`: installa l'ambiente di sviluppo NodeJS & React (nelle versioni lì specificate) per la creazione e lo sviluppo di applicazioni web.


## Estensione e configurazione ##
L'ambiente di sviluppo può essere esteso dall'utente modificando gli script `bash` presenti nella directory `${USER_BASE_FOLDER}/${CONFIG_PATH}/dev/` o aggiungendone di nuovi. 
È quindi possibile installare interpreti o compilatori per ulteriori linguaggi di programmazione, ed altri framework e librerie.

Come esempio, [mostriamo la possibile installazione di JupyterLab](./README_jupyter.md), un ambiente per la programmazione interattiva. La particolarità dell'ambiente è che prevede l'installazione di un server web all'interno del container, che dovrà essere accessibile dal sistema operativo host.



## Guide dettagliate ##
Sono disponibili guide dettagliate per eseguire programmi nei diversi linguaggi pre-installati:

* [Eseguire codice Python](./README_python.md) 
* [Eseguire app web Javascript con NodeJS & React](./README_nodejs_react.md) 


---------

[Home](../README.md)