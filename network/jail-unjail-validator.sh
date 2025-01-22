#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print usage
usage() {
  echo "Usage: $0 <node_id>"
  echo "node_id must be 2, 3, or 4"
  exit 1
}

# Validate input
if [ $# -ne 1 ]; then
  usage
fi

NODE_ID=$1

if [[ ! "$NODE_ID" =~ ^[234]$ ]]; then
  usage
fi

# Define variables
SCRIPT_DIR=$(dirname "$0")
export BINARY=gaiad
export CHAINID=cosmoshub-devnet-1
export NODE="node$NODE_ID"
export GRPCPORT=$((10090 + (NODE_ID - 2) * 1000))
export GRPCWEB=$((GRPCPORT + 1))
HOME_DIR="./data/$CHAINID/$NODE"

# Prompt user for action
echo "Choose an action for node $NODE_ID:"
echo "1. Jail + Restart gaiad, then Unjail"
echo "2. Start gaiad only"
echo "3. Unjail only"
read -rp "Enter your choice (1/2/3): " CHOICE

case $CHOICE in
  1)
    # Kill the node process
    PID=$(ps aux | grep "$BINARY" | grep "$HOME_DIR" | grep -v grep | awk '{print $2}')
    if [ -z "$PID" ]; then
      echo "No running process found for $NODE. Exiting."
      exit 1
    fi

    kill -9 "$PID"
    echo "Node $NODE_ID killed... Please press Enter when the validator is jailed."
    read -r

    # Restart the program
    "$SCRIPT_DIR/start.sh"

    echo "Node $NODE_ID restarted... The validator will be unjailed in 10 minutes. Do not kill the process."

    # Wait for 10 minutes with progress display
    for i in {1..100}; do
      echo -ne "Progress: $i%\r"
      sleep 6
    done

    # Unjail the validator
    $BINARY tx slashing unjail \
      --from "val$NODE_ID" \
      --keyring-backend test \
      --home "$HOME_DIR" \
      --node "tcp://localhost:16657" \
      --chain-id "$CHAINID" \
      --gas-adjustment 1.3 \
      --gas-prices 0.1uatom \
      -y  # Automatically confirm "yes"

    echo "Node $NODE_ID restored and validator unjailed."
    ;;
  2)
    # Start the program
    "$SCRIPT_DIR/start.sh"
    echo "Node $NODE_ID started."
    ;;
  3)
    # Unjail the validator only
    $BINARY tx slashing unjail \
      --from "val$NODE_ID" \
      --keyring-backend test \
      --home "$HOME_DIR" \
      --node "tcp://localhost:16657" \
      --chain-id "$CHAINID" \
      --gas-adjustment 1.3 \
      --gas-prices 0.1uatom \
      -y  # Automatically confirm "yes"

    echo "Validator for node $NODE_ID unjailed."
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac
