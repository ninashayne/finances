#!/bin/zsh

mv ~/Downloads/StatementDetails.csv data/nordstrom_stg.csv
sed -i.bak "1d" data/nordstrom_stg.csv
cat data/headers/nordstrom_headers.txt data/nordstrom_stg.csv > data/nordstrom_transactions.csv
rm data/nordstrom_stg.csv
rm data/*.bak