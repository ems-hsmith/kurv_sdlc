#!/bin/bash

# Script to deploy the CodePipeline for the App Runner stack

# Usage: ./deploy-codepipeline.sh <pipeline-name> <github-repo> <github-connection-arn> <project-name> <github-repo-url>

PIPELINE_NAME=kurvpipeline-apprunner
GITHUB_REPO=sheenpythian/kurv_test
GITHUB_CONNECTION_ARN="arn:aws:codeconnections:us-east-1:722791250757:connection/f9abc554-6092-4670-a544-3263f1f5c44b"
PROJECT_NAME=kurv-cp-project
GITHUB_REPO_URL=https://github.com/sheenpythian/kurv_test.git

aws cloudformation deploy \
  --stack-name $PIPELINE_NAME \
  --template-file codepipeline_apprunner.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    PipelineName=$PIPELINE_NAME \
    GitHubRepo=$GITHUB_REPO \
    GitHubConnectionArn=$GITHUB_CONNECTION_ARN \
    ProjectName=$PROJECT_NAME \
    GitHubRepoURL=$GITHUB_REPO_URL
