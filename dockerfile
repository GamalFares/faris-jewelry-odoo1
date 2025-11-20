FROM odoo:17.0

# Copy configuration and script
COPY odoo.conf /app/
COPY start.sh /app/

# Make script executable
RUN chmod +x /app/start.sh

WORKDIR /app
CMD ["/app/start.sh"]