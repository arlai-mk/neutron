#!/bin/bash
set -e

killall gaiad 2>/dev/null

script_full_path=$(dirname "$0")

export BINARY=gaiad
export CHAINID=cosmoshub-devnet-1

export NODE=node1
export GRPCPORT=9090
export GRPCWEB=9091
"$script_full_path"/start.sh

export NODE=node2
export GRPCPORT=10090
export GRPCWEB=10091
"$script_full_path"/start.sh

export NODE=node3
export GRPCPORT=11090
export GRPCWEB=11091
"$script_full_path"/start.sh

export NODE=node4
export GRPCPORT=12090
export GRPCWEB=12091
"$script_full_path"/start.sh
