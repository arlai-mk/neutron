#!/bin/bash
set -e

BINARY=${BINARY:-gaiad}
BASE_DIR=./data
CHAINID=${CHAINID:-cosmoshub-devnet-1}
CHAIN_DIR="$BASE_DIR/$CHAINID/$NODE"

STAKEDENOM=${STAKEDENOM:-stake}

echo "Creating and collecting gentx..."
if [ "$NODE" == "node2" ]; then
    $BINARY genesis gentx val2 "2650000000$STAKEDENOM" --home "$CHAIN_DIR" --chain-id "$CHAINID" \
      --moniker="Crosnest" \
      --website="https://www.cros-nest.com/" \
      --identity="5F1D6AC7EA588676" \
      --details="" \
      --security-contact="chainmaster@cros-nest.com" \
      --ip="0.0.0.0" \
      --node="tcp://localhost:36656" \
      --keyring-backend test
elif [ "$NODE" == "node3" ]; then
    $BINARY genesis gentx val3 "2350000000$STAKEDENOM" --home "$CHAIN_DIR" --chain-id "$CHAINID" \
      --moniker="HighStakes.ch | Stake for Airdrop" \
      --website="https://highstakes.ch/earn-ibex" \
      --identity="2CB281A714F6133B" \
      --details="Increase your staking rewards and earn extra $ATOM with our IBEX program." \
      --security-contact="contact@highstakes.ch" \
      --ip="0.0.0.0" \
      --node="tcp://localhost:46656" \
      --keyring-backend test
elif [ "$NODE" == "node4" ]; then
    $BINARY genesis gentx val4 "2000000000$STAKEDENOM" --home "$CHAIN_DIR" --chain-id "$CHAINID" \
      --moniker="StakeLab" \
      --website="https://www.stakelab.zone" \
      --identity="F12B081334CBE0C6" \
      --details="Grow your assets - Staking & Relaying Hub for Cosmos ecosystem" \
      --security-contact="securite@stakelab.fr" \
      --ip="0.0.0.0" \
      --node="tcp://localhost:56656" \
      --keyring-backend test
elif [ "$NODE" == "node1" ]; then
    $BINARY genesis gentx val1 "3000000000$STAKEDENOM" --home "$CHAIN_DIR" --chain-id "$CHAINID" \
      --moniker="Moonkitt" \
      --website="https://moonkitt.com" \
      --identity="022AF2C303C88B9C" \
      --details="Secure & experienced validator. Delegate to earn rewards with peace of mind." \
      --security-contact="security@moonkitt.com" \
      --ip="0.0.0.0" \
      --node="tcp://localhost:16656" \
      --keyring-backend test

    mv "$BASE_DIR/$CHAINID/node2/config/gentx"/* "$CHAIN_DIR/config/gentx/"
    mv "$BASE_DIR/$CHAINID/node3/config/gentx"/* "$CHAIN_DIR/config/gentx/"
    mv "$BASE_DIR/$CHAINID/node4/config/gentx"/* "$CHAIN_DIR/config/gentx/"

    $BINARY genesis collect-gentxs --home "$CHAIN_DIR"

    sed -i -e '/allow_messages/{ N; s/\*/\/cosmos.bank.v1beta1.MsgSend\", \"\/cosmos.staking.v1beta1.MsgDelegate\", \"\/cosmos.staking.v1beta1.MsgUndelegate/ }' "$CHAIN_DIR/config/genesis.json"
    cp -f "$CHAIN_DIR/config/genesis.json" "$BASE_DIR/$CHAINID/node2/config/"
    cp -f "$CHAIN_DIR/config/genesis.json" "$BASE_DIR/$CHAINID/node3/config/"
    cp -f "$CHAIN_DIR/config/genesis.json" "$BASE_DIR/$CHAINID/node4/config/"
fi