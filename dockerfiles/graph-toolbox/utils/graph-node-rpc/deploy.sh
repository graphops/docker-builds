#!/bin/bash

if [ -z "$GRAPH_NODE_RPC_SERVICE" ]; then
  echo "GRAPH_NODE_RPC_SERVICE must be set!"
  exit 1
fi

if [ -z "$3" ]; then
  echo "Usage: $(basename $0) name hash node"
  exit 1
fi

NAME="$1"; shift
HASH="$1"; shift
NODE="$1"; shift

http post $GRAPH_NODE_RPC_SERVICE jsonrpc="2.0" id="1" method="subgraph_deploy" params:="{\"name\": \"$NAME\", \"ipfs_hash\": \"$HASH\", \"node_id\": \"$NODE\"}"