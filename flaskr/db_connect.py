import MySQLdb as mariadb
from flaskr.db_credentials import host, user, pw, db

def execute_query(query,val):

	# Create database connection
	db_connection = mariadb.connect(host,user,pw,db)

	# Validate connection exists
	if db_connection is None:
		print("No connection to the database found! Have you called connect_to_database() first?")
		return None

	# Validate query isn't empty
	if query is None or len(query.strip()) == 0:
		print("query is empty! Please pass a SQL query in query")
		return None
	
	cursor = db_connection.cursor()
	cursor.execute(query, (val,))
	db_connection.commit()
	
	return cursor
