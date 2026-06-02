#!/bin/bash
set -e

DB_HOST="${DB_HOST:-db}"
DB_PORT="${DB_PORT:-5432}"

echo "Ожидание запуска PostgreSQL на $DB_HOST:$DB_PORT..."

# pg_isready не требует указания БД
until pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$POSTGRES_USER" 2>/dev/null; do
    echo "PostgreSQL еще не готов - ждем..."
    sleep 2
done

# Дополнительная проверка, что БД существует и работает
echo "PostgreSQL готов! Запускаем nginx..."
exec "$@"