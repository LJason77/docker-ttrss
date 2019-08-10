#!/bin/sh
set -e

first=/var/lib/postgresql/data/first

if [ ! -f "$first" ] ; then
	chown -R postgres:postgres /var/lib/postgresql/data
    su - postgres -c "initdb /var/lib/postgresql/data"
	echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf
	echo "listen_addresses='*'" >> /var/lib/postgresql/data/postgresql.conf
	su - postgres -c "export PGDATA=/var/lib/postgresql/data && pg_ctl start && \
	psql --command \"CREATE USER docker WITH SUPERUSER PASSWORD 'docker';\" && \
	createdb -O docker docker && \
    pg_ctl stop"
    touch $first
fi

su - postgres -c "postgres -D /var/lib/postgresql/data -c config_file=/var/lib/postgresql/data/postgresql.conf 2>&1 &"

sleep 15

# remove trailing / if any.
SELF_URL_PATH=${SELF_URL_PATH/%\//}

# extract the root path from SELF_URL_PATH (i.e http://domain.tld/<root_path>).
ROOT_PATH=${SELF_URL_PATH/#http*\:\/\/*\//}
if [ "${ROOT_PATH}" == "${SELF_URL_PATH}" ]; then
    # no root path in SELF_URL_PATH.
    mkdir -p /var/tmp
    ln -sf "/var/www" "/var/tmp/www"
else
    mkdir -p /var/tmp/www
    ln -sf "/var/www" "/var/tmp/www/${ROOT_PATH}"
fi

php /var/configure-db.php
supervisord -c /var/supervisord.conf
