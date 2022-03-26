# Week 3
## Short Answer
### (Part 1) Models
#### What is our overall conversion rate?
Overall Conversion Rate = ~ 62.46%

```sql
--session with purchases
with purchase_sessions as (

  select cast(count(distinct session_id) as decimal) CountPurchases
  
  from dbt_joseph_y.stg_events 
  
  where event_type = 'checkout'
  ),
  
--all sessions
all_sessions as (

  select cast(count(distinct session_id) as decimal) CountSessions
  
  from dbt_joseph_y.stg_events 

  )

--Calculate Conversion Rate
select round(CountPurchases/CountSessions * 100, 2) as conversion_rate

from purchase_sessions

full outer join all_sessions on 1=1
```

#### What is our conversion rate by product?

```sql
--Product names
with product_names as (
  select p.product_id
  , p.name
  
  from dbt_joseph_y.stg_products p
),

--Purchases of Product 
purchase_sessions_by_product as (
  select distinct e.session_id
  , e.user_id
  , e.created_at
  , o.product_id
  
  from dbt_joseph_y.stg_events e
  inner join dbt_joseph_y.stg_order_items o on o.order_id = e.order_id
  
  where e.event_type = 'checkout'
  
  order by e.session_id
  , e.user_id
  , e.created_at
  , o.product_id
  ),
  
--Views of Product 
view_sessions_by_product as (
  
  select distinct e.session_id
  , e.user_id
  , e.created_at
  , e.product_id
  
  from dbt_joseph_y.stg_events e
  
  where e.event_type = 'page_view'
  
  order by e.session_id
  , e.user_id
  , e.created_at
  , e.product_id
  ),

--Purchases by Product
purchases_by_product as (
  
  select ps.product_id
  , count(*) NumPurchases
  
  from purchase_sessions_by_product ps
  
  group by ps.product_id
  
  ),

--Views by Product
views_by_product as (
  
  select vs.product_id
  , count(*) NumViews
  
  from view_sessions_by_product vs
  
  group by vs.product_id
  
  )
  
select p.name ProductName
, pp.NumPurchases
, vp.NumViews
, round(cast(pp.NumPurchases as decimal) / cast(vp.NumViews as decimal) * 100, 2) as Product_Conversion
  
from purchases_by_product pp
join views_by_product vp on vp.product_id = pp.product_id
join product_names p on p.product_id = pp.product_id
  
order by Product_Conversion desc
```

### (Part 2) Macros
Use macro for conversion rate by product.

### (Part 3) Hooks
```sql

```

### (Part 4) Packages
```sql

```

### (Part 5) DAG
Simplified or improved DAG 

## Reflection
#### Part 1: Were you able to create new models to answer the data questions on conversion rate?
**Y**/N

#### Part 2: Were you able to add a new macro to your dbt project? (indicate if you used a macro to aggregate event types per session or something else)
**Y**/N

#### Part 3: Were you able to add a post hook to your project to apply grants to the role “reporting”?
**Y**/N

#### Part 4: Were you able to install a package? (indicate what package you used)
Y/**N**

#### Reflection: What was most challenging/surprising in completing this week’s project?


#### Reflection: Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers?


#### Reflection: What are you most proud of about your project?

