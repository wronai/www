# Use Python 3.10 slim image as base
FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    jq \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install Python tools
RUN pip install --no-cache-dir pipx && \
    pipx ensurepath && \
    pipx install pipenv

# Set working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the analysis scripts
COPY analyze_repo.py .
COPY update_repo_data.py .

# Set the entrypoint
ENTRYPOINT ["python", "analyze_repo.py"]
