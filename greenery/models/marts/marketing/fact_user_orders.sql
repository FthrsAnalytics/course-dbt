{{
  config(
    materialized='table'
  )
}}

select u.user_id
, concat(u.first_name, ' ', u.last_name) UserName
, u.email
, u.phone_number

, a.address
, a.zipcode --test zip code is five characters long
, a.state
, a.country

, o.Num_Orders
, CASE
    WHEN o.Num_Orders > 2 THEN 'Cool User'
    WHEN o.Num_Orders > 1 THEN 'Repeat User'
    ELSE 'Uncool User'
  END AS User_Order_Status
, o.Total_Order_Cost
, o.Total_Shipping_Cost
, o.Num_Promos
, o.First_Order_Date
, o.Last_Order_Date

from {{ ref('int_orders') }} o 
join {{ ref('stg_users') }} u on u.user_id = o.user_id
join {{ ref('stg_addresses') }} a on a.address_id = u.address_id