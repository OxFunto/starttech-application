#!/bin/bash
set -e
echo "Creating Kind cluster..."
kind create cluster --name starttech

echo "Loading Docker image into Kind..."
kind load docker-image notfunn/starttech-backend:latest --name starttech

echo "Deploying to Kubernetes..."
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/mongodb/
kubectl apply -f kubernetes/backend/
kubectl apply -f kubernetes/ingress.yaml

echo "Waiting for pods..."
kubectl wait --for=condition=ready pod -l app=mongodb -n starttech --timeout=120s
kubectl wait --for=condition=ready pod -l app=backend -n starttech --timeout=120s

echo "Deployment complete."
kubectl get all -n starttech
