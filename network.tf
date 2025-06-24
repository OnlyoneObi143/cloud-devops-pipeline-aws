# Create a custom VPC 
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Attach an Internet Gateway to the VPC for outbound internet access
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Create a public subnet in the specified availability zone
# Enable automatic public IP assignment for EC2 tasks in this subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

# Define a route table for the public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

# Add a default route to the internet gateway (for external connectivity)
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Associate the public subnet with the route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create a security group to allow inbound traffic to the app
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Allow inbound access to Node.js app on port 3001"
  vpc_id      = aws_vpc.main.id

  # Inbound rule: Allow traffic on port 3001 from anywhere
  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule: Allow all traffic to the internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
