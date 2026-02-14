#!/bin/bash
set -e

# Run migrations
python manage.py migrate --noinput

# Collect static files
python manage.py collectstatic --noinput --clear

# Start gunicorn
exec gunicorn --bind 0.0.0.0:8000 --workers 2 --timeout 120 config.wsgi:application
