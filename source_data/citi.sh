#!/bin/zsh

mv ~/Downloads/Statement*.CSV data/citi_stg.csv
mv ~/Downloads/Since*.CSV data/citi_stg.csv
sed -i.bak "1d" data/citi_stg.csv
cat data/headers/citi_headers.txt data/citi_stg.csv > data/citi_transactions.csv
rm data/citi_stg.csv
