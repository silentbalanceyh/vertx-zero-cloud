resource "docker_container" "terraform-pgsql" {
  image    = docker_image.postgres.name
  name     = "terraform-pgsql"
  hostname = "ox.engine.cn"
  env      = [
    "POSTGRES_PASSWORD=${var.pgsql_password}",
    "POSTGRES_USER=${var.pgsql_user}",
    "POSTGRES_DB=${var.pgsql_db}",
    "TZ=${var.pgsql_tz}"
  ]
  volumes {
    host_path      = var.pgsql_data_path
    container_path = "/var/lib/postgresql/data"
  }
  networks_advanced {
    name = docker_network.pgsql_network.name
  }
  ports {
    internal = 5432
    external = 5432
  }
}

resource "docker_image" "postgres" {
  name         = "postgres:latest"
  keep_locally = true
}

resource "docker_network" "pgsql_network" {
  name = "pgsql_network"
}