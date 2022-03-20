{{
  config(
    materialized='table'
  )
}}

select u.user_id
, concat(u.first_name, ' ', u.last_name) UserName
, a.zipcode
, a.state
, a.country

from {{ ref('stg_users') }} u
join {{ ref('stg_addresses') }} a on a.address_id = u.address_id