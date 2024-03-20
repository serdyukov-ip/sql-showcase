-- при использовании Docker образа таблица будет создана автоматически
CREATE TABLE orders (
    order_id INT,
    status_date DATE,
    status VARCHAR(20)
);

insert into orders values 
(11700, date '2016-01-03', 'New'),
(11700, date '2016-01-04', 'Inventory Check')
/* далее добавляется массив данных */;

-- Выборка предыдущего статуса для каждого заказа
SELECT 
  order_id,
  status_date,
  status,
  LAG(status, 1) OVER (PARTITION BY order_id ORDER BY status_date) AS lag_status
FROM ORDERS
ORDER BY order_id, status_date;

-- Выборка предыдущего и следующего статусов для каждого заказа
SELECT 
  order_id,
  status_date,
  status,
  LAG(status, 1) OVER (PARTITION BY order_id ORDER BY status_date) AS lag_status,
  LEAD(status, 1) OVER (PARTITION BY order_id ORDER BY status_date) AS lead_status
FROM ORDERS
ORDER BY order_id, status_date;

-- Выборка предыдущего и следующего статусов и дат для каждого заказа
SELECT 
  order_id,
  status_date,
  status,
  LAG(status) OVER (PARTITION BY order_id ORDER BY status_date) AS lag_status,
  LEAD(status) OVER (PARTITION BY order_id ORDER BY status_date) AS lead_status,
  LAG(status_date) OVER (PARTITION BY order_id ORDER BY status_date) AS lag_status_date,
  LEAD(status_date) OVER (PARTITION BY order_id ORDER BY status_date) AS lead_status_date
FROM ORDERS
ORDER BY order_id, status_date;

-- Выборка изменений статусов с указанием даты начала и окончания
WITH StatusChanges AS (
  SELECT 
    order_id,
    status_date,
    status,
    LAG(status) OVER (PARTITION BY order_id ORDER BY status_date) AS lag_status,
    LEAD(status) OVER (PARTITION BY order_id ORDER BY status_date) AS lead_status
  FROM ORDERS
)
SELECT 
  order_id,
  lag_status AS status,
  LAG(status_date) OVER (PARTITION BY order_id ORDER BY status_date) AS from_date,
  status_date AS to_date
FROM StatusChanges
WHERE lag_status IS NULL
   OR lead_status IS NULL
   OR lead_status <> status
ORDER BY order_id, from_date NULLS FIRST;

-- Выборка изменений статусов с указанием даты начала и окончания
WITH StatusChanges AS (
  SELECT 
    order_id,
    status_date,
    status,
    LAG(status) OVER (PARTITION BY order_id ORDER BY status_date) AS lag_status,
    LEAD(status) OVER (PARTITION BY order_id ORDER BY status_date) AS lead_status
  FROM ORDERS
)
SELECT 
  order_id,
  lag_status AS status,
  LAG(status_date) OVER (PARTITION BY order_id ORDER BY status_date) AS from_date,
  status_date AS to_date
FROM StatusChanges
WHERE lag_status IS NULL
   OR lead_status IS NULL
   OR lead_status <> status
ORDER BY order_id, from_date NULLS FIRST;