#!/bin/bash
set -e

declare -a cosmos_addresses=(
    "cosmos1wgvxd0y363f04ugp7r4pru74s79ajnfe37tprf" # Victor
    "cosmos16wa6c8cgvrq9ey3c0mm59eqvnlwyu4w3wz42ne" # arlai Alice
    "cosmos1uwadr4j8etlj3gdmf74v5u2rae2xr68fte3r5c" # arlai Bob
    "cosmos1reuzmm9q9fr69n5xdy920fsf2kgspvh5mahld3" # arlai Charlie
    "cosmos1903lkw4kxwefee4gax8dmnd2gtez3ljgsr346e" # arlai Alice Ledger
    "cosmos1amfsez6sqk35rpq5589mrqeqdhg04jsx0u9yy7" # arlai Bob Ledger
    "cosmos1hyyftdvt732u5y7z0muvqm0ajxg5k6ws5n3s7l" # arlai Charlie Ledger
)

BINARY=gaiad
BASE_DIR=./data
CHAINID=cosmoshub-devnet-1
NODE=node1
CHAIN_DIR="$BASE_DIR/$CHAINID/$NODE"
HOST="tcp://localhost:16657"
STAKEDENOM=uatom

for cosmos_address in "${cosmos_addresses[@]}"
do
  echo y |
  $BINARY tx bank send \
    demowallet1 \
    "$cosmos_address" \
    "1000000000000$STAKEDENOM" \
    --gas-prices 0.1$STAKEDENOM \
    --gas-adjustment 1.3 \
    --keyring-backend test \
    --home "$CHAIN_DIR" \
    --chain-id $CHAINID \
    --node $HOST

  sleep 2.5 # otherwise I get some mismatch sequence... (could also just do a multisend, if possible from command line?)
done

# Do the validator bond for Liquid Staking
declare -a valoper_addresses=(
  "cosmosvaloper18hl5c9xn5dze2g50uaw0l2mr02ew57zk0auktn" # Moonkitt (val1)
  "cosmosvaloper1qnk2n4nlkpw9xfqntladh74w6ujtulwnmxnh3k" # Crosnest (val2)
  "cosmosvaloper1tdchzcvgmq4dqvar90hjpgh6l6me9x7z832vlr" # High Stakes (val3)
  "cosmosvaloper1zthtxtyqdgp6ne6lfp0fv9gc7dddlc8qdx4trs" # StakeLab (val4)
)

ITER=0
for valoper_address in "${valoper_addresses[@]}"; do 
  ITER=$(expr $ITER + 1)
  echo y |
  $BINARY tx staking validator-bond \
    "$valoper_address" \
    --gas-prices 0.1$STAKEDENOM \
    --gas-adjustment 1.3 \
    --from "val${ITER}" \
    --keyring-backend test \
    --home "$CHAIN_DIR" \
    --chain-id $CHAINID \
    --node $HOST
done


#---------------- NEUTRON 

declare -a neutron_addresses=(
    "neutron1wgvxd0y363f04ugp7r4pru74s79ajnfe4pzrew" # Victor
    "neutron16wa6c8cgvrq9ey3c0mm59eqvnlwyu4w32augf7" # arlai Alice
    "neutron1uwadr4j8etlj3gdmf74v5u2rae2xr68f0xcpwl" # arlai Bob
    "neutron1reuzmm9q9fr69n5xdy920fsf2kgspvh5lz7ahk" # arlai Charlie
    "neutron1903lkw4kxwefee4gax8dmnd2gtez3ljg5uchq7" # arlai Alice Ledger
    "neutron1amfsez6sqk35rpq5589mrqeqdhg04jsxtrvx7e" # arlai Bob Ledger
    "neutron1hyyftdvt732u5y7z0muvqm0ajxg5k6wssvcjyc" # arlai Charlie Ledger
)

BINARY=neutrond
BASE_DIR=./data
CHAINID=neutron-devnet-1
CHAIN_DIR="$BASE_DIR/$CHAINID"
HOST="tcp://localhost:26657"
STAKEDENOM=untrn

for neutron_address in "${neutron_addresses[@]}"
do
  echo y |
  $BINARY tx bank send \
    demowallet1 \
    "$neutron_address" \
    "1000000000000$STAKEDENOM" \
    --gas-prices 0.1$STAKEDENOM \
    --gas-adjustment 1.3 \
    --keyring-backend test \
    --home "$CHAIN_DIR" \
    --chain-id $CHAINID \
    --node $HOST

  sleep 2.5 # otherwise I get some mismatch sequence... (could also just do a multisend, if possible from command line?)
done

# some commands
# 1. Unjail
# gaiad tx slashing unjail --from val2 --keyring-backend=test --home=data/cosmoshub-devnet-1/node2 --node="tcp://localhost:36657" --chain-id="cosmoshub-devnet-1" --gas-adjustment 1.3 --gas-prices 0.1uatom