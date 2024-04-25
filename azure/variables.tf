variable "environment_name" {
  description = "The name of the environment"
  type        = string
  default     = "local"
}

variable "pg_password" {
  default   = ""
  sensitive = true
}
