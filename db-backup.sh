#!/bin/bash

# --- CONFIG ---
USER="postgres"
PASSWORD='Kh!fas$Lz*I28Qa]?csg*Nw#$4pf'
DBNAME="power_app"
HOST="localhost"
PORT=5437
BACKUP_DIR="/var/www/db-backup"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
FILENAME="${DBNAME}.sql"
GZ_FILENAME="${FILENAME}.gz"

# --- ENV ---
export PGPASSWORD="$PASSWORD"

#echo "User: $USER"
#echo "Password: $PASSWORD"
#echo "PGPASSWORD: $PGPASSWORD"

# --- DUMP + COMPRESS ---
pg_dump -U "$USER" -h "$HOST" -p "$PORT" "$DBNAME" -F p -f "$BACKUP_DIR/$FILENAME"
gzip -f "$BACKUP_DIR/$FILENAME"

# --- GIT PUSH ---
cd "$BACKUP_DIR"
git add "$GZ_FILENAME"
git commit -m "DB Backup: ${TIMESTAMP}"
git push origin main  # Change to your branch name if needed