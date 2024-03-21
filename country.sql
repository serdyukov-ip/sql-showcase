-- Выполняем команды с учетки суперпользователя или владельца базы данных.
-- Создаем новую роль
CREATE ROLE new_user WITH LOGIN PASSWORD 'password';

-- Предоставляем права на чтение таблицы новой роли
GRANT SELECT ON countries TO new_user;

-- Проверяем права доступа новой роли.
-- Нужно подключиться к БД с пользователем 'new_user' и паролем 'password'
SELECT * FROM countries; -- Должен работать, так как у новой роли есть права на чтение таблицы

-- заходим обратно под учетку админа
-- Отменяем права доступа новой роли
REVOKE SELECT ON countries FROM new_user;

-- Удаляем роль
DROP ROLE new_user;