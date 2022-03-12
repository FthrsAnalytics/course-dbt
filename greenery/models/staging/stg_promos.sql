SELECT
  promo_id
  , discount
  , status

FROM {{ source('src_project', 'promos') }}