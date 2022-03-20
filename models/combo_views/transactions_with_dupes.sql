select pkey
      , source_name
      , transaction_description
      , amount
from {{ ref('stg_transactions') }}
where pkey in (
    select pkey from {{ ref('stg_transactions') }}
    group by 1 having count(*) > 1
)
