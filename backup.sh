#!/bin/bash
set -e

# Backup configuration
BACKUP_DIR="/app/backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_${DATE}.sql"

echo "Starting Odoo database backup..."

# Create backup using pg_dump
pg_dump \
    -h "$PGHOST" \
    -p "$PGPORT" \
    -U "$PGUSER" \
    -d "$PGDATABASE" \
    -f "$BACKUP_FILE"

echo "Backup created: $BACKUP_FILE"

# Compress backup
gzip "$BACKUP_FILE"
echo "Backup compressed: ${BACKUP_FILE}.gz"

# Keep only last 7 days of backups
find "$BACKUP_DIR" -name "backup_*.sql.gz" -mtime +7 -delete
echo "Old backups cleaned up"

echo "Backup completed successfully"