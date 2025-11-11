FROM odoo:17.0

USER root

# Install additional dependencies if needed
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy custom configuration
COPY odoo.conf /etc/odoo/
COPY start.sh /start.sh
RUN chmod +x /start.sh

USER odoo

CMD ["/start.sh"]