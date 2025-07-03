output "instance_ids" {
  description = "List of IDs of the created EC2 instance(s)."
  value       = [for instance in values(aws_instance.ec2_instance) : instance.id] 
}

output "instance_public_ips" {
  description = "List of public IPs of the created EC2 instance(s)."
  value       = [for instance in values(aws_instance.ec2_instance) : instance.public_ip]
}

output "instance_private_ips" {
  description = "List of private IPs of the created EC2 instance(s)."
  value       = [for instance in values(aws_instance.ec2_instance) : instance.private_ip]
}

output "key_pair_name" {
  description = "The name of the generated SSH key pair in AWS."
  value       = aws_key_pair.final_task_pair.key_name
}

output "private_key_path" {
  description = "The local file path where the private key is saved."
  value       = local_file.ssh_local_key.filename
}

output "public_key_openssh" {
  description = "The public key in OpenSSH format."
  value       = tls_private_key.tls_private_key.public_key_openssh
  sensitive   = true 
}