FROM odoo:17.0

# Copy configuration file with hardcoded password (TEMPORARY)
COPY odoo.conf /etc/odoo/

# Use Odoo's default command
CMD ["/usr/bin/odoo", "--config=/etc/odoo/odoo.conf"]