# cloud-devops-pipeline-aws Project

This is **Phase 1-5** of my personal project demonstrating how to build and deploy a containerized Node.js application using GitLab CI/CD and AWS services like ECS, ECR, and CloudWatch. It simulates a real-world DevOps pipeline and showcases skills relevant to both DevOps and Cloud Engineering roles.

## Tech Stack
- Node.js + Express
- GitLab + GitHub
- Docker, ECS, ECR, CloudWatch
- Terraform, GitLab CI/CD


## Phase 1 Summary
✅ Local development environment setup  
✅ Node.js backend built and tested locally  
✅ Code versioned on GitLab and GitHub

## Phase 2 Summary
✅ Dockerfile created to containerize the Node.js app  
✅ Image built and tested locally using Docker  
✅ Docker image tagged and pushed to AWS ECR  
✅ Updated project status pushed to GitHub and GitLab

## Phase 3 Summary
✅ ECS Cluster and Fargate task definition created using Terraform  
✅ IAM role configured for task execution  
✅ Deployed Node.js container to ECS Fargate  
✅ Application running publicly on assigned IP via AWS infrastructure

## Phase 4 Summary
✅ Automated CI/CD pipeline created using GitLab  
✅ Docker image built on commit and pushed to GitLab Container Registry  
✅ ECS service updated automatically via GitLab pipeline using AWS CLI  

## Phase 5 Summary
✅ Integrated AWS CloudWatch to monitor custom application metrics  
✅ Implemented `RequestsPerMinute` metric in Node.js using AWS SDK  
✅ Metrics published and visualized in real-time on a custom CloudWatch graph  
✅ IAM roles and permissions configured to allow secure metric publishing from ECS tasks



## 📊 Monitoring Dashboard

Below is a snapshot of the custom `RequestsPerMinute` CloudWatch metric published from AWS:

![CloudWatch Graph](./assets/cloudwatch-metrics.png)

