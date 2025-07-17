# Esecuzione di codice JavaScript con NodeJS & React #

Per eseguire l'applicazione presente nel file `USER_BASE_FOLDER/subfolder1/.../subfolderN/`, è necessario creare una nuova applicazione web corredata da un server web.

Per creare ed eseguire una nuova applicazione, sono necessari i seguenti passi:

1. Creare uno script `nodejs-run.sh` all'interno della user base folder `USER_BASE_FOLDER/subfolder1/.../subfolderN/` con il seguente contenuto: 

```bash
# Define variables require to configure the web app
APP_FOLDER=/home/subfolder1/.../subfolderN
APP_NAME=app-react
FIRST_EXPOSED_PORT=4000

# Read .bashrc to load npx and npm command
source /root/.bashrc

# Create react folder
mkdir -p ${APP_FOLDER}

# Move to react folder
pushd ${APP_FOLDER}

# Create a react webapp if not exists 
if [[ ! -d ${APP_NAME} ]]; then
	export PORT=${FIRST_EXPOSED_PORT} && npx --yes create-react-app ${APP_NAME}
fi 

# Start web application
cd ${APP_NAME}
npm start

popd
```

* `REACT_FOLDER` è il percorso assoluto in cui sono presenti le applicazioni JavaScript. Corrisponde al percorso `USER_BASE_FOLDER/subfolder1/.../subfolderN/`.

* `APP_NAME` è il nome dell'applicazione react che si vuole creare.

* `FIRST_EXPOSED_PORT` è la prima delle porte esposte, indicate nella variabile d'ambiente `NODEJS_EXPOSED_PORTS`, presente nel file `.env`

Nello script bash di esempio, il nome dell'applicazione è `app-react`, mentre la prima delle porte esposte è la `4000`.


2. Eseguire il seguente lo script bash con il seguente comanndo

```
docker exec -it -w /home/subfolder1/.../subfolderN its_dev bash nodejs-run.sh
```

Il comando `bash nodejs-run.sh` verrà eseguito all'interno del container, nella directory specificata dall'opzione `-w`.