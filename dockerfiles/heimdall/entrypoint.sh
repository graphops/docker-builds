#!/bin/bash
set -e

# Default command is to start Heimdall
if [ "$1" = "" ]; then
  exec heimdalld start --home=${HEIMDALL_DIR} "$@"
else
  exec "$@"
fi
