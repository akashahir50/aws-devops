resource "aws_instance" "jenkins" {
  ami                    = var.jenkins_ami
  instance_type          = "t3.medium"
  key_name               = var.key_name
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.jenkins_profile.name

  tags = {
    Name = "jenkins-server"
  }
}

