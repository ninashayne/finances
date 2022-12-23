#!/bin/zsh

mv ~/Downloads/anntaylormastercardCreditCard.csv data/ann_taylor_stg.csv
sed -i.bak "1d" data/ann_taylor_stg.csv
cat data/headers/anntaylor_headers.txt data/ann_taylor_stg.csv > data/anntaylor_transactions.csv
rm data/ann_taylor_stg.csv
rm data/*.bak
