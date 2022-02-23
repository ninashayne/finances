with transactions as (
select
transaction_date::date as transaction_date
, description as transaction_description
, amount *-1 as amount
, category as transaction_type
, 'jet blue' as source_name
from {{ source('fink_finances', 'jetblue_transactions') }}

union all

select
transaction_date::date as transaction_date
, description as transaction_description
, amount *-1 as amount
, category as transaction_type
, 'barclay card' as source_name
from {{ source('fink_finances', 'barclay_transactions') }}
)

select
  *
  , {{ dbt_utils.surrogate_key(['transaction_date','transaction_description','amount','source_name']) }} as pkey
  , {{categories()}}
from transactions
