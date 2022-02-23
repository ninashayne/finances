#!/bin/zsh

mv ~/Downloads/activity.csv data/amex_stg.csv
sed -i.bak "1d" data/amex_stg.csv
cat data/headers/amex_headers.txt data/amex_stg.csv > data/amex_transactions.csv
rm data/amex_stg.csv
rm data/*.bak
