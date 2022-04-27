#!/bin/zsh

control='y'
while [[ "$control" = "y" ]];do
  echo "Is there a(nother) file to upload (y/n)?"
  read control
  if [[ "$control" = "y" ]]
  then
    echo "\n\nWhich source? (amex, apple, barclay, chase, citi, discover)\n\n"
    read script_name
    echo ${script_name}
    echo "{{run_upsert('$script_name')}}" > analysis/${script_name}_upsert.sql
    source source_data/${script_name}.sh
  fi
done

dbt seed --full-refresh
dbt run -m staging
dbt compile ## this actually runs the upsert scripts, which are saved in analysis files and run queries

echo "Upload output? y/n\n\n"
read upload_output

python3 import_to_googlesheets.py

 if [[ "$upload_output" = "y" ]]
 then
   python3 import_to_googlesheets.py
 fi

rm data/*.bak

DATE=$(date +"%m-%d-%y")

pg_dump -U postgres -W -F t restored-db2 > "$DATE"_fink_finances_backup.tar
