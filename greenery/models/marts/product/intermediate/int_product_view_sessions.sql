{{
  config(
    materialized='table'
  )
}}

select distinct e.session_id
  , e.user_id
  , e.created_at
  , e.product_id
  
  from {{ ref('stg_events') }} e
  
  where e.event_type = 'page_view'