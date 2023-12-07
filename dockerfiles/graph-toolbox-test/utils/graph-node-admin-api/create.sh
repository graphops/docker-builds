#!/bin/bash

if [ -z "$UTILS_GRAPH_NODE_ADMIN_API_URL" ]; then
  echo "UTILS_GRAPH_NODE_ADMIN_API_URL must be set!"
  exit 1
fi

if [ -z "$1" ]; then
  echo "Usage: $(basename $0) name"
  exit 1
fi

NAME="$1"; shift

http post $UTILS_GRAPH_NODE_ADMIN_API_URL jsonrpc="2.0" id="1" method="subgraph_create" params:="{\"name\": \"$NAME\"}"