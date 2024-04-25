variable "resource_group_location" { }

variable "resource_group_name" { }

variable "environment_name" { }

variable "pg_password" {
  default   = ""
  sensitive = true
}
