{% macro upsert_table(source_name) %}
create table if not exists raw_transactions.{{source_name}}_transactions_cumulative as

select
amount
, transaction_date
, transaction_description
, pkey
, category_l1
, category_l2
, is_cancelled
, is_reimbursed_by_house
, source_name
, current_timestamp as update_dt
from fink_finances.stg__{{source_name}};

insert into raw_transactions.{{source_name}}_transactions_cumulative

select amount
, transaction_date
, transaction_description
, pkey
, category_l1
, category_l2
, is_cancelled
, is_reimbursed_by_house
, source_name
, current_timestamp
from fink_finances.stg__{{source_name}}
where pkey not in (select pkey from raw_transactions.{{source_name}}_transactions_cumulative);

commit;

{% endmacro %}
