provider "aws" {
  region = "ap-southeast-1"
}

data "aws_instance" "existing_instance" {
  instance_id = "i-071170ba4826f6150"  // Specify the existing instance ID
}
resource "null_resource" "provision_commands" {
  depends_on = [data.aws_instance.existing_instance]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y npm",
      "sudo npm install pm2 -g",
      "npm install",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu" 
      private_key = var.private_key
      host        = "13.229.80.114"  // Update with your existing instance's public IP
    }
  }
}

output "instance_public_ip" {
value = "13.229.80.114"
}

output "instance_private_ip" {
value = "172.31.20.95"
}
