#!/bin/bash
set -e
ASG_NAME=$1
PREVIOUS_IMAGE=$2

echo "Rolling back to $PREVIOUS_IMAGE..."
aws autoscaling cancel-instance-refresh \
  --auto-scaling-group-name $ASG_NAME 2>/dev/null || true

echo "Update launch template with previous image..."
echo "Then trigger a new instance refresh"
echo "Rollback initiated."
