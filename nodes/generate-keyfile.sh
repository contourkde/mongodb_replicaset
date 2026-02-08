#!/bin/bash

# Path to the keyfile and database directory
KEYFILE_PATH="/data/keyfile"
DB_PATH="/data/db"

# Check if the keyfile already exists
if [ -f "$KEYFILE_PATH" ]; then
  echo "Keyfile already exists at $KEYFILE_PATH. Skipping keyfile generation."
else
  # Generate the keyfile from the environment variable
  if [ -z "$KEYFILE" ]; then
    echo "KEYFILE environment variable is not set. Exiting."
    exit 1
  fi

  echo "Generating keyfile from environment variable..."
  echo "$KEYFILE" > "$KEYFILE_PATH"
fi

# Ensure permissions are correct (we are running as root)
echo "Setting permissions for $KEYFILE_PATH"
chown mongodb:mongodb "$KEYFILE_PATH"
chmod 400 "$KEYFILE_PATH"

# Ensure the database directory exists and has correct permissions
if [ ! -d "$DB_PATH" ]; then
  echo "Creating MongoDB data directory at $DB_PATH..."
  mkdir -p "$DB_PATH"
fi
echo "Setting permissions for $DB_PATH"
chown -R mongodb:mongodb "$DB_PATH"

# Execute the command passed to the docker container
# If arguments are passed (e.g. from CMD or ENTRYPOINT args in Dockerfile), run them
# We expect the arguments to be the mongod command
echo "Starting MongoDB..."
exec gosu mongodb "$@"
