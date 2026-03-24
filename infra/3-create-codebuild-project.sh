#!/bin/bash

# 1. Define your variables
# Initialize variables to store option values
GITHUB_REPO_TOKEN="" #"<YOUR_GITHUB_TOKEN>"  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

GITHUB_REPO_URL="https://github.com/sheenpythian/kurv_sdlc.git"
GITHUB_BUILDSPEC_PATH="./src/basicapp/buildspec.yml"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
APP_NAME="kurv-my-web-frontend"
ECR_REPO_NAME="kurv-my-app-frontend-repo-ds"


# Function to display usage information
usage() {
    echo "Usage: $0 [-t value]"
    exit 1
}

# The leading colon in the option string (":t:") tells getopts to suppress
# default error messages and lets the script handle them.
# The colon after 't' indicates that the -t option requires an argument.
while getopts ":t:" opt; do
    case "${opt}" in
        t )
            # When -t is found, the argument is placed in the variable OPTARG
            GITHUB_REPO_TOKEN="${OPTARG}"
            ;;
        : )
            # Handle missing arguments (e.g., just "-t" without a value)
            echo "Error: Option -${OPTARG} requires an argument." >&2
            usage
            ;;
        ? )
            # Handle invalid options (e.g., "-z")
            echo "Error: Invalid option: -${OPTARG}." >&2
            usage
            ;;
    esac
done

# Verify that the required value for -t was actually provided
if [ -z "$GITHUB_REPO_TOKEN" ]; then
    echo "Error: The -t option is required and must have a value." >&2
    usage
fi


aws codebuild import-source-credentials \
    --server-type GITHUB \
    --auth-type PERSONAL_ACCESS_TOKEN \
    --token "$GITHUB_REPO_TOKEN"


aws codebuild create-project \
    --name "$APP_NAME-build" \
    --source '{
        "type": "GITHUB",
        "location": "'"$GITHUB_REPO_URL"'",
        "buildspec": "'"$GITHUB_BUILDSPEC_PATH"'",
        "reportBuildStatus": true
    }' \
    --artifacts '{"type": "NO_ARTIFACTS"}' \
    --environment '{
        "type": "LINUX_CONTAINER",
        "image": "aws/codebuild/standard:7.0",
        "computeType": "BUILD_GENERAL1_SMALL",
        "privilegedMode": true,
        "environmentVariables": [
            { "name": "IMAGE_REPO_NAME", "value": "'"$ECR_REPO_NAME"'" },
            { "name": "AWS_ACCOUNT_ID", "value": "'"$ACCOUNT_ID"'" }
        ]
    }' \
    --service-role arn:aws:iam::$ACCOUNT_ID:role/kurvCodeBuildECRPushRole

aws codebuild create-webhook \
    --project-name "$APP_NAME-build" \
    --filter-groups "[[
        {
            \"type\": \"EVENT\",
            \"pattern\": \"PUSH\"
        },
        {
            \"type\": \"HEAD_REF\",
            \"pattern\": \"^refs/heads/main$\"
        }
    ]]"