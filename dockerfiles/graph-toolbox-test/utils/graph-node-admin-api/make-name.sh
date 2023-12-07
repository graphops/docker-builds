#!/bin/bash

HASH=$1; shift

echo "indexer-agent/$(echo $HASH | rev | cut -c1-10 | rev)"