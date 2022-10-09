#!/bin/bash

if [ -z "$GRAPH_NODE_RPC_SERVICE" ]; then
  echo "GRAPH_NODE_RPC_SERVICE must be set!"
  exit 1
fi

if [ -z "$1" ]; then
  echo "Usage: $(basename $0) name"
  exit 1
fi

NAME="$1"; shift

http post $GRAPH_NODE_RPC_SERVICE jsonrpc="2.0" id="1" method="subgraph_create" params:="{\"name\": \"$NAME\"}"