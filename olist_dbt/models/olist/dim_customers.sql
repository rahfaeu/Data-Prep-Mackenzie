select
    customer_unique_id
    , customer_id
    , customer_zip_code_prefix
    , customer_city
    , customer_state
from {{ source('olist_dbt', 'olist_customers_dataset') }}