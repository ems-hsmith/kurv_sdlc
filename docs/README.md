# Docs Directory

This directory contains documentation for the project.

- [Roadmap](roadmap.md)
- [Kurv Day 1 - Design](Kurv_Day_1_-_Design.pdf)
- [Kurv Day 2 - Development](Kurv_Day_2_-_Development.pdf)
- [Kurv Day 3 - DevOps](Kurv_Day_3_-_DevOps.pdf)

## Infra Folder

The infra folder contains 3 main structures.
1. CLI setup which are the files:
   - [`1-create-container-registry.sh`](../infra/1-create-container-registry.sh) - Creates an AWS ECR repository to store the frontend application's container image.
   - [`2-setup-codebuild-role.sh`](../infra/2-setup-codebuild-role.sh) - Creates an AWS IAM role with policies that allow AWS CodeBuild to push container images to AWS ECR.
   - [`3-create-codebuild-project.sh`](../infra/3-create-codebuild-project.sh) - Creates an AWS CodeBuild project that is connected to a GitHub repository and sets up a webhook to trigger builds on push events to the main branch.
   - [`4-setup-apprunner-policy.sh`](../infra/4-setup-apprunner-policy.sh) - Creates an AWS IAM role with a policy that grants AWS App Runner permission to access and pull container images from AWS ECR.
   - [`5-create-apprunner-service.sh`](../infra/5-create-apprunner-service.sh) - Creates an AWS App Runner service that automatically deploys and runs a containerized application from an AWS ECR repository.
   - [`6-create-container-registry-api.sh`](../infra/6-create-container-registry-api.sh) - Creates an AWS ECR repository to store the backend application's container image.
   - [`7-create-apprunner-service-api.sh`](../infra/7-create-apprunner-service-api.sh) - Creates an AWS App Runner service that automatically deploys and runs the backend containerized application from an AWS ECR repository.
2. CloudFormation setup which are the files:
   - [`app-runner-stack.yaml`](../infra/app-runner-stack.yaml) - A CloudFormation template that provisions all the necessary AWS resources for a CI/CD pipeline, including ECR repositories, CodeBuild projects, IAM roles, and App Runner services for both frontend and backend.
   - [`app-runner-stack-deploy.sh`](../infra/app-runner-stack-deploy.sh) - A deployment script that creates or updates the AWS CloudFormation stack defined in the `app-runner-stack.yaml` template.
3. CodePipeline setup which are the files:
   - [`app-runner-stack-backend.yaml`](../infra/app-runner-stack-backend.yaml) - A CloudFormation template that defines and configures the AWS App Runner service for the backend application.
   - [`app-runner-stack-frontend.yaml`](../infra/app-runner-stack-frontend.yaml) - A CloudFormation template that defines and configures the AWS App Runner service for the frontend application.
   - [`codebuild-ecr-stack.yaml`](../infra/codebuild-ecr-stack.yaml) - A CloudFormation template that creates AWS ECR repositories and AWS CodeBuild projects for both the frontend and backend applications.
   - [`codepipeline_apprunner.yaml`](../infra/codepipeline_apprunner.yaml) - A CloudFormation template that creates an AWS CodePipeline to automate the build and deployment of the application from GitHub to AWS App Runner.
   - [`deploy-codepipeline.sh`](../infra/deploy-codepipeline.sh) - A deployment script that deploys the AWS CodePipeline CloudFormation stack defined in `codepipeline_apprunner.yaml`.

## Src Folder

- `basicapp`: Contains the source code for the frontend (nginx) and backend (counter) of the application.
- `basiccontainer`: Contains a simple container setup for a basic script.
