#!/bin/bash
ALB_DNS=$1
ENDPOINT="http://$ALB_DNS/health"

echo "Checking $ENDPOINT..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $ENDPOINT)

if [ "$HTTP_STATUS" == "200" ]; then
  echo "Health check passed"
  exit 0
else
  echo "Health check failed with status $HTTP_STATUS"
  exit 1
fi
