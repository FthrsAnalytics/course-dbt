# Week 1 
## Short Answer
#### How many users do we have?
130
```sql 
select count(distinct user_id) 

from dbt_joseph_y.stg_users 
```
#### On average, how many orders do we receive per hour?
~7.52
```sql
select avg(y.NumOrders)

from (
    select 
    date_trunc('hour', created_at) as hour
    , count(distinct order_id) as NumOrders
    
    from dbt_joseph_y.stg_orders
    
    group by date_trunc('hour', created_at)
  ) as y
 ```
#### On average, how long does an order take from being placed to being delivered?
~ 3 days 21 hours

```sql
select avg(delivered_at - created_at)

from dbt_joseph_y.stg_orders

where status = 'delivered'
```
#### How many users have only made one purchase? Two purchases? Three+ purchases?
##### Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
One Order: 25, Two Orders: 28, Three + Orders: 71
```sql
select 
  case 
    when y.NumOrders = 1 then 'One Order'
    when y.NumOrders = 2 then 'Two Orders' else 'Three + Orders' end
  , count(distinct y.user_id)

from (
  
  select u.user_id
  , count (distinct order_id) NumOrders
  
  from dbt_joseph_y.stg_users u
  join dbt_joseph_y.stg_orders o on o.user_id = u.user_id
  
  group by u.user_id
  ) as y

group by   case 
    when y.NumOrders = 1 then 'One Order'
    when y.NumOrders = 2 then 'Two Orders' else 'Three + Orders' end
    
order by count
```
#### On average, how many unique sessions do we have per hour?
~ 16.33
```sql
select avg(y.NumSessions)

from (
    select 
    date_trunc('hour', created_at) as hour
    , count(distinct session_id) as NumSessions
    
    from dbt_joseph_y.stg_events
    
    group by date_trunc('hour', created_at)
  ) as y
```
## Reflection
#### Part 2: Were you able to create schema.yml files with model names and descriptions? 
**Y**/N

#### Part 2: Were you able to run your dbt models against the data warehouse? 
**Y**/N

#### Part 3: Could you run the queries to answer key questions from the project instructions? 
**Y**/N

#### Reflection: What was most challenging/surprising in completing this week’s project?
Creating my own mental model of what each of the elements of a dbt project are and how they relate together (source, profile, etc)

#### Reflection: Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers?
Not sure if we'll cover this later, but want to learn more about how to set up data source connections for a dbt project.
