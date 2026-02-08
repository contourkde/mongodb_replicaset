# Base image
FROM mongodb/mongodb-community-server:8.2.4-ubuntu2204

# Switch to root to perform setup
USER root

# Copy the initiation script into the container
COPY generate-keyfile.sh /generate-keyfile.sh

# Make the script executable
RUN chmod +x /generate-keyfile.sh

ARG REPLICA_SET_NAME

# Switch back to mongodb user
USER mongodb

ENTRYPOINT ["/bin/bash", "-c", "/generate-keyfile.sh && exec docker-entrypoint.sh mongod --replSet $REPLICA_SET_NAME --auth --keyFile /data/keyfile --ipv6 --bind_ip ::,0.0.0.0"]
