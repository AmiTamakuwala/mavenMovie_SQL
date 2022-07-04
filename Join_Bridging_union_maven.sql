 -- 'Join' & 'Bridging' & 'Union' & 'Union all'
-- Method of 'Join' :
/*
select
	table1.col_name,
    table2.col_name
from table1  -- left table
	inner/left/right join table2 -- right table
    on table1.common_col = table2.common_col ;
    
*/

/*
select
	table1.col_name, -- aggrgator
    table2.col_name
from table1  -- left table
	inner/left/right join table2 -- right table
    on table1.common_col = table2.common_col 
	where logic
    group by table1.col_name -- aggregator
    having condition
    order by table1.col_name;
*/

-- QUESTION:
-- Can you pull a list of each film we have in inventory?
-- I would like to see the film's title, description, and the store_id value 
-- associated with each item and item inventory_id.

 -- data: film's title and description  are present in film table and inventory_id and film_id is stored in inventory table.

select
	inventory.inventory_id,
    inventory.film_id,
    inventory.store_id,
    film.title,
    film.description
from inventory
	left join film
    on inventory.film_id = film.film_id;
    
 -- OR:
 
 select
	A.inventory_id,
    A.film_id,
    A.store_id,
    B.title,
    B.description
from inventory as A
	left join film as B
    on A.film_id = B.film_id;

/*    
-- Question
-- Pull details of all the actors first name , last name and
-- count of movies they have appread in.
-- and sort the record in decreasing order.
  */
  
select
	actor.actor_id,			-- aggregator
    actor.first_name,		-- aggregator
    actor.last_name,		-- aggregator
	count(film_actor.film_id) as count_of_films		-- aggregated value
from actor
	left join film_actor
		on actor.actor_id = film_actor.actor_id
	group by actor.actor_id, actor.first_name, actor.last_name
		order by count_of_films desc;
    
 -- Left vs Inner join is where problem appears
-- While inner join return only where there is a common match.
-- left join on the other hand returns all rows from left tble and matching results from right table.

-- Inner join are more restrictive in nature.
-- Left Join is being a little loose in restriction. 
   
    
-- example: Inner Join:
    
select distinct
		inventory.inventory_id,
        rental.inventory_id
from inventory
	inner join rental
		on inventory.inventory_id = rental.inventory_id; 
    -- ANS: 4580 distinct inventory item common in rental and inventory table.
    
# -- try with left join:
 
 select distinct
	inventory.inventory_id,
    rental.inventory_id
from inventory
	left join rental
		on inventory.inventory_id = rental.inventory_id;
    # -- ANS: as we can see in 'inner join' there are 4580 rows were common in rental and inventory
    -- but here 'left join' total no of rows are 4581 and there is is not calculating common column in between inventory table and rental table.
    -- we can see null value in left join which means no common value. 
    --  but in inner join there are no null value, which means it takes only that value from inventory_id which are common in both table.

/*
-- Question 
-- one of our investors is interestd in the films we carry and how many actors are listed for each film title.
-- Can you pull a list of all titles , and figure out how many actors are associated with each title.
  */
  
 select
	film.title, 		-- aggregator
    count(film_actor.actor_id) as no_of_actors
from film
	left join film_actor
		on film.film_id = film_actor.film_id
     group by film.title
     order by no_of_actors desc;
        
# -------------- Left vs Inner vs Right  -------------------------

/*
-- Question
-- I want to pull all data of actor_id, first_name, last_name from actor table
-- and I want to pull data of first_name ,last_name and awards from actor_award table.
  */
  
select
	actor.actor_id, 		-- aggregator
    actor.first_name ,		-- aggregator
    actor.last_name , 		-- aggregator
    actor_award.first_name as awards_first,
    actor_award.last_name as awards_last,
    actor_award.awards
from actor
	left join actor_award
		on actor.actor_id = actor_award.actor_id
	order by actor.actor_id;
    
    # --ANS: as from the output table we get 200 rows with the null values.
	-- that mean here, in 'left join' we get the name of all actors who will not selected for the awrds or 
	-- we can say that they didn't get the awards which showing us null value.
-- so, now we want only that list who got the awards only that actor names will appear in the list.
-- for that we will use 'inner join':

# ------- try with 'INNER JOIN' ------------------

 select
	actor.actor_id, 		-- aggregator
    actor.first_name ,		-- aggregator
    actor.last_name , 		-- aggregator
    actor_award.first_name as awards_first,
    actor_award.last_name as awards_last,
    actor_award.awards
from actor
	inner join actor_award
		on actor.actor_id = actor_award.actor_id
	order by actor.actor_id;       
        
     # -- ANS: so, as we can get the outputs here, there are only 135 rows
     -- and in this table we only get those actors name who got the awards.
     -- that menas nop null values are here.
        
# ----------- try with 'RIGHT JOIN' ---------------

 select
	actor.actor_id, 		-- aggregator
    actor.first_name ,		-- aggregator
    actor.last_name , 		-- aggregator
    actor_award.first_name as awards_first,
    actor_award.last_name as awards_last,
    actor_award.awards
from actor
	right join actzor_award
		on actor.actor_id = actor_award.actor_id
	order by actor.actor_id;              
	
    
#-----------------------   BRIDGING  ---------------------------------
# when we want to connect two tables we find out the common column between them. --join
# but what if two two table that you want to join doesn't have any common column?
# we need to find tables that have common connection to both of these tables and that as a 'BRIDGE' to connect.

/*
QUestion:---
-- Pull the list where our customer live?,
-- Pull the list of customer_id, their first and last name, also in which city they are living?. 

*/
        
 select
	customer.customer_id,
    customer.first_name,
    customer.last_name,
    address.address_id,
    address.city_id,
    city.city
from customer
		left join address
			on customer.address_id = address.address_id
		left join city
			on address.city_id = city.city_id;

        
select
	customer.customer_id,
    customer.first_name,
    customer.last_name,
    city.city
from customer
	left join address
		on customer.address_id = address.address_id
	left join city
		on address.city_id = city.city_id;
        
        
/*        
-- Question

-- Pull each records for the movies in your film records and 
-- get film_id, title, category , category name. 

-- bridge between 3 tables
-- film will join with film_categoty on film_id
-- film_category with join with category on category_id
*/

select
	film.film_id,
    film.title,
    film_category.category_id,
    category.name
from film
	left join film_category
		on film.film_id = film_category.film_id
	left join category
		on film_category.category_id = category.category_id;
        
        
 /*
 -- Question 
-- pull out all details of customers address, district, city, country.
*/
        
select
	customer.customer_id,
    customer.first_name,
    customer.last_name,
    address.address,
    address.district,
    city.city,
    country.country
from customer
	left join address
		on customer.address_id = address.address_id
	left join city
		on address.city_id = city.city_id
	left join country
		on city.country_id = country.country_id;
    
        
-- Pull the same list but this time apply the condition: where customer first_name is mary:

select
	customer.customer_id,
    customer.first_name,
    customer.last_name,
    address.address,
    address.district,
    city.city,
    country.country
from customer
	left join address
		on customer.address_id = address.address_id
	left join city
		on address.city_id = city.city_id
	left join country
		on city.country_id = country.country_id
where customer.first_name like "%MARY%";

-- OR:
         
select
	customer.customer_id,
    customer.first_name,
    customer.last_name,
    address.address,
    address.district,
    city.city,
    country.country
from customer
	left join address
		on customer.address_id = address.address_id
			and customer.first_name like "%MARY%"
	inner join city
		on address.city_id = city.city_id
	inner join country
		on city.country_id = country.country_id
			and country.country = 'JAPAN';        
        
        
-- OR:
        
 select
	customer.customer_id,
    customer.first_name,
    customer.last_name,
    address.address,
    address.district,
    city.city,
    country.country
from customer
	left join address
		on customer.address_id = address.address_id
	inner join city
		on address.city_id = city.city_id
	inner join country
		on city.country_id = country.country_id
where customer.first_name like "%MARY%"			
            and country.country = 'JAPAN';               
        
  # ---------------------------  UNION  ------------------------------      
-- returns all the data from first table, with all data from second table.

/*
QUESTION
-- Pull the all records of stakeholder in our renting business.
-- investor and advisor
-- aslo pull staff.
*/

 select
	'advisor' as stakeholder_type,
    first_name,
    last_name
from advisor
	union
select
	'investor' as stakeholder_type,
    first_name,
    last_name
from investor
	union
select
	'staff' as stakeholder_type,
    first_name,
    last_name
from staff;
        
        
 -- From above list of data please pull the all column from the staff table.(-gives error)
 
 select
	'advisor' as stakeholder_type,
    advisor.first_name,
    advisor.last_name
from advisor
	union
select
	'investor' as stakeholder_type,
    investor.first_name,
    investor.last_name
from investor
	union
select 
	*
from staff;
        
        -- ANSWER:
        --  Error : Error Code: 1222. The used SELECT statements have a different number of columns
		-- when performing union make sure all tables are having same count of columns.



        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    
    
    