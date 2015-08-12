#!/bin/bash -e

ROOT=/srv/posty_api

DB_ADAPTER=${DB_ADAPTER:-mysql2}
DB_ENCODING=${DB_ENCODING:-utf8}
DB_USER=${DB_USER:-root}
DB_PASS=${DB_PASS:-root}
DB_NAME=${DB_NAME:-posty}
DB_HOST=${DB_HOST:-mysql-server}
DB_PORT=${DB_PORT:-3306}

cd $ROOT
cat << EOF > config/database.yml
production:
 adapter: $DB_ADAPTER
 encoding: $DB_ENCODING
 database: $DB_NAME
 username: $DB_USER
 password: $DB_PASS
 host: $DB_HOST
 port: $DB_PORT
EOF

rake db:migrate
rake api_key:generate

rackup -p 9292
