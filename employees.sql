CREATE TABLE employees
( 
    employee_id    INTEGER,
    first_name     VARCHAR(20),
    last_name      VARCHAR(25) NOT NULL,
    email          VARCHAR(25) NOT NULL,
    phone_number   VARCHAR(20),
    hire_date      DATE NOT NULL,
    job_id         VARCHAR(10) NOT NULL,
    salary         DECIMAL(8,2) CHECK (salary > 0),
    commission_pct DECIMAL(2,2),
    manager_id     DECIMAL(6),
    department_id  DECIMAL(4)
);

INSERT INTO employees 
VALUES     
( 100, 'Steven', 'King', 'SKING', '515.123.4567', TO_DATE('17-06-2003', 'dd-MM-yyyy'), 'AD_PRES', 24000, NULL, NULL, 90),
( 101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', TO_DATE('21-09-2005', 'dd-MM-yyyy'), 'AD_VP', 17000, NULL, 100, 90)
/* далее добавляется массив данных */;

-- Переменные и вывод текущей даты
DO $$
DECLARE
    l_today date := current_date;
BEGIN
    RAISE NOTICE 'today is %', to_char(l_today, 'Day');
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'An error occurred: %', SQLERRM;
END $$;

-- Условная логика
DO $$
DECLARE
    l_today date := current_date;
BEGIN
    IF to_char(l_today, 'D')::integer < 4 THEN
        RAISE NOTICE 'Have a wonderful week';
    ELSE
        RAISE NOTICE 'Enjoy the rest of the week';
    END IF;
    RAISE NOTICE 'today is % day % of the week.', to_char(l_today, 'Day'), to_char(l_today, 'D');
END $$;

-- Статический SQL. Считаем кол-во публичных таблиц
DO $$
DECLARE
    howmany integer;
    num_tables integer;
BEGIN
    SELECT COUNT(*) INTO howmany
    FROM information_schema.tables
    WHERE table_schema = 'public'; -- Check number of tables
    num_tables := howmany;       -- Compute another value
    RAISE NOTICE 'Number of public tables: %', num_tables;
END $$;

-- Динамический SQL 
-- (Функция для кода ниже)
CREATE OR REPLACE FUNCTION count_rows(table_name text) RETURNS integer AS $$
DECLARE
    row_count integer;
BEGIN
    EXECUTE format('SELECT COUNT(*) FROM %I', table_name) INTO row_count;
    RETURN row_count;
END;
$$ LANGUAGE plpgsql;

-- Считаем кол-во строк в публичных таблицах
DO $$
DECLARE
    l_table_count integer := 0;
    l_table_name text;
    l_row_count integer;
BEGIN
    FOR l_table_name IN SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' ORDER BY 1 LOOP
        l_table_count := l_table_count + 1;
        l_row_count := count_rows(l_table_name); -- для этого кода нужно создать функцию count_rows
        RAISE NOTICE '% - % rows', l_table_name, l_row_count;
    END LOOP;
    IF l_table_count = 0 THEN
        RAISE NOTICE 'You have no tables in your schema';
    END IF;
END $$;