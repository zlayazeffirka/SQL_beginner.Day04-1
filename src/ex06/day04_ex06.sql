create materialized view mv_dmitriy_visits_and_eats AS
select pizzeria.name
from person_order
left join person on person.id=person_order.person_id
left join menu on menu.id=person_order.menu_id
left join pizzeria on pizzeria.id=menu.pizzeria_id
where person.name='Dmitriy' and
person_order.order_date='2022-01-08' and
menu.price<'800'