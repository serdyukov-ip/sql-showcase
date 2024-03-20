# Используем официальный образ PostgreSQL
FROM postgres:latest

# Устанавливаем переменные окружения для PostgreSQL
ENV POSTGRES_USER=your_username
ENV POSTGRES_PASSWORD=your_password
ENV POSTGRES_DB=your_database

# Экспортируем порт для PostgreSQL
EXPOSE 5432

# Копируем скрипт запуска в контейнер
COPY init.sql /docker-entrypoint-initdb.d/

# Запускаем PostgreSQL
CMD ["postgres"]