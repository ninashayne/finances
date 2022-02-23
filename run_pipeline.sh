#!/bin/zsh
echo "\n\nWhich source? (amex, barclay, chase, citi, discover)\n\n"
read script_name
echo ${script_name}
echo "{{upsert_table('$script_name')}}" > analysis/${script_name}_upsert.sql

source source_data/${script_name}.sh

dbt seed --full-refresh
rm data/*.bak


dbt run -m staging

dbt compile
echo ${script_name}
python3 transaction_raw_upsert.py ${script_name}_upsert



echo "Upload output? y/n\n\n"
read upload_output

if [[ "$upload_output" = "y" ]]
then
  python3 import_to_googlesheets.py
fi
