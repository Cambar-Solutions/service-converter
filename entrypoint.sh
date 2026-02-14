#!/bin/bash
set -e

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput --clear

echo "Starting gunicorn on 0.0.0.0:8000..."
exec gunicorn --bind 0.0.0.0:8000 --workers 2 --timeout 120 --access-logfile - --error-logfile - config.wsgi:application
