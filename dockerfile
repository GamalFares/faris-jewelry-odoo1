FROM odoo:17.0

# Stay as root for entire setup
USER root

# Install necessary tools
RUN apt-get update && apt-get install -y postgresql-client

# Copy and make script executable as root
COPY start.sh /app/
RUN chmod +x /app/start.sh

# Switch to odoo user ONLY for running the app
USER odoo

CMD ["/app/start.sh"]