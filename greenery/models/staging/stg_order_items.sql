SELECT
  order_id
  , product_id
  , quantity

FROM {{ source('src_project', 'order_items') }}