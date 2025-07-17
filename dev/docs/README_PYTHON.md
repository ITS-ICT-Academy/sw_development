# Esecuzione di codice Python #

Per eseguire il programma Python presente nel file `USER_BASE_FOLDER/subfolder1/.../subfolderN/nome_file.py`, basterà lanciare il seguente comando:

```
docker exec -it -w /home/subfolder1/.../subfolderN its_dev python nome_file.py [OPTIONS]
```

sostituendo a `nome_file.py` il nome del file Python che si vuole eseguire, ed aggiungere eventuali opzioni da riga di comando.

Il comando `python nome_file.py [OPTIONS]` verrà eseguito all'interno del container, nella directory specificata dall'opzione `-w`.

Continuando con l'esempio precedente, per eseguire il programma `~/Documents/its/python.1/esercizio_1.1/main.py` (con `USER_BASE_FOLDER=~/Documents/its`), basterà eseguire:

```
docker exec -it -w /home/python.1/esercizio_1.1 its_dev python main.py [OPTIONS]
```