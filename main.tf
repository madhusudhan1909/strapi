provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "strapi_instance" {
  instance_id = "i-071170ba4826f6150"  // Specify the existing instance ID

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y npm",
      "sudo npm install pm2 -g",
      "cd /home/ubuntu/strapi/examples/getstarted",
      "npm install",
      "pm2 start npm --name 'strapi' -- start"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
      host        = "13.229.80.114"  // Update with your existing instance's public IP
    }
  }

  tags = {
    Name = "TASK2-STRAPI"
  }
}

output "instance_public_ip" {
  value = aws_instance.strapi_instance.public_ip
}

output "instance_private_ip" {
  value = aws_instance.strapi_instance.private_ip
}
