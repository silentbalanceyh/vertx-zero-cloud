variable "pgsql_password" {
  description = "postgres密码"
  type        = string
}

variable "pgsql_user" {
  description = "postgres账号"
  type        = string
  default     = "postgres"
}

variable "pgsql_db" {
  description = "postgres数据库"
  type        = string
  default     = "postgres"
}

variable "pgsql_tz" {
  description = "postgres时区"
  type        = string
  default     = "Asia/Shanghai"
}

variable "pgsql_data_path" {
  description = "pgsql数据目录"
  type        = string
}