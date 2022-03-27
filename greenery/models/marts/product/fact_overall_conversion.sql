{{
  config(
    materialized='table'
  )
}}


--session with purchases
with purchase_sessions as (

  select cast(count(distinct session_id) as decimal) CountPurchases
  
  from {{ ref('stg_events') }} 
  
  where event_type = 'checkout'
  ),
  
--all sessions
all_sessions as (

  select cast(count(distinct session_id) as decimal) CountSessions
  
  from {{ ref('stg_events') }} 

  )

--Calculate Conversion Rate
select round(CountPurchases/CountSessions * 100, 2) as conversion_rate

from purchase_sessions

full outer join all_sessions on 1=1