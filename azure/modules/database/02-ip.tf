locals {
  is_linux = length(regexall("/home/", lower(abspath(path.root)))) > 0
}

data "external" "public_ip" {
  program = local.is_linux ? ["powershell", "-File", "${path.module}/../../get_ip.ps1"] : ["${path.module}/../../get_ip.sh"]
}
