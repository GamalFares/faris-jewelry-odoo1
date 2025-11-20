FROM odoo:17.0

# Install tools and SSL certificates
USER root
RUN apt-get update && apt-get install -y gettext-base postgresql-client ca-certificates
USER odoo

# Copy configuration
COPY odoo.conf /etc/odoo/

# Start Odoo with proper SSL handling
CMD ["sh", "-c", "envsubst < /etc/odoo/odoo.conf > /tmp/odoo.conf && /usr/bin/odoo --config=/tmp/odoo.conf --db-sslmode=require"]