import os
import psycopg

if __name__ == '__main__':
	print(f"Questo programma è eseguito all'interno del container")
	print(f"La directory corrente è {os.getcwd()}.")
	print("Test della connessione a PostgreSQL:")

	with psycopg.connect("host=postgresql dbname=postgres user=postgres password=postgres") as conn:
		# Open a cursor to perform database operations
		with conn.cursor() as cur:
			# Execute a query
			cur.execute("SELECT 'Connessione riuscita!'")
			print(" - " + cur.fetchone()[0])