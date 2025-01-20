FROM listmonk/listmonk:latest

# Set environment variable for database upgrade
ENV UPGRADE_LISTMONK_DATABASE=true

# Copy configuration files
COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
COPY config.toml /etc/listmonk/config.toml

# Make the entrypoint script executable
RUN chmod +x /bin/docker-entrypoint.sh

# Expose the web port
EXPOSE 9000

# Set the entrypoint
ENTRYPOINT ["/bin/sh"]
CMD ["/bin/docker-entrypoint.sh"]
