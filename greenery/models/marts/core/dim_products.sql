{{
  config(
    materialized='table'
  )
}}

select p.product_id
, p.name Product_Name
, p.price Product_Price
, p.inventory Product_Inventory

, count(distinct oi.order_id) Num_Orders
, sum(oi.quantity) Total_Order_Quantity
, round(avg(oi.quantity), 2 ) Avg_Order_Quantity

from {{ ref('stg_products') }} p
join {{ ref('stg_order_items') }} oi on oi.product_id = p.product_id

group by p.product_id
, p.name
, p.price
, p.inventory