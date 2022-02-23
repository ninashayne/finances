select date_trunc('month', transaction_date::date)::date as transaction_month
     , sum(amount)
from {{ ref('spending_transactions') }}
group by 1
