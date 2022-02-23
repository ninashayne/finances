select *
, 'discover' as source_name
, {{ dbt_utils.surrogate_key(['transaction_date','transaction_description','amount']) }} as pkey
, {{categories()}}

from {{ source('fink_finances', 'discover_transactions') }}
