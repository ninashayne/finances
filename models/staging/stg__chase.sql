with staging as (
select
  amount*-1 as amount
  , posting_date::date as transaction_date
  , description as transaction_description
  , 'chase_checking' as source_name
from {{ source('fink_finances', 'chase_checking_transactions') }}
where balance is not null -- when balance is null, the transaction is still pending in the checking account


union all

select
  amount *-1 as amount
  , transaction_date::date as transaction_date
  , description as transaction_description
  , 'chase_freedom' as source_name
from {{ source('fink_finances', 'chase_freedom_transactions') }}

union all

select
  amount *-1 as amount
  , transaction_date::date as transaction_date
  , description as transaction_description
  , 'chase_amazon' as source_name
from {{ source('fink_finances', 'chase_amazon_transactions') }}

union all

select
  amount *-1 as amount
  , transaction_date::date as transaction_date
  , description as transaction_description
  , 'chase_sapphire' as source_name
from {{ source('fink_finances', 'chase_sapphire_transactions') }}

)

select
  *
  , source_name || {{ dbt_utils.surrogate_key(['transaction_date','transaction_description','amount','source_name']) }} as pkey
  , {{categories()}}
from staging
