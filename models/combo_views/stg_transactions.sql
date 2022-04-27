{% for data_source in
["citi_transactions_cumulative"
, "barclay_transactions_cumulative"
, "chase_transactions_cumulative"
, "amex_transactions_cumulative"
, "discover_transactions_cumulative"
, "apple_transactions_cumulative"
, "nordstrom_transactions_cumulative"
]
%}

select
amount
, transaction_date::date as transaction_date
, transaction_description
, pkey
, case when category_l1 = 'discretionary' then category_l1 || ' - ' || category_l2
else category_l1 end as category_l1
, category_l2
, is_cancelled
, is_reimbursed_by_house

, update_dt
, source_name
from {{ source('raw_transactions', data_source) }}

{% if not loop.last %} UNION ALL {% endif %}

{% endfor %}
