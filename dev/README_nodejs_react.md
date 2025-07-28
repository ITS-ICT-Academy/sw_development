# Esecuzione di app web NodeJS & React #

Si ricorda che la directory della macchina host puntata dalla variabile d'ambiente `USER_BASE_FOLDER` (definita nel file `sw_development/.env`) viene montata al percorso `/home` all'interno del container.


## Creazione di una nuova app NodeJS & React ##
Assumiamo di voler creare una nuova app web basata su React, corredata da un server web, e di volerla salvare nella directory della macchina host: 
```
${USER_BASE_FOLDER}/subfolder1/.../subfolderN/
```

Questo ecosistema è preconfigurato per supportare due metodi alternativi: utilizzando il comando ufficiale di React e utilizzando la libreria esterna Vite.dev.

Procedere come segue:

1. Aprire una shell bash all'interno container `its_dev` tramite il comando:
```
docker exec -it its_dev bash
```

Si osservi come il prompt cambierà in qualcosa del tipo:
```
root@a3eb9e517663:/home#
```

indicando che ci si trova nel container di id `a3eb9e517663` e si sta impersonando l'utente `root`.


2. All'interno della shell del container, creare (se non esiste già) la directory `/subfolder1/.../subfolderN/` tramite il comando:
```
mkdir -p "/home/subfolder1/.../subfolderN/"
```

3. Entrare nella directory appena creata:
    ```
    cd "/home/subfolder1/.../subfolderN/"
    ```

4. Scegliere una porta del container libera dove esporre il webserver dell'app. 
Sebbene, in linea di principio si possa scegliere qualunque intero tra 1 e 65535 non utilizzato da altri servizi o app, questo ecosistema Docker è predisposto per dedicare alle app NodeJS & React le porte tra la 3000 e la 3099.

    **Nota**: Per utilizzare valori di porta fuori da questo intervallo, è necessario modificare la variabile `NODEJS_EXPOSED_PORTS` nel file `sw_development/.env`.


5. Scegliere se creare l'app tramite il comando ufficiale di React o tramite la libreria esterna Vite.dev e procedere con le relative istruzioni di seguito.


### Creazione app tramite il comando ufficiale di React ###

Questo approccio, sebbene sia quello ufficiale di React, comportà attese più lunghe nella costruzione e nel lancio dell'app.


6. Eseguire il seguente comando, fornito dal framework React, per creare il codice di base di una nuova app:

    ```
    export PORT=XXXX && npx --yes create-react-app "nome-app"
    ```

    Nel comando:
     * `XXXX` è la porta scelta, ad es., `3000`
     * `"nome-app"` è il nome scelto per l'app, ad es. `mia-app-react`

Il codice iniziale dell'app sarà salvato nella sottodirectory `nome-app` della directory `/home/subfolder1/.../subfolderN/`. 
Il webserver dell'app sarà configurato per essere in ascolto sulla porta `XXXX` assegnata alla variabile d'ambiente `PORT`.

7. Uscire dalla shell `bash` del container con il comando
```
exit
```


### Creazione app tramite la libreria Vite.dev ###

La libreria [Vite.dev](https://vite.dev/) permette la creazione e la compilazione più efficiente delle app.
Procedere come segue:

6. Eseguire il seguente comando fornito dalla libreria esterna Vite.dev, per creare il codice di base di una nuova app:

    ```
    npm create vite@latest "nome-app" -- --template react
    ```

    Nel comando:
     * `"nome-app"` è il nome scelto per l'app, ad es. `mia-app-react`

7. Al termine dell'esecuzione, eseguire:
    ```
    cd "nome-app" # sostituendo "nome-app" con il nome scelto per l'app
    npm install
    ```
    per finalizzare l'installazione dell'app.

8. Uscire dalla shell `bash` del container con il comando
```
exit
```

Si noti come, utilizzando Vite.dev, la porta del webserver non viene definita al momento della creazione dell'app, ma al momento del suo avvio, come mostrato di seguito.


## Avvio del webserver di una app NodeJS & React ##

Il webserver dell'app presente nella directory 
```
${USER_BASE_FOLDER}/subfolder1/.../subfolderN/nome-app/
```
della macchina host potrà essere lanciato tramite uno dei seguenti due comandi, in base alla procedura scelta per la creazione:

  * Se l'app è stata installata con il comando ufficiale di React:
    ```
    docker exec -it -w /home/subfolder1/.../subfolderN/nome-app its_dev bash -ilc "npm start"
    ```

    Il comando esegue l'eseguibile `npm` (Node Package Manager) con l'opzione `start` all'interno del container, nella directory dell'app.

    Il risultato sarà qualcosa del tipo:
    ```
    Compiled successfully!

    You can now view nome-app in the browser.

      Local:            http://localhost:XXXX
      On Your Network:  http://172.NN.NN.NN:XXXX

    Note that the development build is not optimized.
    To create a production build, use npm run build.

    webpack compiled successfully
    ```

    In dettaglio, l'eseguibile `npm` con l'opzione `start` viene eseguito come comando (`-c) da una shell bash in modalità login (`-l) ed interattiva (-i), all'interno della working directory specificata da `-w`.

    Si noti che il comando precedente non restituisce il prompt dei comandi. 



  * Se invece l'app è stata installata tramite Vite.dev:
    ```
    docker exec -it -w /home/subfolder1/.../subfolderN/nome-app its_dev bash -ilc "npm run dev -- --host --port XXXX"
    ```

    dove:
    * `XXXX` è la porta scelta, ad es., `3000`

    Il risultato sarà qualcosa del tipo:
    ```    
    VITE v7.0.6  ready in 89 ms

    ➜  Local:   http://localhost:XXXX/
    ➜  Network: http://172.20.0.3:XXXX/
    ➜  press h + enter to show help
    ```

In ogni caso, il sistema stampa in output l'indirizzo dove puntare il browser per accedere all'app: http://localhost:XXXX (dove XXXX è il numero di porta scelto).

## Spegnimento del webserver ##

Dal terminale che mostra il webserver in esecuzione: 

* Se l'app è stata installata con il comando ufficiale di React:
  * premere `control`-`c`

* Se invece l'app è stata installata tramite Vite.dev:
  * digitare `q` e poi premere il tasto `invio`

per spegnere il webserver.

---------

[Home](../README.md)
 * [Il container `dev`](./README.md)
