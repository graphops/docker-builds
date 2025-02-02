#!/bin/bash

# Extract versions from a Dockerfile and output them in a format suitable for GitHub Actions
dockerfile_path="$1"

if [ ! -f "$dockerfile_path" ]; then
    echo "Error: Dockerfile not found at $dockerfile_path"
    exit 1
fi

# Extract all ARG lines that define versions and output as proper JSON
versions=$(grep -E '^ARG.*_VERSION=' "$dockerfile_path" | sed -E 's/ARG ([^=]+)="([^"]+)"/\1=\2/')

# Convert to JSON format using a more robust approach
printf "{" > tmp_output
first=true
while IFS='=' read -r key value; do
    if [ ! -z "$key" ]; then
        if [ "$first" = true ]; then
            first=false
        else
            printf "," >> tmp_output
        fi
        printf "\"$key\": \"$value\"" >> tmp_output
    fi
done <<< "$versions"
printf "}" >> tmp_output

cat tmp_output
rm tmp_output