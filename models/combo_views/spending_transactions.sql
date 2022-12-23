select date_trunc('month', transaction_date::date)::date as transaction_month
, *

, max(update_dt) over (partition by source_name) as source_latest_update_dt
, NOT(coalesce(category_l1,'null') in ('trasnfer', 'transfer', 'credit', 'betterment', 'income', 'payment', 'refund', 'reimbursement', 'water bill', 'fee')) as spending_transaction_flag
, max(transaction_date) over (partition by source_name) as latest_transaction
from {{ ref('stg_transactions') }}
{# where not coalesce(is_reimbursed_by_house, False)
and not coalesce(is_cancelled, false)
and (category_l1 not in ('payment','income','transfer', 'fee') or category_l1 is null) #}
