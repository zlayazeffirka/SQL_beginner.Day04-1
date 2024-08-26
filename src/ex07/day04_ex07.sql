
SELECT id FROM person WHERE name = 'Dmitriy';
SELECT name FROM mv_dmitriy_visits_and_eats;

SELECT p.id, p.name FROM pizzeria p
JOIN menu m ON p.id = m.pizzeria_id
WHERE m.price < 800
AND p.name NOT IN (
    SELECT name FROM mv_dmitriy_visits_and_eats
)
LIMIT 1;
SELECT id, pizza_name, price FROM menu
WHERE pizzeria_id = (
    SELECT p.id FROM pizzeria p
    JOIN menu m ON p.id = m.pizzeria_id
    WHERE m.price < 800
    AND p.name NOT IN (
        SELECT name FROM mv_dmitriy_visits_and_eats
    )
    LIMIT 1
)
AND price < 800
LIMIT 1;

INSERT INTO person_order (id, person_id, menu_id, order_date)
VALUES (
    (SELECT MAX(id) + 1 FROM person_order),
    (SELECT id FROM person WHERE name = 'Dmitriy'),
    (SELECT id FROM menu
     WHERE pizzeria_id = (
         SELECT p.id FROM pizzeria p
         JOIN menu m ON p.id = m.pizzeria_id
         WHERE m.price < 800
         AND p.name NOT IN (
             SELECT name FROM mv_dmitriy_visits_and_eats
         )
         LIMIT 1
     ) AND price < 800
     LIMIT 1),
    '2022-01-08'
);

REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;
