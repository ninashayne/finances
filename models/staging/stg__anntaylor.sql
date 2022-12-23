SELECT
    DATE :: DATE AS transaction_date,
    description AS transaction_description,
    location AS transaction_location,
    CASE
        WHEN category = 'Payment' THEN amount * -1
        ELSE amount
    END AS amount,
    'anntaylor_mastercard' AS source_name,
    'anntaylor' || {{ dbt_utils.surrogate_key(['date','description','location','category','amount']) }} AS pkey,
    {{ categories() }}
FROM
    {{ source(
        'fink_finances',
        'anntaylor_transactions'
    ) }}
