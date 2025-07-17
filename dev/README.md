# Container `dev` #

Il container `dev` contiene un ambiente di sviluppo per eseguire programmi in diversi linguaggi di programmazione.

In particolare, il container è già configurato con:

* L'interprete Python, che viene installato con le librerie (e versioni) elencate nel file `dev/python_requirements.txt`.
* L'ambiente di sviluppo NodeJS & ReactJS per la creazione e sviluppo di applicazioni web.

## Estensione e configurazione ##
L'ambiente di sviluppo può essere esteso dall'utente agendo nel file `dev.sh` presente nella directory di configurazione `${USER_BASE_FOLDER}/${CONFIG_PATH}`.
Questo è uno script `bash` che viene eseguito al momento della creazione (`build`) del container.


## Guide dettagliate ##
Sono disponibili guide dettagliate per eseguire programmi nei diversi linguaggi pre-installati:
* Python: [`./README_PYTHON.md`](./README_PYTHON.md) 
* Javascript con NodeJS & ReactJS: [`./README_NODEJS_REACT.md`](./README_NODEJS_REACT.md) 

------

[Torna su](../README.md)