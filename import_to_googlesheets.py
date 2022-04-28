

import pygsheets
import pandas as pd
from sqlalchemy import create_engine

#authorization
gc = pygsheets.authorize(service_file='/Users/ninafink/Desktop/nina_personal/finances/my_json_file.json')


# # connect to database
connection_string = 'postgresql://postgres:test@localhost:5432/restored-db2'
conn = create_engine(connection_string)



# open the google spreadsheet (where 'PY to Gsheet Test' is the name of my sheet)
sh = gc.open('dan_and_nina_transactions')

#select the first sheet
wks = sh.worksheet('title','Transactions')


# create dataframe from query
sql = "select * from fink_finances.spending_transactions"
df = pd.read_sql_query(sql, conn)


wks.set_dataframe(df,(1,1))


dupes = sh.worksheet('title','dupes')

sql = "select * from fink_finances.transactions_with_dupes"

df = pd.read_sql(sql,conn)
dupes.set_dataframe(df,(1,1))
