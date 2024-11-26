create database olistdb
go
use olistdb
go

create table olist_customers_dataset (
customer_unique_id varchar(33) primary key not null OPTIONS(description="unique identifier of a customer."),
customer_id varchar(33) not null OPTIONS(description="key to the orders dataset. Each order has a unique customer_id."),
customer_zip_code_prefix varchar(5) not null OPTIONS(description="first five digits of customer zip code."),
customer_city varchar(30) not null OPTIONS(description="customer city name"),
customer_state varchar(2) not null OPTIONS(description="customer state"),
)
go

create table olist_orders_dataset (
order_id varchar(33) primary key not null OPTIONS(description="unique identifier of the order."),
customer_id varchar(33) not null OPTIONS(description="key to the customer dataset. Each order has a unique customer_id.") foreign key references olist_customers_dataset(customer_id),
order_status varchar(15) not null OPTIONS(description="customer state"),
order_purchase_timestamp datetime not null OPTIONS(description="Shows the purchase timestamp."),
order_approved_at datetime not null OPTIONS(description="Shows the payment approval timestamp."),
order_delivered_carrier_date datetime not null OPTIONS(description="Shows the order posting timestamp. When it was handled to the logistic partner."),
order_delivered_customer_date datetime not null OPTIONS(description="Shows the actual order delivery date to the customer."),
order_estimated_delivery_date datetime not null OPTIONS(description="Shows the estimated delivery date that was informed to customer at the purchase moment."),
)
go

create table olist_order_reviews_dataset (
review_id varchar(33) primary key not null OPTIONS(description="unique review identifier"),
order_id varchar(33) not null OPTIONS(description="unique order identifier") foreign key references olist_orders_dataset(order_id),
review_score int not null OPTIONS(description="Note ranging from 1 to 5 given by the customer on a satisfaction survey."),
review_comment_title varchar(300) OPTIONS(description="Comment title from the review left by the customer, in Portuguese."),
review_comment_message varchar(300) OPTIONS(description="Comment message from the review left by the customer, in Portuguese."),
review_creation_date datetime not null OPTIONS(description="Shows the date in which the satisfaction survey was sent to the customer."),
review_answer_timestamp datetime not null OPTIONS(description="Shows satisfaction survey answer timestamp."),
)
go

create table olist_order_payments_dataset (
order_id varchar(33) primary key not null foreign key references olist_orders_dataset(order_id) OPTIONS(description="unique identifier of an order."),
payment_sequential int not null OPTIONS(description="a customer may pay an order with more than one payment method. If he does so, a sequence will be created to accommodate all payments."),
payment_type varchar(33) not null OPTIONS(description="method of payment chosen by the customer."),
payment_installments int not null OPTIONS(description="number of installments chosen by the customer."),
payment_value not null money OPTIONS(description="transaction value."),
)
go
