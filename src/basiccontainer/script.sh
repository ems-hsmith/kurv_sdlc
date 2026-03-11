#!/bin/bash

# Function to handle Ctrl+C
cleanup() {
  echo ""
  echo "Ctrl+C detected. Gracefully shutting down..."
  echo "Cleaning up resources..."
  exit 0
}

# Trap SIGINT (Ctrl+C)
trap cleanup SIGINT

echo "Hello from inside the Docker container!"
echo "Current date:"
date

echo "Starting loop..."

for ((i=1; i<=10000; i++))
do
  echo "Loop iteration: $i"
  sleep 1
done

echo "Loop finished."