SELECT
    DATE_TRUNC(
        'month',
        transaction_date :: DATE
    ) :: DATE AS transaction_month,
    case when category_l1 = 'house fund contribution' then amount / 2 else amount end as "amount",
    "transaction_date",
    "transaction_description",
    "pkey",
    "category_l1",
    "category_l2",
    "is_cancelled",
    "is_reimbursed_by_house",
    "is_elevate_foods",
    "update_dt",
    "source_name",
    MAX(update_dt) over (
        PARTITION BY source_name
    ) AS source_latest_update_dt,
    NOT(COALESCE(category_l1, 'null') IN ('transfer', 'credit', 'betterment', 'income', 'payment', 'refund', 'reimbursement', 'water bill', 'fee')) AS spending_transaction_flag,
    MAX(transaction_date) over (
        PARTITION BY source_name
    ) AS latest_transaction
FROM
    {{ ref('stg_transactions') }}
