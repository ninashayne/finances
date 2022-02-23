select date_trunc('month', transaction_date::date)::date as transaction_month
     , case when category_l1 = 'discretionary' then category_l1 || ' - ' || category_l2
     else category_l1 end as category
     , sum(amount)
from {{ ref('spending_transactions') }}
group by 1, 2
