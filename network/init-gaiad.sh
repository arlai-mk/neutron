#!/bin/bash
set -e

BINARY=${BINARY:-gaiad}
BASE_DIR=./data
CHAINID=${CHAINID:-cosmoshub-devnet-1}
CHAIN_DIR="$BASE_DIR/$CHAINID/$NODE"

STAKEDENOM=${STAKEDENOM:-stake}

echo "Creating and collecting gentx..."
if [ "$NODE" == "node2" ]; then
    $BINARY genesis gentx val2 "2650000000$STAKEDENOM" --home "$CHAIN_DIR" --chain-id "$CHAINID" --moniker="val2" --ip="0.0.0.0" --node="tcp://localhost:36656" --keyring-backend test
elif [ "$NODE" == "node3" ]; then
    $BINARY genesis gentx val3 "2350000000$STAKEDENOM" --home "$CHAIN_DIR" --chain-id "$CHAINID" --moniker="val3" --ip="0.0.0.0" --node="tcp://localhost:46656" --keyring-backend test
elif [ "$NODE" == "node4" ]; then
    $BINARY genesis gentx val4 "2000000000$STAKEDENOM" --home "$CHAIN_DIR" --chain-id "$CHAINID" --moniker="val4" --ip="0.0.0.0" --node="tcp://localhost:56656" --keyring-backend test
elif [ "$NODE" == "node1" ]; then
    $BINARY genesis gentx val1 "3000000000$STAKEDENOM" --home "$CHAIN_DIR" --chain-id "$CHAINID" --moniker="val1" --ip="0.0.0.0" --node="tcp://localhost:16656" --keyring-backend test

    mv "$BASE_DIR/$CHAINID/node2/config/gentx"/* "$CHAIN_DIR/config/gentx/"
    mv "$BASE_DIR/$CHAINID/node3/config/gentx"/* "$CHAIN_DIR/config/gentx/"
    mv "$BASE_DIR/$CHAINID/node4/config/gentx"/* "$CHAIN_DIR/config/gentx/"

    $BINARY genesis collect-gentxs --home "$CHAIN_DIR"

    sed -i -e '/allow_messages/{ N; s/\*/\/cosmos.bank.v1beta1.MsgSend\", \"\/cosmos.staking.v1beta1.MsgDelegate\", \"\/cosmos.staking.v1beta1.MsgUndelegate/ }' "$CHAIN_DIR/config/genesis.json"
    cp -f "$CHAIN_DIR/config/genesis.json" "$BASE_DIR/$CHAINID/node2/config/"
    cp -f "$CHAIN_DIR/config/genesis.json" "$BASE_DIR/$CHAINID/node3/config/"
    cp -f "$CHAIN_DIR/config/genesis.json" "$BASE_DIR/$CHAINID/node4/config/"
fi