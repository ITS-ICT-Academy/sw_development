import os
import psycopg

if __name__ == '__main__':
	print(f"Questo programma è eseguito all'interno del container nella directory {os.getcwd()}.")
	print("\nTest della connessione a PostgreSQL:")

	with psycopg.connect("host=postgresql dbname=postgres user=postgres password=postgres") as conn:
		# Open a cursor to perform database operations
		with conn.cursor() as cur:
			# Execute a query
			cur.execute("SELECT 'Connessione riuscita!'")
			print(" - " + cur.fetchone()[0])