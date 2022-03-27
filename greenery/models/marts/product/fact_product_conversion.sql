{{
  config(
    materialized='table'
  )
}}

with product_names as (
  select
  {{ dbt_utils.star(ref('stg_products')) }}
from {{ ref('stg_products') }}
  
),

purchases_by_product as (
  
  select ps.product_id
  , count(distinct session_id) NumPurchases
  
  from {{ ref('int_product_purchase_sessions') }} ps
  
  group by ps.product_id
  
  ),

views_by_product as (
  
  select vs.product_id
  , count(distinct session_id) NumViews
  
  from {{ ref('int_product_view_sessions') }} vs
  
  group by vs.product_id
  
  )
  
  select p.product_id
  , p.name ProductName
  , pp.NumPurchases
  , vp.NumViews
  , round(cast(pp.NumPurchases as decimal) / cast(vp.NumViews as decimal) * 100, 2) as ProductConversion
  
  from product_names p
  join views_by_product vp on vp.product_id = p.product_id
  join purchases_by_product pp on pp.product_id = p.product_id
  
  order by ProductConversion desc