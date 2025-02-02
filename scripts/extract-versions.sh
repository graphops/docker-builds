#!/bin/bash

# Extract versions from a Dockerfile and output them in a format suitable for GitHub Actions
dockerfile_path="$1"

if [ ! -f "$dockerfile_path" ]; then
    echo "Error: Dockerfile not found at $dockerfile_path"
    exit 1
fi

# Extract all ARG lines that define versions
versions=$(grep -E '^ARG.*_VERSION=' "$dockerfile_path" | sed -E 's/ARG ([^=]+)="([^"]+)"/\1=\2/')

# Convert to JSON format
echo "{"
while IFS='=' read -r key value; do
    if [ ! -z "$key" ]; then
        echo "  \"$key\": \"$value\","
    fi
done <<< "$versions"
echo "}"