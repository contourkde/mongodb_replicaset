# Base image
FROM mongodb/mongodb-community-server:8.2.4-ubuntu2204

# Switch to root to install dependencies
USER root

# Install curl
RUN apt-get update && apt-get install -y curl

# Copy the initiation script into the container
COPY --chmod=755 initiate-replica.sh /initiate-replica.sh

# Switch back to mongodb user - SKIPPED to allow permissions on init
# USER mongodb

# Set the entrypoint to the initiation script
ENTRYPOINT ["/bin/bash", "/initiate-replica.sh"]