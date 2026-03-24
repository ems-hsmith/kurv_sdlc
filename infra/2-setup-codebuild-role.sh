# 1. Define your variables
ROLE_NAME="kurvCodeBuildECRPushRole"
POLICY_NAME="kurvCodeBuildECRPolicy"
REGION="us-east-1"  # Change to your region
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# 2. Create the Trust Relationship (Allows CodeBuild to use this role)
cat <<EOF > tmp-trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "codebuild.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document file://tmp-trust-policy.json

# 3. Create the Permissions Policy
cat <<EOF > tmp-permissions-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ECRAuth",
      "Effect": "Allow",
      "Action": "ecr:GetAuthorizationToken",
      "Resource": "*"
    },
    {
      "Sid": "ECRPushPull",
      "Effect": "Allow",
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"
      ],
      "Resource": "arn:aws:ecr:$REGION:$ACCOUNT_ID:repository/*"
    },
    {
      "Sid": "Logging",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF

aws iam put-role-policy --role-name $ROLE_NAME --policy-name $POLICY_NAME --policy-document file://tmp-permissions-policy.json

echo "Done! Use this ARN for your CodeBuild project: arn:aws:iam::$ACCOUNT_ID:role/$ROLE_NAME"