# ssh-key.tf

resource "aws_key_pair" "red5_key" {
  key_name   = "red5-key"
  public_key = file(var.public_key_path)
}
