show tables;
/*
actor
actor_award
actor_info
address
advisor
category
city
country
customer
customer_list
film
film_actor
film_category
film_list
film_text
inventory
investor
language
nicer_but_slower_film_list
payment
rental
sales_by_film_category
sales_by_store
staff
staff_list
store
*/

/*
in our database we have 16 related tables, whicgh contains information abput:
1. Customer (name, address etc.)		# 4 tables for Customer
		All data corresponding to customer.
			a. customer 
            b. address
            c. city
            d. country
            
2. Business (Staff, Rentals etc.)		# 4 tables for Business + 2 tables
		All data coresponding to business.
			a. staff
            b. store
            c. payments
            d. rentals
            
            # extra tables:
				advisor
                investor
            
            
3. Inventory (films, Categories etc.) 	# 8 tables for Inventory + 1 table
		corresponding to Inventory.
			a. Inventory
			b1. film
            b2. film_text
            c. film_category
            d. category
            e. language
            f. actor
            g. film_actor

		# extra table:
			actor_award
*/

-- # Qus from this case study:

-- 1. Pull list first name, last name and email of all our customers. 
	-- First things is locate i9n which table you can find relevant data.
	-- what all informatiom has been asked for.
    
select
	first_name,
    last_name,
    email
    from customer;
    
-- 2. Pull the first name, last name, store they are working in and email of all our stall. 
	-- first identify in which table your data is present.
    -- what column you need to provide?
    
select
	first_name,
    last_name,
    store_id,
    email
    from staff;
    
-- 2. Distinct: means (uniquie)
		
-- find out how types of ratings are in our inventory for filmns?
-- list down all the available ratings.
    
select distinct
	rating
    from film;
	-- there are 5 unique ratings in our films.
		-- PG, G, NC-17, PG-13, R

-- 3. find out the no. of unique staff who are renting out movies?.
select distinct
	staff_id
    from rental;
    
-- 4. can you pull up the records of our films and see there are any other rental duration apart from 6,5,7,3 days.

select distinct
	rental_duration
    from film;
		-- Ans: we are making for rental for 5 different durations and they are 6,3,7,5,4 days. 
        
-- Where operator:
-- where clause are filter out records based on any logical conditions.
		-- = Equals
		-- <> or != Does not equal to
        -- > Greater than
        -- < less than 
        -- >= greater than equal to
		-- <= less than eual to.
        -- Between - a range of values.
        -- like - matching a pattern like this
        -- in() - match across multiple values.

-- Question:
-- find out how many transactions/payment made where value is 0.99$
-- pull up records of customer_id, rental_id, amount, payment_date.

select
	customer_id,
    rental_id,
    amount,
    payment_date
    from payment
		where amount = 0.99;
		
        -- ans: there are 2979 records where payment was made for 0.99$.

-- Qus:
-- Pull up all records of transction made after 1st of january 2006.
-- Pull up the same records as above of transctions:

select
	customer_id,
    rental_id,
    amount,
    payment_date
    from payment
		where payment_date > '2006-01-01';
        
        -- Ans: there are 182 records for payment made after 1st of january, 2006.

-- Qus:
-- I'd like to look at payment records of our long-term customers to learn their purchase patterns.
-- could you pull all payments from our first 100 customers (based on customer id)?

select
	customer_id,
    rental_id,
    amount,
    payment_date
    from payment
		where customer_id between 1 and 100;

-- OR
select
	customer_id,
    rental_id,
    amount,
    payment_date
    from payment
		where customer_id <= 100;

-- OR
select
	customer_id,
    rental_id,
    amount,
    payment_date
    from payment
		where customer_id < 101;

		-- Ans: there are 2711 records of first 100 customer who are our long-term customers.


-- QUS:
-- Pull all records where payment amount was of 0.99$ and payment date is after '2006-01-01'.

-- logical operators: 
-- AND / OR :

select
	customer_id,
    rental_id,
    amount,
    payment_date
    from payment
		where amount = 0.99 
			and payment_date > '2006-01-01';

-- QUS:
-- The payment that you pulled up- for first 100 customer was great--
-- Now I would like to see just those payment made over 5$ and after 1st january,2006. 

select
	customer_id,
    rental_id,
    amount,
    payment_date
    from payment
		where customer_id <=100
			and amount > 5
            and payment_date > '2006-01-01';

	-- Ans: So, there are 4 data where first 100 customer made over 5$ and after 1st jan, 2006.

-- QUS:
 -- pull up records of customer_id, rental_id, amount, payment_date.
-- Pull up the record for customer_id 5,11, 29:

select
	customer_id,
    rental_id,
    amount,
    payment_date
		from payment
			where customer_id in(5,11,29);

-- OR: 

select
	customer_id,
    rental_id,
    amount,
    payment_date
		from payment
			where customer_id = 5
            or customer_id = 11
            or customer_id = 29;
		-- Ans: there are 19 rows where customer_id are 5, 11, 29.

-- QUS:
-- The data you shared previous payment amount over 5$, but this only for customer 42, 53, 60 and 75.

select
	customer_id,
    rental_id,
    amount,
    payment_date
		from payment
			where amount > 5
				and customer_id in (42, 53, 60, 75);
	
-- OR:


select
	customer_id,
    rental_id,
    amount,
    payment_date
		from payment
		where amount > 5
            and
            (customer_id = 42
            or customer_id = 53
            or customer_id = 60
            or customer_id = 75);
   
-- Ans: there are 29 rows where customer_id are 42, 53, 60, 75 and payment amount over 5$.

-- like operator:
-- Allows you to use pattern matching in your logical operators.(instead of exact matching)

	-- like '%patternToLookfor%'
	
-- QUS:
-- Could you pull a list of title and description which includes a 'Behind the Scenes'.

select
	title,
    description, 
    special_features
		from film
			where special_features like '%Behind the Scene%';

-- QUS:
-- Pull up all the records where description contain 'shark'.

select
	title,
    description
		from film
			where description like '%shark%';
            
-- QUS:
-- Find out all those movies starts with 'Su'.

select
	title, 
    description
from film
	where title like 'SU%';


-- QUS:
-- Find out all thise movies ending with 'es'.

select
	title,
    description
from film
	where title like '%ES';

-- Start with any character but next plphabet is 'UN' and end with anything, hwich you don't know.

select
	title,
    description
from film
	where title like '_UN%';
    
-- 'Count' -- if you want to find number of observation you can use 'count(*)'.

select
	count(*)
from film
	where title like '_UN%';

# When :
# QUESTION:
-- Pull list of all movies and categorize them into 3 categories.
-- based on length of the movie.

-- if length < 60 then "under 1 hr"
-- if length between 60 and 90 then  "1-1.5 hr"
-- if length > 90 then "over 1.5 hr"

select 
	film_id,
    title,	
    length,
    case
		when length < 60 then "under 1 hr"
        when length between 60 and 90 then "1-1.5 hr"
        when length >90 then "over 1.5 hr"
        else "others"
	end as length_category
from
	film;
 
 select 
	film_id,
    title,	
    length,
    case
		when length < 60 then "under 1 hr"
        when length between 60 and 90 then "1-1.5 hr"
        when length >120 then "over 1.5 hr"
        else "others"
	end as length_category
from
	film;
    
/*
= Equals
!= Not Equal
<> Not Equal
> Greater than
< Less than
>= greater than equals to
<= less than euals to
between 
like
in()
*/

# Question
-- if rental_duration <=4 then 'rental_too_short'
-- if rental_rate >= 3.99 then 'too_expensive'
-- if rating is equal to NC-17 and R then 'adult' 
-- if length between 60 and 90 then 'too_short_or_too_long'
-- if description contain sharks then 'nope_has_sharks'
-- else 'good for your niece'
-- and assign a column name fit_for_recommentation 

select
	film_id,
    title, 
    case
		when rental_duration <=4 then 'rental_too_short'
        when rental_rate >= 3.99 then 'too_expensive'
        when rating in('NC-17', 'R') then 'adult'
        when length between 60 and 90 then 'too_short_or_too_long'
        when description like '%shark%' then 'nope_has_sharks'
        else 'good_for_niece'
	end as 'fit_for_recomendation'
from film;
        
select
	film_id,
    title,
    case
		when rental_duration <=4 then 'rental_too_short'
        when rental_rate >= 3.99 then 'too_expensive'
        when rating in ('NC-17','R') then 'adult_rated'
        when length between 60 and 90 then 'too_short_too_long'
        when description like '%Shark%' then 'nope_has_sharks'
        else 'great_for_my_niece'
	end as fit_for_recommendation
    from film;    
    
-- How to create views and temporary_tables:
    
create view movie_recomandation as(
select
	film_id,
    title,
    case
		when rental_duration <=4 then 'rental_too_short'
        when rental_rate >= 3.99 then 'too_expensive'
        when rating in ('NC-17','R') then 'adult_rated'
        when length between 60 and 90 then 'too_short_too_long'
        when description like '%Shark%' then 'nope_has_sharks'
        else 'great_for_my_niece'
	end as fit_for_recommendation
    from film);    
    
  select 
	*
from movie_recomandation 
		where fit_for_recommendation = 'great_for_my_niece';  
    
-- create temporary table:

 create temporary table movie_recommendation_table as (
select
	film_id,
    title,
    case
		when rental_duration <=4 then 'rental_too_short'
        when rental_rate >= 3.99 then 'too_expensive'
        when rating in ('NC-17','R') then 'adult_rated'
        when length between 60 and 90 then 'too_short_too_long'
        when description like '%Shark%' then 'nope_has_sharks'
        else 'great_for_my_niece'
	end as fit_for_recommendation
    from film);
   
 select * from movie_recomandation_table;
    
 select 
	* 
 from movie_recomandation_table 
		where fit_for_recommendation = 'great_for_my_niece';   
    
-- QUESTION:
-- I'd like to know which store each customer goes to , and whether or not they are active.
-- Could you please pull a list of first and last name of all customers and
-- label then as either 'store 1 active' , 'store 1 inactive' , 'store 2 active' or 'store 2 inactive'
-- if nothing matches 'others' and create a new column store_and_status.

-- output will be  like this..
-- first_name , last_name , store_and_status
-- Mary , Smith , 'store 1 active'
-- Barbara, jones, 'store 2 active'    
    
select 
	first_name,
    last_name,
    case
		when store_id = 1 and active = 1 then 'store 1 active'
        when store_id = 1 and active = 0 then 'store 1 inactive'
        when store_id = 2 and active = 1 then 'store 2 active'
        when store_id = 2 and active = 0 then 'store 2 inactive'
		else 'others'
	end as store_and_status
from customer;
    
    
   -- now let's check for sotre 1 and inactive customer.
/*
   select 
	first_name,
    last_name,
    case
		when store_id = 1 and active = 1 then 'store 1 active'
        when store_id = 1 and active = 0 then 'store 1 inactive'
        when store_id = 2 and active = 1 then 'store 2 active'
        when store_id = 2 and active = 0 then 'store 2 inactive'
		else 'others'
	end as store_and_status
from customer
	where store_and_status = 'store 1 inactive';
*/
select
	first_name,
    last_name,
    case 
		when store_id=1 and active =1 then 'store 1 active'
        when store_id=1 and active =0 then 'store 1 inactive'
        when store_id=2 and active =1 then 'store 2 active'
        when store_id=2 and active =0 then 'store 2 inactive'
		else 'others'
	end as store_and_status
from customer
	where store_and_status = 'store 1 inactive';
			-- this result will not come correctly as we will introduce new features 'view structure' as below:
            
/*
-- view structure
create view  <view_name> as (
<select query using which you want to create view.>
);
*/
    
create view store_status_view as (
 select
	first_name,
    last_name,
    case 
		when store_id=1 and active =1 then 'store 1 active'
        when store_id=1 and active =0 then 'store 1 inactive'
        when store_id=2 and active =1 then 'store 2 active'
        when store_id=2 and active =0 then 'store 2 inactive'
		else 'others'
	end as store_and_status
from customer);
	
			-- Now let's check store 1 inactive customer from store_status_view:
	select 
		*
	from store_status_view
		where store_and_status = 'store 1 inactive';
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    