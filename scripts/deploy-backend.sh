#!/bin/bash
set -e
IMAGE=$1

echo "Building Docker image..."
docker build -t $IMAGE backend/

echo "Pushing to Docker Hub..."
docker push $IMAGE

echo "Triggering rolling update..."
ASG_NAME=$(aws autoscaling describe-auto-scaling-groups \
  --query "AutoScalingGroups[?contains(Tags[?Key=='Name'].Value, 'starttech')].AutoScalingGroupName" \
  --output text)

aws autoscaling start-instance-refresh \
  --auto-scaling-group-name $ASG_NAME \
  --preferences '{"MinHealthyPercentage": 50}'

echo "Deployment triggered."
