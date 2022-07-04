use mavenmovies;

# ---------------------- GROUP BY -----------------------

/*
1.	We will need a list of all staff members, including their first and last names, 
email addresses, and the store identification number where they work. 
*/ 

select
	first_name,
    last_name,
    email,
    store_id
from 
	staff;

/*
2.	We will need separate counts of inventory items held at each of your two stores. 
*/ 

select
	store_id, 		-- aggregator
    count(inventory_id)			-- aggrigated value
from inventory
	group by store_id;		-- aggregator

/*
3.	We will need a count of active customers for each of your stores. Separately, please. 
*/

select
	store_id, 		-- aggregator
    count(active)		-- aggregated value.
from customer
	where active = 1
	group by store_id;		-- aggregator

#------------  GROUP BY, WHERE, HAVING, ORDER BY -----------------
		-- Appliying one more condition: 
		-- each store is having more than 300 customers.

select
	store_id, 		-- aggregator
    count(active)		-- aggrigated value
from customer
	where active = 1
		group by store_id		-- aggergator
		having count(active) > 300
		order by count(active);
    

/*
4.	In order to assess the liability of a data breach, we will need you to provide a count 
of all customer email addresses stored in the database. 
*/

select
	count(*)
from customer;

/*
5.	We are interested in how diverse your film offering is 
as a means of understanding how likely 
you are to keep customers engaged in the future. 

a. Please provide a count of unique film titles you have in inventory at each store and 

b. then provide a count of the unique categories of films you provide. 
*/
# --------------- COUNT, DISTINCT  ------------------------
-- a:

select
	store_id, 		-- aggregator
    count(distinct film_id) as unique_count		-- aggregated value
from inventory
	group by store_id; 		-- aggregator

-- b

select
	count(distinct category_id) as unique_category_films
from film_category;

/*
6.	We would like to understand the replacement cost of your films. 
Please provide the replacement cost for the film that is least expensive to replace, 
the most expensive to replace, and the average of all films you carry. ``	
*/

select
	min(replacement_cost) as least_expensive,
    max(replacement_cost) as most_expensive,
    avg(replacement_cost) as avg_expense
from film;

/*
7.	We are interested in having you put payment monitoring systems and maximum payment 
processing restrictions in place in order to minimize the future risk of fraud by your staff. 
Please provide the average payment you process, as well as the maximum payment you have processed.
*/

select
	min(amount) as minimum_payment,
    max(amount) as maximum_payment,
    avg(amount) as avg_payment
from payment;

/*
8.	We would like to better understand what your customer base looks like. 
Please provide a list of all customer identification values, with a count of rentals 
they have made all-time, with your highest volume customers at the top of the list.
*/

select
	customer_id, 		-- aggregator
    count(rental_id) as rental_count		-- aggregated value
from rental
	group by customer_id
    order by rental_count desc;











































































































































    