#!/bin/bash
set -e
echo "Cleaning up..."
kubectl delete namespace starttech
kind delete cluster --name starttech
echo "Done."
