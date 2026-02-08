# Base image
FROM mongodb/mongodb-community-server:8.2.4-ubi9

# Install curl
RUN yum install -y curl

# Copy the initiation script into the container
COPY --chmod=755 initiate-replica-set.sh /initiate-replica-set.sh

# Set the entrypoint to the initiation script
ENTRYPOINT ["/bin/bash", "/initiate-replica-set.sh"]