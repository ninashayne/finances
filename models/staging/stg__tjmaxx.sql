select 
	amount as amount
	, transaction_date::date as transaction_date
	, description as transaction_description
	, 'tjmaxx_card' as source_name
	, 'tjmaxx_card' || {{ dbt_utils.surrogate_key(['transaction_date','description','reference_number','amount']) }} as pkey
    , {{categories()}}
from fink_finances.tjmaxx_transactions