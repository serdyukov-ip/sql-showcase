CREATE TABLE test_table (
    id SERIAL PRIMARY KEY,
    data VARCHAR(255)
);

/* ----------------- Фиксация транзакции ----------------- */
-- Добавляем 50 строк тестовых данных
INSERT INTO test_table (data)
SELECT 'Test data ' || generate_series(1, 50);

BEGIN;
-- Добавляем еще 50 строк тестовых данных
INSERT INTO test_table (data)
SELECT 'Additional test data ' || generate_series(51, 100);

-- Обновляем некоторые строки
UPDATE test_table SET data = 'Updated data' WHERE id BETWEEN 1 AND 50;

-- Фиксация транзакции 
COMMIT;


/* ----------------- Откат транзакции ----------------- */
BEGIN;

-- Допустим, что здесь произошла ошибка и мы хотим откатить изменения
UPDATE test_table SET data = 'Incorrect update' WHERE id = 1;

ROLLBACK;


/* ------------- Создание точки сохранения ------------ */
BEGIN;

INSERT INTO test_table (data) VALUES ('Savepoint test');

-- Создаем точку сохранения
SAVEPOINT my_savepoint;


INSERT INTO test_table (data) VALUES ('Another savepoint test');

-- Если что-то пошло не так, откатываемся к точке сохранения
ROLLBACK TO SAVEPOINT my_savepoint;

-- Фиксируем транзакцию
COMMIT;