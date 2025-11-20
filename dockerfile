FROM odoo:17.0

# Copy only the configuration file
COPY odoo.conf /etc/odoo/

# Use Odoo's default command (no custom start.sh)
CMD ["/usr/bin/odoo", "--config=/etc/odoo/odoo.conf"]