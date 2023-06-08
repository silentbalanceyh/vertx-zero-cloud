resource "docker_container" "terraform-mysql-8" {
  image    = docker_image.mysql.name
  name     = "terraform-mysql-8"
  hostname = "ox.engine.cn"
  env      = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
    "MYSQL_ROOT_HOST=${var.mysql_root_host}",
    "MYSQL_USER=${var.mysql_user}",
    "MYSQL_PASSWORD=${var.mysql_password}"
  ]
  volumes {
    host_path      = var.mysql_data_path
    container_path = "/var/lib/mysql"
  }
  networks_advanced {
    name = docker_network.mysql_network.name
  }
  upload {
    content    = var.mysql_account
    file       = "/docker-entrypoint-initdb.d/account.sql"
    executable = true
  }
  ports {
    internal = 3306
    external = 3306
  }
}

resource "docker_image" "mysql" {
  name         = "mysql:8.0.32"
  keep_locally = true
}

resource "docker_network" "mysql_network" {
  name = "mysql_network"
}