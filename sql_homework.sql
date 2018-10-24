use sakila;

#1a
select first_name, last_name from actor;

#1b
SELECT upper(CONCAT(first_name, last_name)) AS first_last FROM actor;

#2a
select 
	actor_id,
    first_name,
    last_name
from 
	actor
where
	first_name = "Joe";
 
 #2b
select
	first_name,
    last_name
from 
	actor
where
	last_name like "%Gen%";

#2c
select
	first_name,
    last_name
from
	actor
where
	last_name like "%li%"
order by last_name, first_name
;

#2d
select 
	country_id,
    country
from 
	country
where 
	country in ("Afghanistan", "Bangladesh", "China")
;

#3a
alter table actor
add description varchar(50);

#3b
alter table actor
drop column description;

#4a
select 	
	last_name,
    count(last_name) as count
from 
	actor
group by 
	last_name;
 
 #4b
select 	
	last_name,
    count(last_name) as total
from 
	actor
group by 
	last_name
having
	total >2;

#4c
select
	first_name,
    last_name,
    actor_id
from 
	actor
where 
	first_name = "groucho" and last_name = "williams";
 
update actor
set first_name = "Harpo"
where
	actor_id = 172;
    
 #4d
update actor set first_name = "Groucho" where actor_id = 172;

#5a
show create table address;

#6a
SELECT staff.first_name, staff.last_name, address.address, address.city_id, address.postal_code
FROM staff
INNER JOIN address ON staff.address_id=address.address_id;

#6b
select staff.first_name, staff.last_name, sum(payment.amount) as total_payment
from staff
inner join payment on staff.staff_id=payment.staff_id
group by staff.last_name;

#6c
select film.title, count(film_actor.actor_id) as number_of_actors
from film
inner join film_actor on film.film_id=film_actor.film_id
group by film.title;

#6d
select
	film_id
from
	film
where
	title = "Hunchback Impossible";
    
select
	title,
    count(film_id) as copies
from 
	film
where
	film_id in (
		select 
			film_id
		from
			inventory
		where
			film_id = 439
		)
;

#6e
select 
	customer.first_name, customer.last_name, sum(payment.amount) as total_payment
from customer
inner join payment on customer.customer_id=payment.customer_id
group by customer.last_name
order by customer.last_name; 

#7a
select title from film
where title like "Q%" or  title like "K%";

#7b
select 
	first_name,
    last_name
from 
	actor
where actor_id in(
	select
		actor_id
	from
		film_actor
	where film_id in(
		select
			film_id
		from 
			film
		where
			title = "Alone Trip"
		)
	)
;

#7c
select 
	customer.first_name, customer.last_name, customer.email, country.country 
from customer
inner join address on customer.address_id=address.address_id
inner Join city on address.city_id=city.city_id	
inner join country on city.country_id=country.country_id 
group by customer.last_name
having country.country = "Canada"; 

#7d
select
	name,
    category_id
from 
	category
where
	name = "family";

select
	title
from
	film
where
	film_id in(
		select film_id
		from film_category
        where category_id = 8
        )
;

#7e
select film.title, count(rental.rental_id) as total
from film
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.rental_id
group by title
order by total desc;		

#7f
select store.store_id, sum(payment.amount) as total_revenue
from store
inner join staff on store.store_id = staff.store_id
inner join payment on staff.staff_id = payment.staff_id
group by store_id;

#7g
select store.store_id, city.city, country.country
from store
inner join address on store.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
group by country;

#7h8a
create view top_revenue_category
as select category.name, sum(payment.amount) as total_revenue
from category
inner join film_category on category.category_id = film_category.category_id
inner join inventory on film_category.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join payment on rental.rental_id = payment.rental_id
group by name
order by total_revenue desc
limit 5;

#8b
select * from top_revenue_category;

#8c
drop view top_revenue_category;


