FROM odoo:17.0

# Switch to root to set permissions
USER root

# Install PostgreSQL client for testing
RUN apt-get update && apt-get install -y postgresql-client

# Copy and make script executable as root
COPY start.sh /app/
RUN chmod +x /app/start.sh

# Switch back to odoo user for security
USER odoo

CMD ["/app/start.sh"]