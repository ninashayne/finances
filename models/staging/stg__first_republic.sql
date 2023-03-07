SELECT
    DATE :: VARCHAR :: DATE AS transaction_date,
    "statement description" AS transaction_description,
    COALESCE(
        debit,
        credit
    ) * -1 AS amount,
    'first_republic' AS source_name,
    'first_republic_' || transaction_number AS pkey,
    {{ categories() }}
FROM
    {{ source(
        'fink_finances',
        'first_republic_transactions'
    ) }}
