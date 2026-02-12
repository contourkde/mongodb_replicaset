# Base image
FROM mongodb/mongodb-community-server:8.2.4-ubuntu2204

# Copy the initiation script into the container
COPY --chown=mongodb:mongodb --chmod=755 generate-keyfile.sh /generate-keyfile.sh

# Switch to root to fix permissions at runtime
USER root

# Install gosu for easy step-down from root
RUN apt-get update && apt-get install -y gosu && rm -rf /var/lib/apt/lists/*

# Fix home directory permissions
RUN mkdir -p /home/mongodb && chown -R mongodb:mongodb /home/mongodb

ARG REPLICA_SET_NAME

ENTRYPOINT ["/bin/bash", "-c", "/generate-keyfile.sh && exec gosu mongodb python3 /usr/local/bin/docker-entrypoint.py mongod --replSet $REPLICA_SET_NAME --keyFile /tmp/keyfile --ipv6 --bind_ip ::,0.0.0.0"]