SELECT
  product_id
  , name
  , price
  , inventory

FROM {{ source('src_project', 'products') }}