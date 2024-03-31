resource "null_resource" "run_pre_hello_powershell_script" {
  triggers = {
    always_run = "${timestamp()}" # make sure this is run each time
  }

  provisioner "local-exec" {
    command     = "powershell -File ${path.module}/scripts/PrepareFunction.ps1 -ProjectName MTR.ListBlobsFunction"
    working_dir = path.module
  }
}
