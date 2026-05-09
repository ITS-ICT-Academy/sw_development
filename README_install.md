# Prima installazione #

## Installazione ##
1. Clonare il repository in una directory locale in. modalità `HTTPS` oppure `SSH`. 

 * **Modalità `HTTPS`**: 
 	Aprire il terminale in una directory all'interno della quale si vuole clonare il repository, ed eseguire il comando:

	```
	git clone https://github.com/ITS-ICT-Academy/sw_development.git 
	```

	Il repository sarà clonato in una sottodirectory `sw_development` della directory scelta.

 * **Modalità `SSH`**:
	La modalità `SSH` è pensata per un utilizzo ripetuto. Per essere utilizzata, è necessario salvare la chiave pubblica `SSH` dell'utente corrente della macchina locale nella piattaforma GIT su web.

	Una volta salvate la propria chiave pubblica `SSH`, procedere come sopra, ma utilizzando il comando seguente:

	```
	git clone git@github.com:ITS-ICT-Academy/sw_development.git 
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
	docker exec -it its_dev bash
	cd simple_test
	python test.py
	```

3. [Terminare i container](README_start_stop.md)

---------

[Home](README.md)
