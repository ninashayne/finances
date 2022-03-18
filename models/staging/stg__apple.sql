select amount
     , transaction_date
     , description as transaction_description
     , 'apple card' as source_name
     , 'apple card' || {{ dbt_utils.surrogate_key(['transaction_date','description','amount']) }} as pkey
     , {{categories()}}
from {{ source('fink_finances', 'apple_transactions') }}
where description != 'DAILY CASH ADJUSTMENT'
