#!/bin/bash

export MIX_ENV=prod
export PORT=5797

echo "Stopping old copy of app, if any..."

_build/prod/rel/memory/bin/memory stop || true

echo "Starting app..."

# Foreground for testing and for systemd
_build/prod/rel/memory/bin/memory foreground
