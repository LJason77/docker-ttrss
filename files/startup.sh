#!/bin/sh
set -e

while ! pg_isready -h $TTRSS_DB_HOST -U $TTRSS_DB_USER; do
	echo 等待数据库 $TTRSS_DB_HOST ...
	sleep 3
done

DST_DIR=/var/tt-rss

export PGPASSWORD=$TTRSS_DB_PASS
PSQL="psql -q -h $TTRSS_DB_HOST -U $TTRSS_DB_USER $TTRSS_DB_NAME"

$PSQL -c "create extension if not exists pg_trgm"

RESTORE_SCHEMA=${SCRIPT_ROOT}/restore-schema.sql.gz

if [ -r $RESTORE_SCHEMA ]; then
	zcat $RESTORE_SCHEMA | $PSQL
elif ! $PSQL -c 'select * from ttrss_version'; then
	$PSQL < /var/tt-rss/schema/ttrss_schema_pgsql.sql
fi

supervisord -c /var/supervisord.conf
