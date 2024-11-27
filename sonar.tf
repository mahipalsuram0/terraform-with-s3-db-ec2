resource "aws_instance" "mySonarInstance" {
      ami           = "ami-0166fe664262f664c"
      key_name = var.key_name
      instance_type = "t2.micro"
      vpc_security_group_ids = [aws_security_group.sg-02e40c7805387bb2c.id]
      tags= {
        Name = "sonar_instance"
      }
    }

 resource "aws_security_group" "security_group" {
      name        = "open to world"
      description = "open to world"

      ingress {
        from_port   = 9000
        to_port     = 9000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

     ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

     # outbound from Sonar server
      egress {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

      tags= {
        Name = "security_group"
      }
    }

# Create Elastic IP address for Sonar instance
resource "aws_eip" "mySonarInstance" {
  vpc      = true
  instance = aws_instance.mySonarInstance.id
tags= {
    Name = "sonar_elastic_ip"
  }
}
