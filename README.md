# SQL Showcase

## Содержание
- [О проекте](#о-проекте)
- [Тестирование](#тестирование)
- [ERD](#erd)
- [Контакты](#контакты)

## О проекте

Этот репозиторй создан, чтобы показать мои навыки владения SQL. В проекте используетcя PostgreSQL.
Для удобства изучения материал разбит по разным файлам.

DML:
- sales.sql - в файле представлена работа с агрегацией, группировкой и сортировкой данных (GROUP BY, HAVING, ORDER BY)
- cars.sql - в файле представлена работа с подзапросами и запросами объединяющими множество таблиц(Inner Join, Left Join, Full Join)
- orders.sql - в файле представлена работа с оконными функциями (ROW_NUMBER, LEAD, RANK)
- olympic-medal-winners.sql - в файле представлена работа со сводными таблицами (PIVOT, UNPIVOT)
- employees.sql - в файле представлена работа с PL/SQL скриптами

DDL:
- cards-watcher.sql - в файле представлена работа по проектированию БД (Ключи, Отношения между таблицами, Каскадирование)
- people.sql - в файле представлена работа с триггерами и функциями (TRIGGER, FUNCTION)

DCL:
- country.sql - в файле представлена работа с управлением ролями (CREATE/DROP ROLE, GRANT, REVOKE)

TCL:
- transaction.sql - в файле представлена работа с операторами для управления транзакциями (COMMIT, ROLLBACK, SAVE, BEGIN)

## Тестирование

К тестированию скриптов можно приступить, если провести настройку одним из двух способов:
- Запустить Docker контейнер в котором инициализированы все необходимые скрипты
- Использовать уже имеющуюся у вас базу данных самостоятельно выполнить скритпы из файла Docker/init.sql

Далее описан процесс развертывания Docker контейнера:
1. Склонируйте репозиторий:
```bash
git clone https://github.com/serdyukov-ip/sql-showcase.git
```
2. Откройте командную строку и зайдите в папку ./Docker
3. Выполните сборку и дождитесь создания image:
```dockerfile
docker build -t my-postgres .
```
4. Запустите контейнер:
```dockerfile
docker run -d --name my-postgres -p 5432:5432 my-postgres
```
Контейнер будет доступен по параметрам host:localhost port:5432 user:postgres pass:postgres
Можно подключиться к контейнеру PostgreSQL c любого удобного db клиента или последовательно выполнив команды через terminal/cmd:
```dockerfile
docker exec -it my-postgres bash
```
```dockerfile
psql -U postgres -d sql-showcase
```
Теперь вы можете выполнять SQL-запросы к базе данных из terminal/cmd. Например:
```dockerfile
SELECT * FROM EMPLOYEES;
```

## ERD
![ERD](https://github.com/serdyukov-ip/cards-watcher/assets/53144887/4225af64-ff3b-4f51-9683-e30ee90aaa2b)

## Контакты

- Email: serdyukov-ip@yandex.ru
- Telegram: @IlyaJavaDev
