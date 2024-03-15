FROM python:3.11-slim


# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Download NLTK stopwords
RUN python -m nltk.downloader stopwords

# Download spaCy model
RUN python -m spacy download en_core_web_sm

# Copy the rest of the application code into the container
COPY . .

# Expose the port your app runs on
EXPOSE 8501

# Command to run Streamlit
CMD ["streamlit", "run", "__init__.py"]