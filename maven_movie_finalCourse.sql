/* 
1. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 

-- staff table, address table, city table & country table.
-- staff table, address table on address_id
-- address table , city table on city_id
-- city table, country table on country_id

select
	staff.staff_id,
    upper(concat(staff.first_name, " ", staff.last_name)) as fullname,
	concat(address.address, ", ", address.district, ", ", city.city, ", ", country.country) as property_address
from staff
	inner join address
		on staff.address_id = address.address_id
	inner join city
		on address.city_id = city.city_id
	inner join country
		on city.country_id = country.country_id;

/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/

-- inventory table and film table are to be conacted on column film_id.

select
	inventory.store_id,
    inventory.inventory_id,
    film.title,
    film.rating,
    film.rental_rate,
    film.replacement_cost
from inventory
	left join film
		on inventory.film_id = film.film_id;
        
/* 
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/

-- here, first count the total ratings which we have:
/*
select count(distinct rating)
	from mavenmovies.film;
*/
-- total rating =5 
-- total store: 2
-- means(5*2=10) rows

select
	inventory.store_id,		-- aggregator
    film.rating,			-- aggregator
	count(inventory.inventory_id) as count_of_inventory_items
from inventory
	left join film
		on inventory.film_id = film.film_id
group by inventory.store_id, film.rating;
    

/* 
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 

-- 2 stores
-- 16 category : So, total (16*2=32) rows we will get:

-- inventory table and film table , and film table to film_category table, and film_category table to category table.

-- inventory table and film table on film_id
-- film table and film_category table on film_id
-- film_category table to category table on category_id

select
	inventory.store_id,		-- aggregator
	category.name,			-- aggregator
    count(film.film_id) as no_of_movies,
    avg(film.replacement_cost) as avg_replacement_cost,
    sum(film.replacement_cost) as total_replacement_cost
from inventory
		left join film 
			on inventory.film_id = film.film_id
		left join film_category
			on film.film_id = film_category.film_id
		left join category
			on film_category.category_id = category.category_id
group by inventory.store_id, category.name
order by store_id, total_replacement_cost desc;
  
-- Observation from above table:
	-- for store_id: 1 'action' category has highest total replacement cost
	-- for store_id: 2 'sports' category has highest total replacement cost
        
        
# now, check average replacement cost which is highest in store_id:1 and store_id:2
#  and pull same data which was above:

select
	inventory.store_id,		-- aggregator
	category.name,			-- aggregator
    count(film.film_id) as no_of_movies,
    avg(film.replacement_cost) as avg_replacement_cost,
    sum(film.replacement_cost) as total_replacement_cost
from inventory
		left join film 
			on inventory.film_id = film.film_id
		left join film_category
			on film.film_id = film_category.film_id
		left join category
			on film_category.category_id = category.category_id
group by inventory.store_id, category.name
order by store_id, avg_replacement_cost desc;
 
 -- OBSERVATION:
	-- for store: 1 category "Drama" has highest average replacement cost.
    -- for store: 2 category "Action" has highest average replacement cost.
        
 /*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/

-- customer table and address table, address table and city table, city table and country table.

-- customer table and address table connected on address_id
-- address table and city table connected on city_id
-- city table and country table connected on country_id.        
        
select
	customer.store_id,
    upper(concat(customer.first_name, " ", customer.last_name)) as full_name,
    case
		when customer.active= 0 then "Inactive"
        when customer.active= 1 then "Active"
			else "error....."
			end as status,
    concat(address.address, " ", city.city, " ", country.country) as full_address
from customer
	left join address
		on customer.address_id = address.address_id
	left join city
		on address.city_id = city.city_id
	left join country
		on city.country_id = country.country_id ;
        

/*
6.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/
 
# -- first way:
-- customer table and payment table connected on customer_id.

# -- Second way:
-- customer table and rental table on customer_id,  
-- rental table and payment table on rental_id:

# --  first way:

select
	customer.customer_id,			-- aggregator
    concat(customer.first_name, " ", customer.last_name) as full_name, 	-- aggregator
    count(payment.rental_id) as total_lifetime_rental,
    sum(payment.amount) as total_lifetime_value
from customer
	left join payment
		on customer.customer_id = payment.customer_id
group by customer.customer_id, full_name
order by total_lifetime_value desc; 
        
        
# -- Second way:

select
	customer.customer_id,			-- aggregator
    concat(customer.first_name, " ", customer.last_name) as full_name, 	-- aggregator
    count(payment.rental_id) as total_lifetime_rental,
    sum(payment.amount) as total_lifetime_value
from customer
	left join rental
		on customer.customer_id = rental.customer_id
	left join payment
		on rental.rental_id = payment.rental_id
group by customer.customer_id, full_name
order by total_lifetime_value desc;         
        
        
/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/

select
	"advisor" as stakeholder,
    first_name,
    last_name,
    null as company_name
from 
	advisor
union
select 
	"investor" as stakeholder,
    first_name,
    last_name,
    company_name
from 
	investor;
    
/*
8. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/

-- film table and film_actor table and actor_awards table
-- film table and film_actor connnected on film_id
-- film_actor and actor_awards connected on actor_id

select
	case
		when awards = 'Emmy, Oscar, Tony ' then '3 awards'
        when awards in ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') then '2 awards'
        when awards in ('Emmy', 'Oscar', 'Tony') then '1 award'
        end as no_of_awards,
	sum(case when actor_id is null then 0 else 1 end) as film_count_value,
    (sum(case when actor_id is null then 0 else 1 end)/count(case when actor_id is null then 0 else 1 end))*100 as film_percentage_count_value
from actor_award
	group by 
		case
			when awards = 'Emmy, Oscar, Tony ' then '3 awards'
			when awards in ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') then '2 awards'
			when awards in ('Emmy', 'Oscar', 'Tony') then '1 award'
			end;
        
        
 -- for more detail will create views:
 
 create view actor_awards_view as(
 select
	case
		when awards = 'Emmy, Oscar, Tony ' then '3 awards'
        when awards in ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') then '2 awards'
        when awards in ('Emmy', 'Oscar', 'Tony') then '1 award'
        end as no_of_awards,
	actor_id
from actor_award
);
        
select * from actor_awards_view;        
        
  
select
	no_of_awards,
    sum(case when actor_id is null then 0 else 1 end) as film_actor_count,
	(sum(case when actor_id is null then 0 else 1 end)/ count(case when actor_id is null then 0 else 1 end))*100 as film_percentage_count_value
from  actor_awards_view
		group by no_of_awards;
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        