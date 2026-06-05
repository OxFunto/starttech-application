#!/bin/bash
set -e
echo "Building Docker image..."
docker build -t notfunn/starttech-backend:latest ./Server/MuchToDo
echo "Build complete."
