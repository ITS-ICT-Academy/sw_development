import psycopg
from flask import Flask, request
from flask_restful import Resource, Api
from psycopg.rows import dict_row

app = Flask(__name__)
api = Api(app)

# Stringa di connessione al DB: devi PRIMA creare il database "libri" usando, ad es., pgadmin
DB_CONFIG = "host=postgresql dbname=libri user=postgres password=postgres"

def get_db_connection():
    # Usiamo dict_row, così ogni ennupla restituita da una query 
    # è un dizionario, e possiamo ad es., scrivere row['nome colonna']
    conn = psycopg.connect(DB_CONFIG, row_factory=dict_row)
    return conn

class Catalogo(Resource):
    def get(self, libro_id):
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                # Devi prima creare e popolare il DB per poter eseguire la query qui sotto
                # cur.execute("SELECT * FROM Libro WHERE id = %s", (libro_id,))

                # Usiamo questa per il test
                cur.execute("SELECT 'Connessione al DB riuscita!'")
                libro = cur.fetchone()
                if not libro:
                    return {"error": "Libro non trovato"}, 404
                return libro

    # definisci qui le altre funzioni che ti servono: post(), put(), delete(), etc.



# Routing
api.add_resource(Catalogo, '/catalogo/libro/<int:libro_id>')
#api.add_resource(...) # aggiungi le altre route qui

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, port=11000)



"""
Per effettuare il test:

0) Avviare l'ecosistema docker se non già avviato:

    docker compose up -d    

1) Creare il DB "libri" con pgadmin

    1.1) puntare un browser a: 127.0.0.1:11201 
         per raggiungere pgadmin (credenziali e altre istruzioni nei file 
        postgresql/README_pgadmin.md)

2) Avviare il backend tramite i seguenti passi:
    2.1) Aprire una shell bash all'interno del container its_dev

          docker exec -it its_dev bash

    2.2. Entrare nella directory che contiene app.py:

         cd sample_user_base_folder/sample-backend
    
    2.3. Avviare il backend:

         python app.py
    
    (il comando non restituisce subito il prompt; per spegnere il backend, premere CTRL+C)

3) In una shell bash della macchina host (la VM linux), eseguire:

   curl -v "http://127.0.0.1:11000/catalogo/libro/1"


Il risultato atteso è:

*   Trying 127.0.0.1:11000...
* Connected to 127.0.0.1 (127.0.0.1) port 11000
> GET /catalogo/libro/1 HTTP/1.1
> Host: 127.0.0.1:11000
> User-Agent: curl/8.7.1
> Accept: */*
> 
* Request completely sent off
< HTTP/1.1 200 OK
< Server: Werkzeug/3.1.8 Python/3.14.3
< Date: <<la data e l'ora corrente>>
< Content-Type: application/json
< Content-Length: 50
< Connection: close
< 
{
    "?column?": "Connessione al DB riuscita!"
}
* Closing connection
"""