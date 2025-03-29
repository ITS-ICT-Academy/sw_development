import os

#import pandas as pd
# from sklearn.preprocessing import StandardScaler, LabelEncoder
# from sklearn.ensemble import RandomForestClassifier
# from sklearn.linear_model import LogisticRegression
# from sklearn.svm import SVC
# from sklearn.tree import DecisionTreeClassifier
# from sklearn.neighbors import KNeighborsClassifier
# from sklearn.naive_bayes import GaussianNB
# from sklearn.metrics import accuracy_score, classification_report
# from sklearn.model_selection import KFold

import psycopg

data_dir:str='/home/data'

if __name__ == '__main__':
	print(f"Questo programma è eseguito all'interno del container nella directory {os.getcwd()}.\n")
	print(f"La directory '{data_dir}' all'interno container contiene i seguenti file:")
	print('\n'.join( [ f' - {x}' for x in os.listdir(data_dir) ] ) )
	print("e corrisponde alla directory 'data' all'esterno del container.")

	print("\nTest della connessione a PostgreSQL:")

	with psycopg.connect("host=postgresql dbname=postgres user=postgres password=postgres") as conn:
		# Open a cursor to perform database operations
		with conn.cursor() as cur:
			# Execute a query
			cur.execute("SELECT 'Connessione riuscita!'")
			print(" - " + cur.fetchone()[0])