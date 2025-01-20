# Listmonk Dockerfile for Render
FROM listmonk/listmonk:latest

# Install wait-for-it script to check database connection
RUN apt-get update && apt-get install -y wait-for-it && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV UPGRADE_LISTMONK_DATABASE=true \
    DB_HOST=dpg-cu74ngbtq21c738ct6ug-a \
    DB_PORT=5432 \
    DB_USER=ssport_u3te_user \
    DB_PASSWORD=DuAh1HS6jg90ZVfk0oU1yYFSArXBRT6G \
    DB_NAME=ssport_u3te

# Create config directory
RUN mkdir -p /etc/listmonk

# Copy entrypoint script
COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh

# Expose the web port
EXPOSE 9000

# Start the application
CMD ["/bin/docker-entrypoint.sh"]