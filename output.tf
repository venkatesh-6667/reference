# outputs.tf

output "red5_instance_public_ip" {
  description = "Public IP address of the Red5 server"
  value       = aws_instance.red5_instance.public_ip
}
