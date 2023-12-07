#!/bin/bash

if [ -z "$UTILS_GRAPH_NODE_ADMIN_API_URL" ]; then
  echo "UTILS_GRAPH_NODE_ADMIN_API_URL must be set!"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Usage: $(basename $0) hash node"
  exit 1
fi

HASH="$1"; shift
NODE="$1"; shift

http post $UTILS_GRAPH_NODE_ADMIN_API_URL jsonrpc="2.0" id="1" method="subgraph_reassign" params:="{\"ipfs_hash\": \"$HASH\", \"node_id\": \"$NODE\"}"