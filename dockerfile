FROM odoo:17.0

USER root

# Remove ALL default configs
RUN rm -f /etc/odoo/odoo.conf

# Copy our configuration
COPY odoo.conf /etc/odoo/
COPY start.sh /start.sh
RUN chmod +x /start.sh

USER odoo

CMD ["/start.sh"]