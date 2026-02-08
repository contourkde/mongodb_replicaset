# Base image
FROM mongodb/mongodb-community-server:8.2.4-ubuntu2204

# Install curl
RUN apt-get update && apt-get install -y curl

# Copy the initiation script into the container
COPY --chmod=755 initiate-replica.sh /initiate-replica.sh

# Set the entrypoint to the initiation script
ENTRYPOINT ["/bin/bash", "/initiate-replica.sh"]