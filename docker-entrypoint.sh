#!/bin/sh
set -e

# Generate config.toml from environment variables
cat > /etc/listmonk/config.toml << EOF
[app]
address = "0.0.0.0:9000"
admin_username = "${ADMIN_USERNAME:-listmonk}"
admin_password = "${ADMIN_PASSWORD:-listmonk}"

[db]
host = "${DB_HOST}"
port = ${DB_PORT:-5432}
user = "${DB_USER}"
password = "${DB_PASSWORD}"
database = "${DB_NAME}"
ssl_mode = "require"
max_open = 25
max_idle = 25
max_lifetime = "300s"
EOF

# Define wrapper function
listmonk_wrapper() {
  ./listmonk --yes --config /etc/listmonk/config.toml $@
}

# Wait for database to be ready
wait-for-it "${DB_HOST}:${DB_PORT}" -t 60

# Initialize and upgrade database if needed
listmonk_wrapper --install --idempotent

if [ "$UPGRADE_LISTMONK_DATABASE" = "true" ]; then
  listmonk_wrapper --upgrade
fi

# Start listmonk
exec listmonk_wrapper
