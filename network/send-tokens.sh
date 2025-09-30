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
    "cosmos164lr65s6u8equ5elqmnj5s490rvunwc6pv4atl" # Poly
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


#---------------- NEUTRON 

declare -a neutron_addresses=(
    "neutron1wgvxd0y363f04ugp7r4pru74s79ajnfe4pzrew" # Victor
    "neutron16wa6c8cgvrq9ey3c0mm59eqvnlwyu4w32augf7" # arlai Alice
    "neutron1uwadr4j8etlj3gdmf74v5u2rae2xr68f0xcpwl" # arlai Bob
    "neutron1reuzmm9q9fr69n5xdy920fsf2kgspvh5lz7ahk" # arlai Charlie
    "neutron1903lkw4kxwefee4gax8dmnd2gtez3ljg5uchq7" # arlai Alice Ledger
    "neutron1amfsez6sqk35rpq5589mrqeqdhg04jsxtrvx7e" # arlai Bob Ledger
    "neutron1hyyftdvt732u5y7z0muvqm0ajxg5k6wssvcjyc" # arlai Charlie Ledger
    "neutron164lr65s6u8equ5elqmnj5s490rvunwc69nul3c" # Poly
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

# neutrond tx bank send demowallet1 neutron164lr65s6u8equ5elqmnj5s490rvunwc69nul3c 1000000000000factory/neutron1k6hr0f83e7un2wjf29cspk7j69jrnskk65k3ek2nj9dztrlzpj6q00rtsa/udatom --gas-prices 0.1untrn --gas-adjustment 1.3 --keyring-backend test --home data/neutron-devnet-1/ --chain-id neutron-devnet-1
# neutrond tx bank send demowallet1 neutron164lr65s6u8equ5elqmnj5s490rvunwc69nul3c 1000000000000factory/neutron1frc0p5czd9uaaymdkug2njz7dc7j65jxukp9apmt9260a8egujkspms2t2/udntrn --gas-prices 0.1untrn --gas-adjustment 1.3 --keyring-backend test --home data/neutron-devnet-1/ --chain-id neutron-devnet-1
# neutrond tx bank send demowallet1 neutron164lr65s6u8equ5elqmnj5s490rvunwc69nul3c 1000000000000ibc/B7864B03E1B9FD4F049243E92ABD691586F682137037A9F3FCA5222815620B3C --gas-prices 0.1untrn --gas-adjustment 1.3 --keyring-backend test --home data/neutron-devnet-1/ --chain-id neutron-devnet-1
# neutrond tx bank send demowallet1 neutron164lr65s6u8equ5elqmnj5s490rvunwc69nul3c 1000000000000ibc/75249A18DEFBEFE55F83B1C70CAD234DF164F174C6BC51682EE92C2C81C18C93 --gas-prices 0.1untrn --gas-adjustment 1.3 --keyring-backend test --home data/neutron-devnet-1/ --chain-id neutron-devnet-1
# neutrond tx bank send demowallet1 neutron164lr65s6u8equ5elqmnj5s490rvunwc69nul3c 1000000000000ibc/B559A80D62249C8AA07A380E2A2BEA6E5CA9A6F079C912C3A9E9B494105E4F81 --gas-prices 0.1untrn --gas-adjustment 1.3 --keyring-backend test --home data/neutron-devnet-1/ --chain-id neutron-devnet-1
