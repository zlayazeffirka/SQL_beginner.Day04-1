create view v_price_with_discount as
select person.name as name,
	   menu.pizza_name as pizza_name,
	   menu.price as price,
	   cast(menu.price-menu.price*0.1 as int) as discount_price
from person_order
join person on person.id=person_order.person_id
join menu on menu.id=person_order.menu_id
order by name, pizza_name