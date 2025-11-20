FROM odoo:17.0

# Install envsubst for environment variable substitution
USER root
RUN apt-get update && apt-get install -y gettext-base
USER odoo

# Copy configuration
COPY odoo.conf /etc/odoo/

# Start Odoo with environment substitution
CMD ["sh", "-c", "envsubst < /etc/odoo/odoo.conf > /tmp/odoo.conf && /usr/bin/odoo --config=/tmp/odoo.conf"]