#!/bin/bash

echo "ensure you are logged in to AWS CLI with the correct credentials and region"
echo "using aws configure to set up your credentials and default region if you haven't done so already"
echo "using aws login to authenticate"
echo "*******************"
echo "*******************"

echo "Creating ECR repository for App Runner..."
aws ecr create-repository --repository-name kurv-my-app-frontend-repo-ds 