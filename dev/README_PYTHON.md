# Esecuzione di codice Python #

Si ricorda che la directory della macchina host puntata dalla variabile d'ambiente `USER_BASE_FOLDER` (definita nel file `sw_development/.env`) viene montata al percorso `/home` all'interno del container.

Assumiamo di voler eseguire il programma Python presente nel file: 
```
	${USER_BASE_FOLDER}/subfolder1/.../subfolderN/nome_file.py
```

Basterà lanciare il seguente comando:

```
docker exec -it -w /home/subfolder1/.../subfolderN its_dev python nome_file.py [OPTIONS]
```

dove `[OPTIONS]` sono le eventuali opzioni prese in input dal proprio programma.

Il comando `python nome_file.py [OPTIONS]` verrà eseguito all'interno del container, nella directory specificata dall'opzione `-w`.

## Esempio ##
Per eseguire il programma 
```
~/Documents/its/python.1/esercizio_1.1/main.py "argomento 1" "argomento 2"
```

(con `USER_BASE_FOLDER=~/Documents/its`), basterà eseguire:

```
docker exec -it -w /home/python.1/esercizio_1.1 its_dev python main.py "argomento 1" "argomento 2"
```

---------

<button onclick="history.back()"><< Indietro</button>