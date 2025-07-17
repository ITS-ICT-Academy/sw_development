# Esecuzione di codice JavaScript con NodeJS & React #

Per eseguire l'applicazione presente nel file `USER_BASE_FOLDER/subfolder1/.../subfolderN/`, è necessario creare una nuova applicazione web corredata da un server web.

I seguenti passi sono necessari per la creazione ed esecuzione di una nuova applicazione React:

1. Creare lo script `nodejs-react-run.sh` all'interno della user base folder `USER_BASE_FOLDER/subfolder1/.../subfolderN/` con il seguente contenuto: 

	```bash
	# Define variables required to configure the web app
	APP_FOLDER=/home/subfolder1/.../subfolderN
	APP_NAME=app-react
	FIRST_EXPOSED_PORT=4000

	# Read .bashrc to load npx and npm commands
	source /root/.bashrc

	# Create React folder
	mkdir -p ${APP_FOLDER}

	# Move to the react folder
	pushd ${APP_FOLDER}

	# Create a React webapp if not exist 
	if [[ ! -d ${APP_NAME} ]]; then
		export PORT=${FIRST_EXPOSED_PORT} && npx --yes create-react-app ${APP_NAME}
	fi 

	# Start web application
	cd ${APP_NAME}
	npm start

	popd
	```

    dove:

    * `REACT_FOLDER` è il percorso assoluto in cui sono presenti le applicazioni JavaScript. Corrisponde al percorso `USER_BASE_FOLDER/subfolder1/.../subfolderN/`.

    * `APP_NAME` è il nome dell'applicazione React che si vuole creare.

    * `FIRST_EXPOSED_PORT` è la prima delle porte esposte, indicate nella variabile d'ambiente `NODEJS_EXPOSED_PORTS` nel file `.env`

    Nello script bash di esempio, il nome dell'applicazione è `app-react`, mentre la prima delle porte esposte è la `4000`.


2. Eseguire lo script bash `nodejs-react-run.sh` con il seguente comando

    ```
    docker exec -it -w /home/subfolder1/.../subfolderN its_dev bash nodejs-run.sh
    ```

    Il comando `bash nodejs-react-run.sh` verrà eseguito all'interno del container, nella directory specificata dall'opzione `-w`.
