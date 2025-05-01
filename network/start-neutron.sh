#!/bin/bash
set -e

killall neutrond 2>/dev/null || true

script_full_path=$(dirname "$0")

export BINARY=neutrond
export CHAINID=neutron-devnet-1
export P2PPORT=26656
export RPCPORT=26657
export RESTPORT=1317
export ROSETTA=8080
export GRPCPORT=8090
export GRPCWEB=8091
export STAKEDENOM=untrn
export LOGLEVEL=debug

"$script_full_path"/start.sh
