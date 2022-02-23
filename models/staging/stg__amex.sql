select
  date::varchar::date as transaction_date
  , description as transaction_description
  , card_member
  , account_number
  , amount as amount
  , 'amex' as source_name
  , {{ dbt_utils.surrogate_key(['date','description','card_member','account_number','amount']) }} as pkey
  , {{categories()}}
from {{ source('fink_finances', 'amex_transactions') }}
