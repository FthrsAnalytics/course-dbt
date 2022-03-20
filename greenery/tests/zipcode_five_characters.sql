select address_id

from {{ ref('stg_addresses') }}

where length(cast (zipcode as varchar)) <> 5
