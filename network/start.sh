#!/bin/bash
set -e

BINARY=${BINARY:-neutrond}
BASE_DIR=./data
CHAINID=${CHAINID:-neutron-devnet-1}
GRPCPORT=${GRPCPORT:-9090}
GRPCWEB=${GRPCWEB:-9091}
CHAIN_DIR="$BASE_DIR/$CHAINID"

# For Gaia, we have different nodes
if [ "$BINARY" == "gaiad" ]; then
  NODE=${NODE:-node1}

  SEED_NODE1="$($BINARY tendermint show-node-id --home "$CHAIN_DIR/node1")@localhost:16656"
  SEED_NODE2="$($BINARY tendermint show-node-id --home "$CHAIN_DIR/node2")@localhost:36656"
  SEED_NODE3="$($BINARY tendermint show-node-id --home "$CHAIN_DIR/node3")@localhost:46656"
  SEED_NODE4="$($BINARY tendermint show-node-id --home "$CHAIN_DIR/node4")@localhost:56656"

  if [ "$NODE" == "node1" ]; then
    SEEDS="--p2p.seeds=$SEED_NODE2,$SEED_NODE3,$SEED_NODE4"
  elif [ "$NODE" == "node2" ]; then
    SEEDS="--p2p.seeds=$SEED_NODE1,$SEED_NODE3,$SEED_NODE4"
  elif [ "$NODE" == "node3" ]; then
    SEEDS="--p2p.seeds=$SEED_NODE1,$SEED_NODE2,$SEED_NODE4"
  elif [ "$NODE" == "node4" ]; then
    SEEDS="--p2p.seeds=$SEED_NODE1,$SEED_NODE2,$SEED_NODE3"
  fi

  CHAIN_DIR="$CHAIN_DIR/$NODE"
fi

RUN_BACKGROUND=${RUN_BACKGROUND:-1}

echo "Starting $CHAINID in $CHAIN_DIR..."
echo "Creating log file at $CHAIN_DIR/$CHAINID.log"
if [ "$RUN_BACKGROUND" == 1 ]; then
  rm "$CHAIN_DIR/$CHAINID.log"
  $BINARY start                           \
    --log_level debug                     \
    --log_format json                     \
    --home "$CHAIN_DIR"                   \
    --pruning=nothing                     \
    --grpc.address="0.0.0.0:$GRPCPORT"    \
    $SEEDS                                \
    --trace > "$CHAIN_DIR/$CHAINID.log" 2>&1 &
else
  $BINARY start                           \
    --log_level debug                     \
    --log_format json                     \
    --home "$CHAIN_DIR"                   \
    --pruning=nothing                     \
    --grpc.address="0.0.0.0:$GRPCPORT"    \
    $SEEDS                                \
    --trace 2>&1 | tee "$CHAIN_DIR/$CHAINID.log"
fi

