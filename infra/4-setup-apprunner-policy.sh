# 1. Create a trust policy file
cat <<EOF > tmp-apprunner-trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "build.apprunner.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

# 2. Create the role
aws iam create-role \
    --role-name kurvAppRunnerECRAccessRole \
    --assume-role-policy-document file://tmp-apprunner-trust-policy.json

# 3. Attach the AWS-managed policy for ECR access
aws iam attach-role-policy \
    --role-name kurvAppRunnerECRAccessRole \
    --policy-arn arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess