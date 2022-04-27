select 
	amount as amount
	, transaction_date as transaction_date
	, transaction_detail as transaction_description
	, 'nordstrom_card' as source_name
	, 'nordstrom_card'|| {{ dbt_utils.surrogate_key(['transaction_date','transaction_detail','amount']) }} as pkey
    , {{categories()}}
from {{ source('fink_finances', 'nordstrom_transactions') }}

