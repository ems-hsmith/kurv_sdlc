ECR_REPO_NAME="kurv-my-app-frontend-repo-ds"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
AWS_DEFAULT_REGION="us-east-1" 

aws apprunner create-service \
    --service-name kurv-my-app-runner-frontend-service-ds \
    --source-configuration '{
        "AuthenticationConfiguration": {
            "AccessRoleArn": "arn:aws:iam::'"$ACCOUNT_ID"':role/kurvAppRunnerECRAccessRole"
        },
        "ImageRepository": {
            "ImageIdentifier": "'"$ACCOUNT_ID"'.dkr.ecr.'"$AWS_DEFAULT_REGION"'.amazonaws.com/'"$ECR_REPO_NAME"':latest",
            "ImageConfiguration": { "Port": "80" },
            "ImageRepositoryType": "ECR"
        },
        "AutoDeploymentsEnabled": true
    }'