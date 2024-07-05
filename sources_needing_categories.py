import pandas as pd
from sqlalchemy import create_engine
from get_db_reference import db_name


# # connect to database
connection_string = 'postgresql://postgres:test@localhost:5432/'+db_name
conn = create_engine(connection_string)


sql = "select * from fink_finances.categories_needed"

df = pd.read_sql(sql,conn)

print("\n\nSources to Update:")
print(df)
print("\n\n")