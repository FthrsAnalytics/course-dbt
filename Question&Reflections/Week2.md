# Week 2
## Short Answer
#### What is our user repeat rate?
##### Repeat Rate = Users who purchased 2 or more times / users who purchased
Repeat Rate = 79.84%

```sql
with repeat_users as (
  select u.user_id
  , count(o.order_id)
  
  from dbt_joseph_y.stg_users u 
  join dbt_joseph_y.stg_orders o on o.user_id = u.user_id
  
  group by u.user_id
  
  having count(o.order_id) > 1
),

count_repeat_users as (
  select cast(count(repeat_users.user_id) as decimal) as NumRepeatUsers
  
  from repeat_users
),

count_all_users as (
  select cast(count(distinct o.user_id) as decimal) as NumAllUsers
  
  from dbt_joseph_y.stg_orders o
)


select round(NumRepeatUsers / NumAllUsers * 100, 2) repeat_rate
from count_repeat_users 
full outer join count_all_users on 1=1
```

#### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
##### NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.
Good indicators of a user who will likely purchase again include:

Good indicators of a user who will likely NOT purchase again include:

Some additional features I would want to look into include:

#### More stakeholders are coming to us for data, which is great! But we need to get some more models created before we can help. Create a marts folder, so we can organize our models, with the following subfolders for business units:
* Core
* Marketing
* Product
#### Within each marts folder, create intermediate models and dimension/fact models.
##### NOTE: think about what metrics might be particularly useful for these business units, and build dbt models using greenery’s data. For example, some “core” datasets could include fact_orders, dim_products, and dim_users. The marketing mart could contain a model like user_order_facts which contains order information at the user level. The product mart could contain a model like fact_page_views which contains all page view events from greenery’s events data

#### Explain the marts models you added. Why did you organize the models in the way you did?

#### Use the dbt docs to visualize your model DAGs to ensure the model layers make sense
##### Paste in an image of your DAG from the docs (using the dbt docs generate and dbt docs serve commands)

## Reflection
#### Part 1: Were you able to answer the data question asked i.e. What is our user repeat rate? Y/N

#### Part 1: Were you able to create a marts folder for the three business lines? Y/N

#### Part 1: Were you able to create at least 1 intermediate model and 1 dimension/fact model within each marts model? Y/N.

#### Part 2: Were you able to apply dbt tests to your week 1 or week 2 models? Y/N

#### Reflection: What was most challenging/surprising in completing this week’s project?

#### Reflection: Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers?

#### Reflection: What are you most proud of about your project?
