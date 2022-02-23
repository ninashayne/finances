import psycopg2
import sys

file_name = sys.argv[1]

upsert_script = "target/compiled/my_new_project/analysis/"+file_name+".sql"
print(upsert_script)
conn = psycopg2.connect("dbname='nschuchman' user='postgres' host='localhost' password='test'")
cursor = conn.cursor()

with open(upsert_script,'r') as file:
    query = file.read()

cursor.execute(query)
print("Successfully ran upsert script")
