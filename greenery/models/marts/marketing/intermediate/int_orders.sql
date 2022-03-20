{{
  config(
    materialized='table'
  )
}}

select u.user_id

, count(o.order_id) Num_Orders
, sum(o.order_cost) Total_Order_Cost
, sum(o.shipping_cost) Total_Shipping_Cost
, count(distinct o.promo_id) Num_Promos
, min(o.created_at) First_Order_Date
, max(o.created_at) Last_Order_Date
  
from {{ ref('stg_users') }} u 
join {{ ref('stg_orders') }} o on o.user_id = u.user_id
  
group by u.user_id