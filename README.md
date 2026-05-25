StartTech Infrastructure

This repo contains all the infrastructure code for the StartTech application. Everything is managed with Terraform and deployed automatically through GitHub Actions.

--> What Gets Created

When you run Terraform, it builds out the following in AWS:

A VPC with public and private subnets across two availability zones. The frontend React app is hosted on S3 and served through CloudFront. The Golang backend runs in Docker containers on EC2 instances behind an Application Load Balancer with auto scaling. Redis runs on ElastiCache for caching and sessions. Logs are collected in CloudWatch with alarms set up for CPU usage.

--> Before You Start

Make sure you have these installed:
- Terraform v1.6 or higher
- AWS CLI v2
- Docker
- Git

Set up your AWS credentials by running:
aws configure

You will also need a MongoDB Atlas account. Go to cloud.mongodb.com, create a free cluster, add a database user, allow all IPs under Network Access, and copy the connection string. You will need it in the next step.

--> Deploying the Infrastructure

Clone this repo and go into the terraform folder:

git clone https://github.com/OxFunto/starttech-infra
cd starttech-infra/terraform

Copy the example vars file and fill in your real values:

cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars

Fill it in like this:

aws_region   = "us-east-1"
project_name = "starttech"
environment  = "prod"
your_ip      = "YOUR-IP/32"
key_name     = "your-key-pair-name"
docker_image = "yourdockerusername/starttech-backend:latest"
mongodb_uri  = "your-mongodb-connection-string"

Then run:

terraform init
terraform plan
terraform apply

When it finishes, copy the output values shown in the terminal. You will need them for GitHub secrets.

--> GitHub Secrets Needed

For the starttech-infra repo:
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
KEY_NAME
MONGODB_URI

For the starttech-application repo:
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
S3_BUCKET_NAME
CLOUDFRONT_ID
CLOUDFRONT_DOMAIN
ALB_DNS_NAME
DOCKERHUB_USERNAME
DOCKERHUB_TOKEN

--> Repo Structure

.github/workflows/infrastructure-deploy.yml
terraform/main.tf
terraform/variables.tf
terraform/outputs.tf
terraform/modules/networking/
terraform/modules/compute/
terraform/modules/storage/
terraform/modules/monitoring/
terraform/terraform.tfvars.example
scripts/deploy-infrastructure.sh
monitoring/cloudwatch-dashboard.json
monitoring/alarm-definitions.json
monitoring/log-insights-queries.txt
ARCHITECTURE.md
RUNBOOK.md
README.md

--> Tearing It Down

To destroy all resources and stop AWS charges:

cd terraform
terraform destroy -auto-approve
