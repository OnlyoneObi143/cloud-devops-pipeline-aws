#ECS cluster to run our containers
resource "aws_ecs_cluster" "app_cluster" {
  name = "node-app-cluster"
}

# IAM role that ECS tasks will assume to access AWS services
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  # Trust policy allowing ECS tasks to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach the required ECS task execution policy to the IAM role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Define the ECS task (like a container blueprint)
resource "aws_ecs_task_definition" "app" {
  family                   = "node-app-task"              # Name group for related tasks
  network_mode             = "awsvpc"                     # Each task gets its own ENI (IP)
  requires_compatibilities = ["FARGATE"]                  # Run on Fargate
  cpu                      = "256"                        # CPU units
  memory                   = "512"                        # Memory in MiB
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn  # Role with permissions

  # Define the container to run in this task
  container_definitions = jsonencode([
    {
      name      = "node-app"
      image     = "203918869432.dkr.ecr.us-east-1.amazonaws.com/node-app-devops:latest"  # From ECR
      portMappings = [{
        containerPort = 3001                        # Internal app port
        hostPort      = 3001                        # Port on the host (ECS/Fargate)
      }]
    }
  ])
}

# Create an ECS Service to run and manage tasks
resource "aws_ecs_service" "app_service" {
  name            = "node-app-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = 1                              # Run 1 instance of this task

  network_configuration {
    subnets         = [aws_subnet.public.id]          # VPC subnet to launch in
    security_groups = [aws_security_group.app_sg.id]  # Allow traffic to/from the container
    assign_public_ip = true                        # Give public IP for internet access
  }
}
