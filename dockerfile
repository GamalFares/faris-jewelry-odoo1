FROM odoo:17.0

# Switch to root to copy files
USER root

# Copy your configuration files
COPY odoo.conf /etc/odoo/
COPY start.sh /app/
COPY backup.sh /app/

# Make scripts executable (as root)
RUN chmod +x /app/start.sh /app/backup.sh

# Setup cron for backups
RUN echo "0 2 * * * /app/backup.sh" | crontab -

# Create necessary directories
RUN mkdir -p /tmp/odoo-data /app/backups

# Switch back to odoo user for security
USER odoo

WORKDIR /app
CMD ["./start.sh"]