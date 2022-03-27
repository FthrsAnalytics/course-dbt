{{
  config(
    materialized='table'
  )
}}  
  
  select distinct e.session_id
  , e.user_id
  , e.created_at
  , o.product_id
  
  from {{ ref('stg_events') }} e
  inner join {{ ref('stg_order_items') }} o on o.order_id = e.order_id
  
  where e.event_type = 'checkout'