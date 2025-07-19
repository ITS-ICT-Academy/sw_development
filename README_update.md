<button onclick="history.back()"><< Indietro</button>

----------------------


# Aggiornamento dell'ecosistema #

Questo ecosistema Docker è in costante aggiornamento, per seguire ed adattarsi alle necessità didattiche, via via che emergono.

Si suggerisce di consultare periodicamente la pagina web del repository per assicurarsi di possedere l'ultima versione.

Per aggiornare la versione installata localmente, procedere nel modo seguente:

1. Aprire un terminale nella cartella `sw_development`

2. Eseguire il comando `git pull` che aggiorna il codice presente nella directory con il contenuto del repository remoto

3. Ispezionare il file `.env_example` ed assicurarsi che il proprio file `.env` abbia tutto il contenuto necessario. È infatti possibile che l'aggiornamento richieda delle aggiunte al file `.env`.

4. Ispezionare i file nella directory di esempio `sample_user_base/config` ed assicurarsi che i propri file di configurazione (quelli disponibili nella directory `${USER_BASE_FOLDER}/${CONFIG_PATH}` ed eventualmente modificati durante il [processo di configurazione](README_config.md)) contengano almeno tutto quanto è riportato negli analoghi file `sample_user_base/config`. È infatti possibile che l'aggiornamento richieda aggiunte a tali file.

5. [Terminare e riavviare i container](README_start_stop.md)


---------

[Home](README.md)