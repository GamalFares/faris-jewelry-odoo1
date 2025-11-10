FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Download Odoo 17
RUN wget -q https://github.com/odoo/odoo/archive/refs/heads/17.0.zip -O odoo.zip && \
    unzip -q odoo.zip && \
    mv odoo-17.0/* . && \
    rm -rf odoo-17.0 odoo.zip

# Copy configuration
COPY odoo.conf .

EXPOSE 8069

CMD ["python", "odoo-bin", "-c", "odoo.conf", "--workers=1", "--without-demo=all"]