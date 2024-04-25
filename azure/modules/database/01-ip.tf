locals {
  is_linux = length(regexall("/home/", lower(abspath(path.root)))) > 0
}

data "external" "public_ip" {
  program = local.is_linux ? ["${path.module}/../../scripts/get-ip.sh"] : ["powershell", "-File", "${path.module}/../../scripts/GetIp.ps1"]
}
