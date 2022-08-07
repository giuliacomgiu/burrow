#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /burrow_1/tmp/pids/server.pid

# to do: put this on a file according to ENV var
# bundle exec rails db:setup
# bundle exec rails assets:precompile

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
