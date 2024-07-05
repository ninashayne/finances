#!/bin/zsh

cwd=$(pwd)


cd /Users/ninafink/Desktop/nina_personal/finances


control='y'
while [[ "$control" = "y" ]];do
  echo "Is there a(nother) file to upload (y/n)?"
  read control
  if [[ "$control" = "y" ]]
  then
    echo "\n\nWhich source? (amex, anntaylor, apple, barclay, capital_one, chase, citi, discover, manual, nordstrom)\n\n"
    read script_name
    echo ${script_name}
    echo "{{run_upsert('$script_name')}}" > analysis/${script_name}_upsert.sql
    source source_data/${script_name}.sh
  fi
done


echo "Run dbt? y/n\n\n"
read run_dbt

if [[ "$run_dbt" = "y" ]]
then
  dbt clean
  dbt deps
  echo "dbt seed --full-refresh"
  dbt seed --full-refresh
  echo "dbt run -m staging"
  dbt run -m staging
  echo "dbt compile -- upsert scripts outside of standard dbt framework"
  dbt compile ## this actually runs the upsert scripts, which are saved in analysis files and run queries
  # rm -r analysis
  # mkdir analysis
fi

python3 sources_needing_categories.py

control='y'
while [[ "$control" = "y" ]];do
  echo "Check categories again (y/n)?"
  read control
  if [[ "$control" = "y" ]]
  then
    python3 sources_needing_categories.py
  fi
  echo ""
done

echo "Upload output? y/n\n\n"
read upload_output



 if [[ "$upload_output" = "y" ]]
 then
   python3 import_to_googlesheets.py
 fi

rm data/*.bak

DATE=$(date +"%m-%d-%y")
DB=$(python3 get_db_reference.py)

echo "$DB"

rm -r backups
mkdir backups
pg_dump -U postgres -W -F t "$DB" > backups/"$DATE"_fink_finances_backup.tar

cd $cwd
