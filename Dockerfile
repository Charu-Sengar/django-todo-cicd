FROM python:3

# Set working directory inside the container
WORKDIR /data

# Install system dependencies (fixes 'distutils' error)
RUN apt-get update && apt-get install -y python3-distutils

# Copy requirements first (optional: improves Docker cache)
COPY requirements.txt .

# Install Django and other Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your project files
COPY . .

# Run Django DB migrations during container start (not during build)
EXPOSE 8000

# Run migrations and then start the Django server
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
