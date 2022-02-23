#!/bin/zsh
echo "which card? barclay or jetblue?"

read barclay_card_type

echo ${barclay_card_type}_stg


mv ~/Downloads/CreditCard*.csv data/${barclay_card_type}_stg.csv
sed -i.bak "1,5d" data/${barclay_card_type}_stg.csv
cat data/headers/barclay_headers.txt data/${barclay_card_type}_stg.csv > data/${barclay_card_type}_transactions.csv
rm data/${barclay_card_type}_stg.csv
