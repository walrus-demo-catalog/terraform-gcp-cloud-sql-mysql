<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.51.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.51.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_database.database](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.users](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_architecture"></a> [architecture](#input\_architecture) | Specify the deployment architecture, select from standalone or replication. | `string` | `"standalone"` | no |
| <a name="input_context"></a> [context](#input\_context) | Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.<br><br>Examples:<pre>context:<br>  project:<br>    name: string<br>    id: string<br>  environment:<br>    name: string<br>    id: string<br>  resource:<br>    name: string<br>    id: string</pre> | `map(any)` | `{}` | no |
| <a name="input_database"></a> [database](#input\_database) | Specify the database name. The database name must be 1-60 characters long and start with any lower letter, combined with number, or symbols: - \_.<br>The database name cannot be MySQL forbidden keyword. | `string` | `"mydb"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Specify the deployment engine version, select from https://cloud.google.com/sql/docs/db-versions. | `string` | `"8.0"` | no |
| <a name="input_infrastructure"></a> [infrastructure](#input\_infrastructure) | Specify the infrastructure information for deploying.<br><br>Examples:<pre>infrastructure:<br>  vpc_id: string                  # the ID of the VPC where the MySQL service applies<br>  kms_key_id: string,optional     # the ID of the KMS key which to encrypt the MySQL data<br>  domain_suffix: string,optional  # a private DNS namespace of the PrivateZone where to register the applied MySQL service<br>  publicly_accessible: bool       # whether the MySQL service is publicly accessible</pre> | <pre>object({<br>    vpc_id              = optional(string)<br>    kms_key_id          = optional(string)<br>    domain_suffix       = optional(string)<br>    publicly_accessible = optional(bool, false)<br>  })</pre> | <pre>{<br>  "publicly_accessible": true<br>}</pre> | no |
| <a name="input_password"></a> [password](#input\_password) | Specify the account password. The password must be more than 8-128 characters long and start with any letter, number, or symbols: ! # $ % ^ & * ( ) \_ + - =.<br>If not specified, it will generate a random password. | `string` | `null` | no |
| <a name="input_resources"></a> [resources](#input\_resources) | Specify the computing resources.<br>The computing resource design of Google Cloud is very complex, it also needs to consider on the storage resource, please view the specification document for more information.<br><br>Examples:<pre>resources:<br>  class: string, optional            # https://cloud.google.com/sql/docs/mysql/instance-settings</pre> | <pre>object({<br>    class = optional(string, "db-g1-small")<br>  })</pre> | <pre>{<br>  "class": "db-g1-small"<br>}</pre> | no |
| <a name="input_storage"></a> [storage](#input\_storage) | Specify the storage resources, select from PD\_SSD or PD\_HDD.<br>Choosing the storage resource is also related to the computing resource, please view the specification document for more information.<br><br>Examples:<pre>storage:<br>  class: string, optional        # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#disk_type<br>  size: number, optional         # in megabyte</pre> | <pre>object({<br>    class = optional(string, "PD_SSD")<br>    size  = optional(number, 10 * 1024)<br>  })</pre> | <pre>{<br>  "class": "PD_SSD",<br>  "size": 10240<br>}</pre> | no |
| <a name="input_username"></a> [username](#input\_username) | Specify the account username. The username must be 1-32 characters long and start with lower letter, combined with number.<br>The username cannot be MySQL forbidden keyword and azure\_superuser, admin, administrator, root, guest or public. | `string` | `"rdsuser"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | The address, a string only has host, might be a comma separated string or a single string. |
| <a name="output_connection"></a> [connection](#output\_connection) | The connection, a string combined host and port, might be a comma separated string or a single string. |
| <a name="output_context"></a> [context](#output\_context) | The input context, a map, which is used for orchestration. |
| <a name="output_database"></a> [database](#output\_database) | The name of MySQL database to access. |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The DNS name of the instance. |
| <a name="output_password"></a> [password](#output\_password) | The password of the account to access the database. |
| <a name="output_port"></a> [port](#output\_port) | The port of the service. |
| <a name="output_username"></a> [username](#output\_username) | The username of the account to access the database. |
<!-- END_TF_DOCS -->