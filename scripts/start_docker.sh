#!/bin/bash

# --- CONFIGURATION ---
# Replace these with the actual paths on your host machine
HOST_HF_CACHE="/home/ubuntu/.cache/huggingface"
HOST_TOKENSPEED="/home/ubuntu/tokenspeed"
HOST_UID="$(id -u)"
HOST_GID="$(id -g)"

CONTAINER_NAME="ts_workspace"
IMAGE_NAME="lightseekorg/tokenspeed-runner:cu130-torch-2.11.0" # Replace with your target AI/PyTorch image (e.g., pytorch/pytorch:latest)


echo "Spinning up the container with bind mounts..."

# --- START CONTAINER ---
docker run -d \
  --name "$CONTAINER_NAME" \
  --gpus all \
  --user "$HOST_UID:$HOST_GID" \
  -e HOME=/tmp/tokenspeed-home \
  -e HF_HOME=/mnt/huggingface \
  -v "$HOST_HF_CACHE":/mnt/huggingface  \
  -v "$HOST_TOKENSPEED":/workspace/tokenspeed \
  -w /workspace \
  "$IMAGE_NAME" \
  tail -f /dev/null

echo "Container '$CONTAINER_NAME' is running."
echo "HuggingFace Cache -> /mnt/huggingface"
echo "tokenspeed -> /workspace/tokenspeed"
echo "------------------------------------------------"
