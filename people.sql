-- при использовании Docker образа таблица будет создана автоматически
CREATE TABLE people (
   name VARCHAR(100),
   age INTEGER,
   height INTEGER
);

INSERT INTO people VALUES ('Polly', 18, 10);
INSERT INTO people VALUES ('Molly', 25, 60);
INSERT INTO people VALUES ('Golly', 30, 60);

-- Функция будет отрабатывать при использовании триггера
CREATE OR REPLACE FUNCTION show_trigger_event()
RETURNS TRIGGER AS $$
BEGIN
   RAISE NOTICE '%',
   CASE
      WHEN TG_OP = 'UPDATE' THEN 'UPDATE'
      WHEN TG_OP = 'INSERT' THEN 'INSERT'
      WHEN TG_OP = 'DELETE' THEN 'DELETE'
      ELSE 'Procedure not executed from DML trigger!'
   END;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- триггер отработает при добавлении/удалении записей из people
CREATE TRIGGER employee_changes_after
AFTER INSERT OR UPDATE ON people
FOR EACH ROW EXECUTE FUNCTION show_trigger_event();

-- триггер отработает при удалении записей из people
CREATE TRIGGER employee_changes_before
BEFORE DELETE ON people
FOR EACH ROW EXECUTE FUNCTION show_trigger_event();

-- тестирование работы триггеров и функции
UPDATE people SET name = UPPER(name);
UPDATE people SET age = age * 10 WHERE height = 60;
DELETE FROM people WHERE height = 60;
INSERT INTO people (name, age, height) VALUES ('Feuerstein', 1000000, 10);