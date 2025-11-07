#!/bin/bash
set -e

# Remove Rails server PID file if it exists
rm -f /app/tmp/pids/server.pid

exec "$@"