#!/bin/bash

STACK_NAME="kurv-WebAppStack"
TEMPLATE_FILE="app-runner-stack.yaml"
PROJECT_NAME="kurv-testapp"
GITHUB_REPO="https://github.com/sheenpythian/kurv_sdlc.git"

#ONLY USE IF NEEDED
# Get the current status of the stack (if it exists)
# STATUS=$(aws cloudformation describe-stacks --stack-name "$STACK_NAME" --query "Stacks[0].StackStatus" --output text 2>/dev/null)

# if [ "$STATUS" == "CREATE_FAILED" ]; then
#     echo "Stack is in CREATE_FAILED. Deleting to start fresh..."
#     aws cloudformation delete-stack --stack-name "$STACK_NAME"
#     aws cloudformation wait stack-delete-complete --stack-name "$STACK_NAME"
#     STATUS="" # Reset status so the next block runs 'create-stack'
# fi
#END ONLY USE IF NEEDED

# Check if the stack exists
if aws cloudformation describe-stacks --stack-name "$STACK_NAME" > /dev/null 2>&1; then
    echo "Stack '$STACK_NAME' exists. Running UPDATE..."
    
    aws cloudformation update-stack \
      --stack-name "$STACK_NAME" \
      --template-body "file://$TEMPLATE_FILE" \
      --parameters \
        ParameterKey=ProjectName,ParameterValue=$PROJECT_NAME \
        ParameterKey=GitHubRepo,ParameterValue=$GITHUB_REPO \
      --capabilities CAPABILITY_NAMED_IAM \
      --disable-rollback

else
    echo "Stack '$STACK_NAME' does not exist. Running CREATE..."
    
    aws cloudformation create-stack \
      --stack-name "$STACK_NAME" \
      --template-body "file://$TEMPLATE_FILE" \
      --parameters \
        ParameterKey=ProjectName,ParameterValue=$PROJECT_NAME \
        ParameterKey=GitHubRepo,ParameterValue=$GITHUB_REPO \
      --capabilities CAPABILITY_NAMED_IAM \
      --disable-rollback
fi


echo "Deployment started!"