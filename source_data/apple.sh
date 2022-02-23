#!/bin/zsh

mv ~/Downloads/Apple\ Card*.csv data/apple_stg.csv
sed -i.bak "1d" data/apple_stg.csv
cat data/headers/apple_headers.txt data/apple_stg.csv > data/apple_transactions.csv
rm data/apple_stg.csv
rm data/*.bak
