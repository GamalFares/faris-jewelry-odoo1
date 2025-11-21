FROM odoo:17.0

# Switch to root for setup
USER root

# Install necessary tools
RUN apt-get update && apt-get install -y postgresql-client

# Switch back to odoo user
USER odoo

# Copy startup script
COPY start.sh /app/
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]