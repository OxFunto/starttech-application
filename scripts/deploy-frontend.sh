#!/bin/bash
set -e
BUCKET_NAME=$1
CLOUDFRONT_ID=$2

echo "Building frontend..."
cd frontend
npm ci
npm run build

echo "Deploying to S3..."
aws s3 sync build/ s3://$BUCKET_NAME --delete

echo "Invalidating CloudFront cache..."
aws cloudfront create-invalidation \
  --distribution-id $CLOUDFRONT_ID \
  --paths "/*"

echo "Frontend deployed."
