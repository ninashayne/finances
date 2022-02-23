#!/bin/zsh

mv ~/Downloads/Discover-Statement*.csv data/discover_stg.csv
sed -i.bak "1d" data/discover_stg.csv
cat data/headers/discover_headers.txt data/discover_stg.csv > data/discover_transactions.csv
rm data/discover_stg.csv
