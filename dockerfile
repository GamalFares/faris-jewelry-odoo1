FROM python:3.10-slim

WORKDIR /app

# Install system dependencies including backup tools
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    build-essential \
    python3-dev \
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    libpq-dev \
    postgresql-client \
    curl \
    cron \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Download Odoo 17.0
RUN wget -q https://github.com/odoo/odoo/archive/refs/heads/17.0.zip -O odoo.zip && \
    unzip -q odoo.zip && mv odoo-17.0/* . && rm -rf odoo-17.0 odoo.zip

COPY odoo.conf .
COPY start.sh .
COPY backup.sh .
RUN chmod +x start.sh backup.sh

# Setup backup cron job
RUN echo "0 2 * * * /app/backup.sh" | crontab -

RUN mkdir -p /tmp/odoo-data /app/backups

EXPOSE 8069

CMD ["./start.sh"]