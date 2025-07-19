# Personalizzazione della configurazione #

Dopo aver eseguito l'[installazione e la configurazione iniziale](README_install.md), la configurazione del proprio ecosistema sarà definita in due posizioni:

* Il file `sw_development/.env` che contiene i valori per alcune variabili d'ambiente, tra cui `USER_BASE_FOLDER`

* La directory `${USER_BASE_FOLDER}/config`.


## Personalizzazione del file `sw_development/.env` ##

Questo file deve essere sempre presente nella directory `sw_development`, e **non sarà sovrascritto** in caso di [aggiornamento](README_update.md).

Permette di definire le seguenti variabili d'ambiente, che sono utilizzate dall'ecosistema Docker in fase di avvio e di utilizzo:

* `USER_BASE_FOLDER`: la directory base dove è disponibile il codice dell'utente e il resto della configurazione. Questa directory sarà montata nella posizione `/home` all'interno dei container.

* `CONFIG_PATH`: il nome della sottodirectory di `USER_BASE_FOLDER` dove è presente il resto della configurazione. Il valore di default è `config`.

* `PYTHONPATH`: il percorso assoluto della o delle directory da inserire come libreria Python nell'ambiente di sviluppo. 
Il valore di default `/home` fa in modo che Python possa accedere a librerie presenti nella directory base. È possibile indicare più percorsi, separandoli da `:`. Si veda la documentazione di Python per i dettagli.


## Personalizzazione della directory `${USER_BASE_FOLDER}/${CONFIG_PATH}`

Questa directory contiene uno o più script bash che vengono eseguiti alla creazione dei diversi container.

In particolare, lo script `XXX.sh` sarà eseguito durante la creazione del container `its_XXX`.

Questi script si prestano ad essere modificato dall'utente per installare, nei diversi container, ulteriore software.

   
---------

[Home](README.md)