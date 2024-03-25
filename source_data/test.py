import pygsheets

#authorization
gc = pygsheets.authorize(service_file='/Users/ninafink/Desktop/nina_personal/finances/my_json_file.json')

# open the google spreadsheet (where 'PY to Gsheet Test' is the name of my sheet)
sh = gc.open('dan_and_nina_transactions')

#select the first sheet
wks = sh.worksheet('title','Manual Transactions')

wks.export(filename='data/manual_transactions')
print("csv downloaded")

