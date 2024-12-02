{{ config(materialized='table', unlogged=True) }}

select
    orders.order_id
    , orders.customer_id
    , orders.order_status
    , orders.order_purchase_timestamp
    , orders.order_approved_at
    , orders.order_delivered_carrier_date
    , orders.order_delivered_customer_date
    , orders.order_estimated_delivery_date
    , items.order_item_id
    , items.product_id
    , items.seller_id
    , items.shipping_limit_date
    , items.price
    , items.freight_value
from {{ ref('stg_olist_orders_dataset') }} as orders
left join {{ ref('stg_olist_order_items_dataset') }} as items
    on orders.order_id = items.order_id