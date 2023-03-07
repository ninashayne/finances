#!/bin/zsh

mv ~/Downloads/AccountHistory.csv data/first_republic_stg.csv
sed -i.bak "1d" data/first_republic_stg.csv
cat data/headers/first_republic_headers.txt data/first_republic_stg.csv > data/first_republic_transactions.csv
rm data/first_republic_stg.csv
rm data/*.bak
