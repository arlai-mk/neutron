#!/bin/bash
set -e

BINARY=${BINARY:-gaiad}
BASE_DIR=./data
CHAINID=${CHAINID:-cosmoshub-devnet-1}
CHAIN_DIR="$BASE_DIR/$CHAINID/$NODE"

STAKEDENOM=${STAKEDENOM:-stake}

function set_genesis_param_jq() {
  param_path=$1
  param_value=$2
  jq "${param_path} = ${param_value}" > tmp_genesis_file.json < "$CHAIN_DIR/config/genesis.json" && mv tmp_genesis_file.json "$CHAIN_DIR/config/genesis.json"
}

echo "Creating and collecting gentx..."
if [ "$NODE" == "node2" ]; then
    $BINARY genesis gentx val2 "2650000000$STAKEDENOM" --home "$CHAIN_DIR" --chain-id "$CHAINID" \
      --moniker="Crosnest" \
      --commission-rate="0.050000000000000000" \
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
      --commission-rate="0.050000000000000000" \
      --website="https://highstakes.ch/earn-ibex" \
      --identity="2CB281A714F6133B" \
      --details="Increase your staking rewards and earn extra $ATOM with our IBEX program." \
      --security-contact="contact@highstakes.ch" \
      --ip="0.0.0.0" \
      --node="tcp://localhost:46656" \
      --keyring-backend test
elif [ "$NODE" == "node4" ]; then
    $BINARY genesis gentx val4 "2000000000$STAKEDENOM" --home "$CHAIN_DIR" --chain-id "$CHAINID" \
      --moniker="POSTHUMAN 🧬 StakeDrop" \
      --commission-rate="0.050000000000000000" \
      --website="https://posthuman.digital" \
      --identity="8A9FC930E1A980D6" \
      --details="PHMN StakeDrop for delegators 🧬 100% slashing protection ⚛️ https://posthuman.digital" \
      --security-contact="validator@posthuman.digital" \
      --ip="0.0.0.0" \
      --node="tcp://localhost:56656" \
      --keyring-backend test
elif [ "$NODE" == "node1" ]; then
    $BINARY genesis gentx val1 "3000000000$STAKEDENOM" --home "$CHAIN_DIR" --chain-id "$CHAINID" \
      --moniker="Moonkitt" \
      --commission-rate="0.050000000000000000" \
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

    sed -i -e 's/\*/\/cosmos.bank.v1beta1.MsgSend\", \"\/cosmos.staking.v1beta1.MsgDelegate\", \"\/cosmos.staking.v1beta1.MsgUndelegate/g' "$CHAIN_DIR/config/genesis.json"

    set_genesis_param_jq ".app_state.feemarket.params.enabled" "false"                      # feemarket
    set_genesis_param_jq ".app_state.feemarket.params.fee_denom"       "\"uatom\""          # feemarket
    set_genesis_param_jq ".app_state.feemarket.state.base_gas_price" "\"0.0025\""           # feemarket
    set_genesis_param_jq ".app_state.feemarket.params.min_base_gas_price"    "\"0.0025\""   # feemarket

    set_genesis_param_jq ".app_state.ibc.client_genesis.params.allowed_clients" "[\"*\"]"         # ibc
    
    sed -i -e 's/\"validator_bond_factor\":.*/\"validator_bond_factor\": \"250.000000000000000000\",/g' "$CHAIN_DIR/config/genesis.json"
    sed -i -e 's/\"global_liquid_staking_cap\":.*/\"global_liquid_staking_cap\": \"0.250000000000000000\",/g' "$CHAIN_DIR/config/genesis.json"

    cp -f "$CHAIN_DIR/config/genesis.json" "$BASE_DIR/$CHAINID/node2/config/"
    cp -f "$CHAIN_DIR/config/genesis.json" "$BASE_DIR/$CHAINID/node3/config/"
    cp -f "$CHAIN_DIR/config/genesis.json" "$BASE_DIR/$CHAINID/node4/config/"
fi