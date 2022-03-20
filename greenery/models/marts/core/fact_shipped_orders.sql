{{
  config(
    materialized='table'
  )
}}

select o.order_id
, o.user_id
, o.created_at
, o.shipping_service
, o.order_total

, p.promo_id
, p.status promo_status
, p.discount promo_discount

from {{ ref('stg_orders') }} o
join {{ ref('stg_promos') }} p on p.promo_id = o.promo_id

where o.status = 'delivered' or o. status = 'shipped'