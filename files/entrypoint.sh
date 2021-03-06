#!/bin/bash 

set -x

if [[ $@ == *"gunicorn"* || $@ == *"runserver"* ]]; then
    if [ -f ${DJANGO_ROOT}/${PROJECT_NAME}/manage.py ]; then
        /usr/bin/wait_on_postgres.py 
        if [ "$?" == "0" ]; then
            /usr/bin/manage_django.sh makemigrations --noinput
            /usr/bin/manage_django.sh migrate --fake-initial --noinput           
        fi
    fi
fi

exec "$@"