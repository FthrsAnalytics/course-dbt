{{
  config(
    materialized='table'
  )
}}

select e.event_id 
, e.session_id Event_Session
, e.user_id Event_user
, e.created_at Event_Date
, e.event_type
, case 
    when order_id is null then 'Product'
    else 'Order'
  end as event_category
, u.email event_email

from {{ ref('stg_events') }} e
join {{ ref('stg_users') }} u on u.user_id = e.user_id