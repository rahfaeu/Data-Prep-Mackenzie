create database olistdb;

\c "olistdb";

create table olist_orders_dataset (
order_id varchar(33) primary key not null,
customer_id varchar(33),
order_status varchar(15) not null,
order_purchase_timestamp varchar(33),
order_approved_at varchar(33),
order_delivered_carrier_date varchar(33),
order_delivered_customer_date varchar(33),
order_estimated_delivery_date varchar(33)
);

comment on column olist_orders_dataset.order_id is 'unique identifier of the order';
comment on column olist_orders_dataset.customer_id is 'key to the customer dataset. Each order has a unique customer_id.';
comment on column olist_orders_dataset.order_status is 'customer state';
comment on column olist_orders_dataset.order_purchase_timestamp is 'Shows the purchase timestamp.';
comment on column olist_orders_dataset.order_approved_at is 'Shows the payment approval timestamp.';
comment on column olist_orders_dataset.order_delivered_carrier_date is 'Shows the order posting timestamp. When it was handled to the logistic partner.';
comment on column olist_orders_dataset.order_delivered_customer_date is 'Shows the actual order delivery date to the customer.';
comment on column olist_orders_dataset.order_estimated_delivery_date is 'Shows the actual order delivery date to the customer.';

create table olist_order_payments_dataset (
order_id varchar(33) not null,
payment_sequential int not null,
payment_type varchar(33) not null,
payment_installments int not null,
payment_value NUMERIC(10, 2) not null
);

comment on column olist_order_payments_dataset.order_id is 'unique identifier of an order.';
comment on column olist_order_payments_dataset.payment_sequential is 'a customer may pay an order with more than one payment method. If he does so, a sequence will be created to accommodate all payments.';
comment on column olist_order_payments_dataset.payment_type is 'method of payment chosen by the customer.';
comment on column olist_order_payments_dataset.payment_installments is 'number of installments chosen by the customer.';
comment on column olist_order_payments_dataset.payment_value is 'transaction value.';

create table olist_customers_dataset (
customer_unique_id varchar(33) not null,
customer_id varchar(33) primary key not null,
customer_zip_code_prefix varchar(5) not null,
customer_city varchar(50) not null,
customer_state varchar(2) not null
);

comment on column olist_customers_dataset.customer_unique_id is 'unique identifier of a customer.';
comment on column olist_customers_dataset.customer_id is 'key to the orders dataset. Each order has a unique customer_id.';
comment on column olist_customers_dataset.customer_zip_code_prefix is 'first five digits of customer zip code.';
comment on column olist_customers_dataset.customer_city is 'customer city name';
comment on column olist_customers_dataset.customer_state is 'customer state';

create table olist_order_reviews_dataset (
review_id varchar(33) not null,
order_id varchar(33) not null,
review_score int not null,
review_comment_title varchar(300),
review_comment_message varchar(300),
review_creation_date timestamp not null,
review_answer_timestamp timestamp not null
);

comment on column olist_order_reviews_dataset.review_id is 'unique review identifier.';
comment on column olist_order_reviews_dataset.order_id is 'unique order identifier';
comment on column olist_order_reviews_dataset.review_score is 'Note ranging from 1 to 5 given by the customer on a satisfaction survey.';
comment on column olist_order_reviews_dataset.review_comment_title is 'Comment title from the review left by the customer, in Portuguese.';
comment on column olist_order_reviews_dataset.review_comment_message is 'Comment message from the review left by the customer, in Portuguese.';
comment on column olist_order_reviews_dataset.review_creation_date is 'Shows the date in which the satisfaction survey was sent to the customer.';
comment on column olist_order_reviews_dataset.review_answer_timestamp is 'Shows satisfaction survey answer timestamp.';

create table olist_products_dataset (
product_id varchar(33) primary key not null,
product_category_name varchar(50),
product_name_lenght varchar(10),
product_description_lenght varchar(10),
product_photos_qty varchar(10),
product_weight_g varchar(10),
product_length_cm varchar(10),
product_height_cm varchar(10),
product_width_cm varchar(10)
);

comment on column olist_products_dataset.product_id is 'unique product identifier';
comment on column olist_products_dataset.product_category_name is 'root category of product, in Portuguese.';
comment on column olist_products_dataset.product_name_lenght is 'number of characters extracted from the product name.';
comment on column olist_products_dataset.product_description_lenght is 'number of characters extracted from the product description.';
comment on column olist_products_dataset.product_photos_qty is 'number of product published photos';
comment on column olist_products_dataset.product_weight_g is 'product weight measured in grams.';
comment on column olist_products_dataset.product_length_cm is 'product length measured in centimeters.';
comment on column olist_products_dataset.product_height_cm is 'product height measured in centimeters.';
comment on column olist_products_dataset.product_width_cm is 'product width measured in centimeters.';


create table olist_order_items_dataset (
order_id varchar(33) not null,
order_item_id int not null,
product_id varchar(33) not null,
seller_id varchar(33) not null,
shipping_limit_date timestamp not null,
price NUMERIC(10, 2) not null,
freight_value NUMERIC(10, 2) not null
);

comment on column olist_order_items_dataset.order_id is 'order unique identifier';
comment on column olist_order_items_dataset.order_item_id is 'sequential number identifying number of items included in the same order.';
comment on column olist_order_items_dataset.product_id is 'product unique identifier';
comment on column olist_order_items_dataset.seller_id is 'seller unique identifier';
comment on column olist_order_items_dataset.shipping_limit_date is 'Shows the seller shipping limit date for handling the order over to the logistic partner.';
comment on column olist_order_items_dataset.price is 'item price';
comment on column olist_order_items_dataset.freight_value is 'item freight value item (if an order has more than one item the freight value is splitted between items)';


create table olist_sellers_dataset (
seller_id varchar(33) primary key not null,
seller_zip_code_prefix int not null,
seller_city varchar(50) not null,
seller_state varchar(4) not null
);

comment on column olist_sellers_dataset.seller_id is 'seller unique identifier';
comment on column olist_sellers_dataset.seller_zip_code_prefix is 'first 5 digits of seller zip code';
comment on column olist_sellers_dataset.seller_city is 'seller city name';
comment on column olist_sellers_dataset.seller_state is 'seller state';

create table olist_geolocation_dataset (
geolocation_zip_code_prefix int not null,
geolocation_lat double precision not null,
geolocation_lng double precision not null,
geolocation_city varchar(50) not null,
geolocation_state varchar(4) not null
);

comment on column olist_geolocation_dataset.geolocation_zip_code_prefix is 'first 5 digits of zip code';
comment on column olist_geolocation_dataset.geolocation_lat is 'latitude';
comment on column olist_geolocation_dataset.geolocation_lng is 'longitude';
comment on column olist_geolocation_dataset.geolocation_city is 'city name';
comment on column olist_geolocation_dataset.geolocation_state is 'state';
