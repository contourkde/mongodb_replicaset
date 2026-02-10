# Base image
FROM mongodb/mongodb-community-server:8.2.4-ubuntu2204

# Copy the initiation script into the container
COPY --chown=mongodb:mongodb --chmod=755 generate-keyfile.sh /generate-keyfile.sh

ARG REPLICA_SET_NAME

ENTRYPOINT ["/bin/bash", "-c", "/generate-keyfile.sh && ( [ -f /usr/local/bin/docker-entrypoint.sh ] && exec /usr/local/bin/docker-entrypoint.sh mongod --replSet $REPLICA_SET_NAME --auth --keyFile /tmp/keyfile --ipv6 --bind_ip ::,0.0.0.0 || exec docker-entrypoint.sh mongod --replSet $REPLICA_SET_NAME --auth --keyFile /tmp/keyfile --ipv6 --bind_ip ::,0.0.0.0 )"]