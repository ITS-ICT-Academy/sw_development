# Il container `its_dev` #

Il container `its_dev` è basato su una distribuzione linux (si veda il relativo [`Dockerfile`](Dockerfile)) e contiene un ambiente di sviluppo per eseguire programmi in diversi linguaggi di programmazione.


### Lo script `${USER_BASE_FOLDER}/${CONFIG_PATH}/dev.sh` ###

Come spiegato nella sezione [Personalizzazione della configurazione](../README_config.md), lo script `dev.sh` presente nella directory `${USER_BASE_FOLDER}/${CONFIG_PATH}` viene eseguito alla creazione del container `its_dev`.

Nella sua versione di default, si occupa di:

* Installare l'interprete Python (nella versione lì specifiata) con le librerie (e versioni) elencate nel file `${USER_BASE_FOLDER}/${CONFIG_PATH}/python_requirements.txt`.

* Installare l'ambiente di sviluppo NodeJS & React (nelle versioni lì specificate) per la creazione e lo sviluppo di applicazioni web.



## Estensione e configurazione ##
L'ambiente di sviluppo può essere esteso dall'utente modificando lo script `dev.sh`, che è un normale script `bash`. 
È quindi possibile installare interpreti o compilatori per ulteriori linguaggi di programmazione, ed altri framework e librerie.



## Guide dettagliate ##
Sono disponibili guide dettagliate per eseguire programmi nei diversi linguaggi pre-installati:

* [Eseguire codice Python](./README_python.md) 
* [Eseguire app web Javascript con NodeJS & React](./README_nodejs_react.md) 


---------

[Home](../README.md)