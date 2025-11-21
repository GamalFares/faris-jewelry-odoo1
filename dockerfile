FROM odoo:17.0

# Install PostgreSQL client for testing
USER root
RUN apt-get update && apt-get install -y postgresql-client
USER odoo

COPY start.sh /app/
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]