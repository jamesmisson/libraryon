FROM openjdk:17-slim

# Install wget and unzip
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

# Download and install Cantaloupe
WORKDIR /opt
RUN wget https://github.com/cantaloupe-project/cantaloupe/releases/download/v5.0.7/cantaloupe-5.0.7.zip && \
    unzip cantaloupe-5.0.7.zip && \
    rm cantaloupe-5.0.7.zip && \
    mv cantaloupe-5.0.7 cantaloupe

# Create cache directory
RUN mkdir -p /var/cache/cantaloupe

WORKDIR /opt/cantaloupe

# Copy config file
COPY cantaloupe.properties ./cantaloupe.properties

# Expose port (Render will assign its own, but we'll use this internally)
EXPOSE 8182

# Run Cantaloupe
CMD ["java", "-Dcantaloupe.config=./cantaloupe.properties", "-Xmx2g", "-jar", "cantaloupe-5.0.7.jar"]