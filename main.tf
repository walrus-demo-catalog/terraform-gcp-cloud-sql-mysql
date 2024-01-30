locals {
  project_name     = coalesce(try(var.context["project"]["name"], null), "default")
  project_id       = coalesce(try(var.context["project"]["id"], null), "default_id")
  environment_name = coalesce(try(var.context["environment"]["name"], null), "test")
  environment_id   = coalesce(try(var.context["environment"]["id"], null), "test_id")
  resource_name    = coalesce(try(var.context["resource"]["name"], null), "example")
  resource_id      = coalesce(try(var.context["resource"]["id"], null), "example_id")

  namespace = join("-", [local.project_name, local.environment_name])

  tags = {
    "Name" = join("-", [local.namespace, local.resource_name])

    "walrus.seal.io/catalog-name"     = "terraform-gcp-cloud-sql-mysql"
    "walrus.seal.io/project-id"       = local.project_id
    "walrus.seal.io/environment-id"   = local.environment_id
    "walrus.seal.io/resource-id"      = local.resource_id
    "walrus.seal.io/project-name"     = local.project_name
    "walrus.seal.io/environment-name" = local.environment_name
    "walrus.seal.io/resource-name"    = local.resource_name
  }

  architecture = coalesce(var.architecture, "standalone")
}

#
# Random
#

# create a random password for blank password input.

resource "random_password" "password" {
  length      = 16
  special     = false
  lower       = true
  min_lower   = 3
  min_upper   = 3
  min_numeric = 3
}

# create the name with a random suffix.

resource "random_string" "name_suffix" {
  length  = 10
  special = false
  upper   = false
}

locals {
  name     = join("-", [local.resource_name, random_string.name_suffix.result])
  fullname = join("-", [local.namespace, local.name])
  database = coalesce(var.database, "mydb")
  username = coalesce(var.username, "rdsuser")
  password = coalesce(var.password, random_password.password.result)
}

#
# Deployment
#

locals {
  version = lookup({
    "8.0" = "MYSQL_8_0"
    "5.7" = "MYSQL_5_7"
    "5.6" = "MYSQL_5_6"
  }, var.engine_version, "MYSQL_8_0")

  allowed_networks = ["0.0.0.0/0"]
  publicly_accessible = try(var.infrastructure.publicly_accessible, false)
}

# create instance.

resource "google_sql_database_instance" "instance" {
  name             = local.fullname
  database_version = local.version
  region           = "asia-northeast1"

  settings {
    tier      = var.resources.class
    disk_type = var.storage.class
    disk_size = try(var.storage.size / 1024, 10)

    ip_configuration {
      ipv4_enabled = local.publicly_accessible == true ? true : false

      dynamic "authorized_networks" {
        for_each = local.allowed_networks
        iterator = allowed_networks

        content {
          name  = "allowed_networks"
          value = allowed_networks.value
        }
      }
    }
  }

  deletion_protection = false
}

# create database.

resource "google_sql_database" "database" {
  name      = local.database
  instance  = google_sql_database_instance.instance.name
  charset   = "utf8"
  collation = "utf8_unicode_ci"

  lifecycle {
    ignore_changes = [
      name,
      charset,
      collation
    ]
  }
}

resource "google_sql_user" "users" {
  name     = local.username
  instance = google_sql_database_instance.instance.name
  password = local.password

  lifecycle {
    ignore_changes = [
      name,
      password,
    ]
  }
}