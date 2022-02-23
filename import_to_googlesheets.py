

import pygsheets
import pandas as pd
import psycopg2
#authorization
gc = pygsheets.authorize(service_file='/Users/nschuchman/Desktop/repos/fink_finances/my_json_file.json')

# # connect to database
conn = psycopg2.connect("dbname='nschuchman' user='postgres' host='localhost' password='test'")

#open the google spreadsheet (where 'PY to Gsheet Test' is the name of my sheet)
sh = gc.open('dan_and_nina_transactions')

#select the first sheet 
wks = sh.worksheet('title','Transactions')


# create dataframe from query
sql = "select * from fink_finances.spending_transactions"
df = pd.read_sql(sql, conn)


wks.set_dataframe(df,(1,1))


