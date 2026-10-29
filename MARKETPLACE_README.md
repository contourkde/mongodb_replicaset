# Deploy and Host MongoDB Community Server Replica Set with Railway

This template deploys a three-member MongoDB Community Server replica set (Primary-Secondary-Secondary) on Railway's private network, with keyfile authentication between members, root credentials generated at deploy time, and a persistent volume on every node.

## About Hosting MongoDB Community Server Replica Set

Hosting MongoDB as a replica set on Railway gives you automated failover: if the primary node goes down, the remaining members elect a new primary within seconds. The template creates four services:

- **mongo1, mongo2, mongo3** — data-bearing replica set members (MongoDB Community Server 8.2), each with a Railway Volume mounted at `/data/db` so data survives restarts and redeployments. Members authenticate to each other with a keyfile and accept the root user created at deployment.
- **Init Replica Set** — an ephemeral service that waits for all three nodes, runs `rs.initiate()` with the members' private hostnames, and exits. Delete it after the first successful deployment.

Applications inside the same Railway project connect with `REPLICA_SET_PRIVATE_URI` (exposed on each mongo service) for native driver-level failover. External clients connect through the TCP proxy with `MONGO_URL`.

## Why Deploy MongoDB Replica Set on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically scale it.

By deploying MongoDB Community Server Replica Set on Railway, you get a production-grade replica set with automatic failover, per-node persistent volumes, private-network replication traffic, and generated credentials — no cluster administration required.

## Common Use Cases

- **High-availability production backends**: keep mission-critical applications online through node failures with automatic primary election.
- **Change streams and transactions**: multi-document ACID transactions and change streams require a replica set — this template gives you one out of the box.
- **Read scaling**: direct secondary-preferred reads to replica nodes to offload the primary.
- **Drop-in MongoDB for Railway apps**: any app in the same project can consume `REPLICA_SET_PRIVATE_URI` immediately after deployment.

## Dependencies for MongoDB Community Server Replica Set Hosting

- **MongoDB Community Server 8.2** (Docker image `mongodb/mongodb-community-server:8.2.4-ubuntu2204`) — the only runtime dependency; the cluster is self-contained.

### Deployment Dependencies

- Railway **volumes** on each mongo node (`/data/db`) for persistence.
- Railway **private networking** for inter-node replication and the init handshake.
- A Railway **TCP proxy** on mongo1 for external connections (exposed as `MONGO_HOST`, `MONGO_PORT`, `MONGO_URL`).

## Connecting After Deployment

Grab the generated variables from any mongo service:

- **Inside the same Railway project** (recommended): `REPLICA_SET_PRIVATE_URI` — full replica set connection string with `replicaSet=rs0`, driver-managed failover included.
- **From outside Railway**: `MONGO_URL` — routes through the TCP proxy attached to mongo1.
- **Credentials**: `MONGOUSER` / `MONGOPASSWORD` (root user, `authenticationDatabase: admin`).

## Operations

Back up each node's `/data/db` volume and follow MongoDB-supported upgrade paths between minor versions. To resize, scale the mongo services vertically — the replica set topology stays fixed at three members.
