#!/bin/zsh
echo "\n\nWhich source? (amex, apple, barclay, chase, citi, discover)\n\n"
read script_name
echo ${script_name}
echo "{{upsert_table('$script_name')}}" > analysis/${script_name}_upsert.sql

source source_data/${script_name}.sh


# Insert while loop here to upload all of the .csv files #

dbt seed --full-refresh
dbt run -m staging
dbt compile

# echo "Upload output? y/n\n\n"
# read upload_output
#
# if [[ "$upload_output" = "y" ]]
# then
#   python3 import_to_googlesheets.py
# fi
#
rm data/*.bak
