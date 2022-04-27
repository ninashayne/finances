#!/bin/zsh

mv ~/Downloads/Transaction.csv data/tjmaxx_stg.csv
sed -i.bak "1d" data/tjmaxx_stg.csv
cat data/headers/tjmaxx_headers.txt data/tjmaxx_stg.csv > data/tjmaxx_transactions.csv
rm data/tjmaxx_stg.csv
rm data/*.bak