#!/bin/bash

set -e

rm -f /test_app/tmp/pids/server.pid

exec "$@"