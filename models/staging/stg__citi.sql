select
  transaction_status
  , transaction_date::varchar::date
  , transaction_description
  , debit
  , credit
  , 'citi card' as source_name
  , coalesce(debit, credit) as amount
  , {{ dbt_utils.surrogate_key(['transaction_status','transaction_date','transaction_description','debit','credit']) }} as pkey
  , {{categories()}}
from {{ source('fink_finances', 'citi_transactions') }}
