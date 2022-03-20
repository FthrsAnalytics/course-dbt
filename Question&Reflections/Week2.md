# Week 2
## Short Answer
### (Part 1) Models
#### What is our user repeat rate?
##### Repeat Rate = Users who purchased 2 or more times / users who purchased
Repeat Rate = ~ 79.84%

```sql
--Return users with more than one order
with repeat_users as (
  select u.user_id
  , count(o.order_id)
  
  from dbt_joseph_y.stg_users u 
  join dbt_joseph_y.stg_orders o on o.user_id = u.user_id
  
  group by u.user_id
  
  having count(o.order_id) > 1
),

--Count number of users with more than one order
count_repeat_users as (
  select cast(count(repeat_users.user_id) as decimal) as NumRepeatUsers
  
  from repeat_users
),

--Count all users who have made an order
count_all_users as (
  select cast(count(distinct o.user_id) as decimal) as NumAllUsers
  
  from dbt_joseph_y.stg_orders o
)

--Calculate Repeat Rate
select round(NumRepeatUsers / NumAllUsers * 100, 2) repeat_rate
from count_repeat_users 
full outer join count_all_users on 1=1
```

#### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
##### NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.
Good indicators of a user who will likely purchase again include:
 - number of previous purchases
 - number of unique events
 - number of unique sessions
 - use of promo code
 - if they have a Greenery account

Good indicators of a user who will likely NOT purchase again include:
 - abandoned sessions
 - returned item
 - cancelled orders
 - move out of country

Some additional features I would want to look into include:
 - if there is a membership program
 - user contact history
 - more user info (age, interests, etc)

#### More stakeholders are coming to us for data, which is great! But we need to get some more models created before we can help. Create a marts folder, so we can organize our models, with the following subfolders for business units:
* Core
* Marketing
* Product
#### Within each marts folder, create intermediate models and dimension/fact models.
##### NOTE: think about what metrics might be particularly useful for these business units, and build dbt models using greenery’s data. For example, some “core” datasets could include fact_orders, dim_products, and dim_users. The marketing mart could contain a model like user_order_facts which contains order information at the user level. The product mart could contain a model like fact_page_views which contains all page view events from greenery’s events data

#### Explain the marts models you added. Why did you organize the models in the way you did?
 - Core: The grain of fact of the core mart is at the order level. I also created dims for users and products to better analyze the orders.
 - Marketing: Intermediate table to aggregate order info to user level. Fact table that combines info from staging user, staging address, and intermediate user orders. All user info needed for marketing contained in one table, ready to consume in BI tool.
 - Product: single fact table that has some light business logic for event information.

#### Use the dbt docs to visualize your model DAGs to ensure the model layers make sense
##### Paste in an image of your DAG from the docs (using the dbt docs generate and dbt docs serve commands)
![dbt-dag-cropped](https://user-images.githubusercontent.com/34662783/159179562-c2e1742a-5fc8-4d2b-a1de-c21b9f2a8ba2.png)

### (Part 2) Tests

#### What assumptions are you making about each model? (i.e. why are you adding each test?)
Each identifier in the model should be unique and not null.

#### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
Yes! I found a few zipcodes that did not have five characters.

#### Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
I could write the results of these tests to it's own model and use this model to generate tests reporting each day.

## Reflection
#### Part 1: Were you able to answer the data question asked i.e. What is our user repeat rate?
**Y**/N

#### Part 1: Were you able to create a marts folder for the three business lines?
**Y**/N

#### Part 1: Were you able to create at least 1 intermediate model and 1 dimension/fact model within each marts model?
**Y**/N. - I didn't create an intermediate model within each mart, but was able to successfully create within the marketing mart. 

#### Part 2: Were you able to apply dbt tests to your week 1 or week 2 models?
Y/**N**

#### Reflection: What was most challenging/surprising in completing this week’s project?
Having the flexibility to create both the requirements as well as the solution. If we were given more explicit instructions, it would have been easier to create the various models - but this way I had to understand the data more and put myself in the shoes of the various business units.

#### Reflection: Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers?
This week I want to go back and better structure / document all of the models in my project. I need a bit more experience building out full solutions to know how best to separate business logic, joins, and transformations between or in models. Should marketing have a single fact model with all the information? Or a fact model with multiple dimension models to support. I tried to build both in my project.

I tried to write a test for length of zipcode, but I get the error that the test is undefined. Will post in general-and-questions-dbt, but any help greatly appreciated!

#### Reflection: What are you most proud of about your project?
Nothing really stands out to me lol. Was happy to complete all the requirements and gain some further familiarity with dbt!
