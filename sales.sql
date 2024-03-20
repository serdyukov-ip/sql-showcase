-- при использовании Docker образа таблица будет создана автоматически
CREATE TABLE SALES
(
    PRODUCT_GROUP   VARCHAR(50),
    ITEM            VARCHAR(50),
    SOLD            DATE,
    UNITS           INT,
    PRICE           DECIMAL(12,2) 
);

-- Заполнение таблицы данными
INSERT INTO SALES (PRODUCT_GROUP, ITEM, SOLD, UNITS, PRICE) 
VALUES 
('Accessories', 'Bag', TO_DATE('2016-09-01', 'YYYY-MM-DD'), 1, 1.00),
('Accessories', 'Cable', TO_DATE('2016-09-02', 'YYYY-MM-DD'), 4, 5.00)
/* далее добавляется массив данных */;


/* Выбирает группу товаров, товар, количество записей, сумму единиц и сумму цен за единицу для каждой группы товаров и товара.
   Результаты сортируются по группе товаров и товару. */
SELECT s.PRODUCT_GROUP,  
       s.ITEM, 
       count(*) AS "Count",  
       sum(s.UNITS) AS "Sum Units",  
       sum(s.UNITS * s.PRICE) AS "Sum Value"  
FROM SALES s 
GROUP BY s.PRODUCT_GROUP, s.ITEM 
ORDER BY s.PRODUCT_GROUP, s.ITEM;

/* Выбирает месяц продажи, количество записей, сумму единиц и сумму цен за единицу для каждого месяца, начиная с 2016-10-01.
   Результаты сортируются по месяцу продажи. */
SELECT date_trunc('month', s.SOLD) AS MONAT,
       count(*) AS "Count", 
       sum(s.UNITS) AS "Sum Units", 
       sum(s.UNITS * s.PRICE) AS "Sum Value" 
FROM SALES s
WHERE s.SOLD >= TO_DATE('2016-10-01', 'YYYY-MM-DD')
GROUP BY date_trunc('month', s.SOLD) 
ORDER BY date_trunc('month', s.SOLD);

/* Выбирает группу товаров, товар, месяц продажи, количество записей, сумму единиц и сумму цен за единицу для каждой группы товаров, 
   товара и месяца, где товар не является смартфона, и сумма цен за единицу больше 1000.
   Результаты сортируются по группе товаров, товару и месяцу продажи. */
SELECT s.PRODUCT_GROUP,   
       s.ITEM,  
       date_trunc('month', s.SOLD) AS MONAT,  
       count(*) AS "Count",   
       sum(s.UNITS) AS "Sum Units",   
       sum(s.UNITS * s.PRICE) AS "Sum Value"   
FROM SALES s  
WHERE s.ITEM != 'Smartphone'     
GROUP BY s.PRODUCT_GROUP, s.ITEM, date_trunc('month', s.SOLD)    
HAVING sum(s.UNITS * s.PRICE) > 1000  
ORDER BY s.PRODUCT_GROUP, s.ITEM, date_trunc('month', s.SOLD);

/* Выбирает группу товаров, товар, месяц продажи, количество записей, сумму единиц и максимальную цену за единицу для каждой группы товаров, 
   товара и месяца, где сумма цен за единицу больше или равна 200000, или сумма единиц больше 30, или количество записей больше 5.
   Результаты сортируются по группе товаров, товару и месяцу продажи. */
SELECT s.PRODUCT_GROUP,   
       s.ITEM,  
       date_trunc('month', s.SOLD) AS MONAT,  
       count(*) AS "Count",   
       sum(s.UNITS) AS "Sum Units",   
       max(s.UNITS * s.PRICE) AS "Sum Value"   
FROM SALES s 
GROUP BY s.PRODUCT_GROUP, s.ITEM, date_trunc('month', s.SOLD)    
HAVING sum(s.UNITS * s.PRICE) >= 200000 
   OR sum(s.UNITS) > 30 
   OR count(*) > 5 
ORDER BY s.PRODUCT_GROUP, s.ITEM, date_trunc('month', s.SOLD);