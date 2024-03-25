SELECT
    transaction_date :: DATE AS transaction_date,
    transaction_description,
    amount,
    'manual' AS source_name,
    'manual' || {{ dbt_utils.surrogate_key(['transaction_date','transaction_description','amount']) }} AS pkey,
    category_l1,
    category_l2,
    is_reimbursed_by_house,
    is_cancelled,
    is_elevate_foods
FROM
    fink_finances.manual_transactions
