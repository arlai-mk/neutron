#!/bin/bash
set -e

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

"$script_full_path"/init.sh
"$script_full_path"/init-neutrond.sh
"$script_full_path"/start.sh

export BINARY=gaiad
export CHAINID=cosmoshub-devnet-1
export NODE=node2
export P2PPORT=36656
export RPCPORT=36657
export RESTPORT=1318
export ROSETTA=10080
export GRPCPORT=10090
export GRPCWEB=10091
export STAKEDENOM=uatom

"$script_full_path"/init.sh
"$script_full_path"/init-gaiad.sh

export NODE=node3
export P2PPORT=46656
export RPCPORT=46657
export RESTPORT=1319
export ROSETTA=11080
export GRPCPORT=11090
export GRPCWEB=11091
export STAKEDENOM=uatom

"$script_full_path"/init.sh
"$script_full_path"/init-gaiad.sh

export NODE=node4
export P2PPORT=56656
export RPCPORT=56657
export RESTPORT=1320
export ROSETTA=12080
export GRPCPORT=12090
export GRPCWEB=12091
export STAKEDENOM=uatom

"$script_full_path"/init.sh
"$script_full_path"/init-gaiad.sh

export NODE=node1
export P2PPORT=16656
export RPCPORT=16657
export RESTPORT=1316
export ROSETTA=9080
export GRPCPORT=9090
export GRPCWEB=9091
export STAKEDENOM=uatom

"$script_full_path"/init.sh
"$script_full_path"/init-gaiad.sh
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

sleep 10

"$script_full_path"/send-tokens.sh