#!/bin/zsh

echo "which Account? checking, amazon, freedom, sapphire\n\n"

read chase_account_type
echo ${chase_account_type}


mv ~/Downloads/Chase*.CSV data/chase_${chase_account_type}_stg.csv
sed -i.bak "1d" data/chase_${chase_account_type}_stg.csv





if [[ "$chase_account_type" = "checking" ]]
then
  echo "this is a checking account"
  cat data/headers/chase_checking_headers.txt data/chase_${chase_account_type}_stg.csv > data/chase_${chase_account_type}_transactions.csv
else
  echo "'this is a credit card account'"
  cat data/headers/chase_headers.txt data/chase_${chase_account_type}_stg.csv > data/chase_${chase_account_type}_transactions.csv

fi


echo data/chase_${chase_account_type}_transactions.csv
rm data/chase_${chase_account_type}_stg.csv
