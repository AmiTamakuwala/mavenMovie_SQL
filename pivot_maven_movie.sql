-- Pivoting data with count and case:

select
	film_id, -- aggrigator
    count(
    case
		when store_id = 1 then inventory_id
		else null
		end
    ) as store_1_count, -- agregated value
    count(
    case
		when store_id = 2 then inventory_id
        else null
        end
	) as store_2_count -- agregated value
from inventory
	group by film_id
    order by film_id;
    
 -- OR: 
 select
	film_id, -- aggrigator
		count(case when store_id = 1 then inventory_id else null end) 
    as store_1_count, -- agregated value
		count(case when store_id = 2 then inventory_id else null end)
	as store_2_count -- agregated value
from inventory
	group by film_id
    order by film_id;

-- QUESTION:
-- I'm curious how many active and inactive customers I have at each store.
-- COuld you please create a table to count the number of customers broken down by store_id( in rows)
-- and active status and inactive status (in columns).

select
	store_id, -- aggregetor
		count(case when active=0 then customer_id else null end) 
	as inactive, 		-- aggregated values
		count(case when active=1 then customer_id else null end)
	as active 			-- aggregated value
from 
	customer
		group by store_id
        order by store_id;
## ANS:
##-- from the output table we can say that ....
##-- store_id-1: active 318 customers and inactive 8 customers. & 
##-- store_id-2: active 266 customers and inactive 7 customers.


-- QUESTION :
-- above same pivot table but pull it with first_name

select
	store_id, 				-- aggregator
		count(case when active = 0 then first_name else null end) as inactive,  -- aggregated value
		count(case when active = 1 then first_name else null end) as active		-- aggregated value
from 
	customer
		group by store_id
        order by store_id;


Select
	store_id, -- aggregator
    count(case when active = 0 then customer_id else null end ) as inactive, -- aggregated value
	count(case when active = 1 then customer_id else null end ) as active -- aggregated value
from customer
	group by store_id
    order by store_id;

----------------------------------------------------------------------------------------------

select 
	store_id,
	case when active = 0 then customer_id else null end as inactive,
    case when active = 1 then customer_id else null end as active
from customer;

-- ## ANSWER:
-- if we are not using()- parantheses it will give result for all customer with numbers.

-- QUESTION:
-- like above qus pull all data but this time pull first_name instead of customer_id: 

select 
	store_id,
	case when active = 0 then first_name else null end as inactive,
    case when active = 1 then first_name else null end as active
from customer;

##-- ANSER:
## as we can see output table we get all cutomer's first name in the table whather cutomer active or inactive.

-- QUESTION:
-- Pull the same data but this time count of store 1 and store 2 active and inactive:

select 
	store_id,
	count(case when active = 0 then first_name else null end) as inactive,
    count(case when active = 1 then first_name else null end) as active
from customer
	group by store_id;
    
    