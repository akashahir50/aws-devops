# ========================================
# Terraform Outputs
# ========================================

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.app.repository_url
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.app.name
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_url" {
  description = "URL of the Application Load Balancer"
  value       = "http://${aws_lb.main.dns_name}"
}

output "cloudwatch_log_group_ecs" {
  description = "CloudWatch log group for ECS tasks"
  value       = aws_cloudwatch_log_group.ecs.name
}

output "jenkins_url" {
  description = "Jenkins server URL"
  value       = "http://${aws_instance.jenkins.public_ip}:8080"
}

output "deployment_instructions" {
  description = "Instructions for deploying the application using Jenkins"
  value = <<-EOT

    ========================================
    Jenkins + ECS Deployment Ready!
    ========================================

    Application URL:
    http://${aws_lb.main.dns_name}

    Jenkins URL:
    http://${aws_instance.jenkins.public_ip}:8080

    ECS Console:
    https://${var.aws_region}.console.aws.amazon.com/ecs/home?region=${var.aws_region}#/clusters/${aws_ecs_cluster.main.name}/services

    Next Steps:
    1. Open Jenkins and complete initial setup
    2. Create a Pipeline job using the Jenkinsfile
    3. Push code to GitHub to trigger Jenkins
    4. Monitor deployment in Jenkins UI
    5. View logs in CloudWatch: ${aws_cloudwatch_log_group.ecs.name}

    To trigger Jenkins manually:
    - Open Jenkins UI
    - Click "Build Now"

    ========================================

  EOT
}

