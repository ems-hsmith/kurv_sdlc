#!/bin/bash

echo "Hello from the Docker container!"
echo "Current date:"
date

# Function to run when Ctrl+C is pressed
cleanup() {
  echo ""
  echo "Ctrl+C detected. Cleaning up and exiting gracefully..."
  exit 0
}

# Trap SIGINT (Ctrl+C)
trap cleanup SIGINT SIGTERM

echo "Starting loop..."

for i in $(seq 1 10000)
do
  echo "Loop iteration: $i"
  sleep 1
done

echo "Loop finished!"