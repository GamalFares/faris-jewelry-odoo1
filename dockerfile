FROM odoo:17.0

# Switch to root to copy files
USER root

# Copy your configuration files
COPY odoo.conf /etc/odoo/
COPY start.sh /app/

# Make script executable
RUN chmod +x /app/start.sh

# Create necessary directories
RUN mkdir -p /tmp/odoo-data

# Switch back to odoo user for security
USER odoo

WORKDIR /app
CMD ["./start.sh"]