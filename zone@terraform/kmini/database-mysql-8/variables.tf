variable "mysql_root_password" {
  description = "Root密码"
  type        = string
}

variable "mysql_root_host" {
  description = "Root访问专用Host"
  type        = string
  default     = "%"
}

variable "mysql_user" {
  description = "新建MySQL账号"
  type        = string
  default     = "zero"
}

variable "mysql_password" {
  description = "新建MySQL账号密码"
  type        = string
}

variable "mysql_data_path" {
  description = "MySQL数据目录"
  type        = string
}

variable "mysql_account" {
  default = <<-EOF
    GRANT ALL PRIVILEGES ON *.* TO 'zero'@'%';
    FLUSH PRIVILEGES;
  EOF
}