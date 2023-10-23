WITH base AS (
  SELECT
    transaction_date :: VARCHAR :: DATE AS transaction_date,
    description AS transaction_description,
    card_no AS card_number,
    COALESCE(
      debit,
      credit * -1
    ) AS amount,
    'capital_one' AS source_name
  FROM
    {{ source(
      'fink_finances',
      'capital_one_transactions'
    ) }}
)
SELECT
  *,
  'capital_one' || {{ dbt_utils.surrogate_key(['transaction_date','transaction_description','card_number', 'amount']) }} AS pkey,
  {{ categories() }}
FROM
  base
