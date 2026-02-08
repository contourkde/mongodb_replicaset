# Base image
FROM mongodb/mongodb-community-server:8.2.4-ubuntu2204

# Switch to root to perform setup and install dependencies
USER root

# Install gosu
RUN apt-get update && apt-get install -y gosu && rm -rf /var/lib/apt/lists/*

# Copy the initiation script into the container
COPY generate-keyfile.sh /generate-keyfile.sh

# Make the script executable
RUN chmod +x /generate-keyfile.sh

ARG REPLICA_SET_NAME

# We stay as root to allow the entrypoint script to chown/chmod
# The entrypoint script will switch to the mongodb user using gosu

ENTRYPOINT ["/generate-keyfile.sh"]
CMD ["bash", "-c", "exec mongod --replSet $REPLICA_SET_NAME --auth --keyFile /data/keyfile --ipv6 --bind_ip ::,0.0.0.0"]
