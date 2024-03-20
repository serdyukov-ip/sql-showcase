# Используем официальный образ PostgreSQL
FROM postgres:latest

# Устанавливаем переменные окружения для PostgreSQL
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=sql-showcase

# Экспортируем порт для PostgreSQL
EXPOSE 5432

# Копируем скрипт запуска в контейнер
COPY init.sql /docker-entrypoint-initdb.d/

# Запускаем PostgreSQL
CMD ["postgres"]