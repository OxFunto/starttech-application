#!/bin/bash
set -e
echo "Starting services with docker-compose..."
docker-compose up --build -d
echo "Services started."
echo "Backend running at http://localhost:8080"
docker-compose ps
