provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-09d56f8956ab235b3"
  instance_type          = "t2.micro"
  key_name               = "docker"
  monitoring             = true
  vpc_security_group_ids = ["sg-00eaff57610a9bb3d"]
  subnet_id              = "subnet-0b5a55464587680c0"
    user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "terraform-instance"
    Terraform   = "true"
    Environment = "dev"
  }
}
