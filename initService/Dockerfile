# Base image
FROM mongodb/mongodb-community-server:8.2.4-ubuntu2204

# Install curl
USER root
RUN apt-get update && apt-get install -y curl
USER mongodb

# Copy the initiation script into the container
COPY --chmod=755 initiate-replica-set.sh /initiate-replica-set.sh

# Set the entrypoint to the initiation script
ENTRYPOINT ["/bin/bash", "/initiate-replica-set.sh"]