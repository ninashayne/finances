#!/bin/zsh

mv ~/Downloads/*_transaction_download.csv data/capital_one_stg.csv
sed -i.bak "1d" data/capital_one_stg.csv
cat data/headers/capital_one_headers.txt data/capital_one_stg.csv > data/capital_one_transactions.csv
rm data/capital_one_stg.csv
rm data/*.bak