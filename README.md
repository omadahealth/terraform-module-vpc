## terraform-module-vpc

Terraform module which declares a AWS VPC

### Usage

Example usage.

```
module "test-vpc" {
  cidr   = "10.255.254.0/24"
  name   = "test"
  region = "us-west-2"
}
```

#### Variables

| Variable Name | Type   | Purpose                                                         |
|+-------------+|+------+|+---------------------------------------------------------------+|
| `cidr`        | String | Defines the IP space for the VPC (CIDR, <ip>/<netmask>, format) |
| `name`        | String | Value of `Name` tag associated with VPC resource                |
| `environment` | String | Value of `Environment` tag associated with VPC resource         |

| `region`      | String | Defines the region in which to launch VPC resource              |

#### Outputs

| Output Name          | Type   | Serialized                     | Purpose                                     |
|+--------------------+|+------+|+------------------------------+|+-------------------------------------------+|
| `dmz_subnet_ids`     | String | Yes, comma delineated elements | A serialized array of DMZ subnet IDs        |
| `private_subnet_ids`     | String | Yes, comma delineated elements | A serialized array of Private subnet IDs        |
| `dmz_subnet_cidrs`   | String | Yes, comma delineated elements | A serialized array of DMZ subnet CIDRs      |
| `private_subnet_cidrs`   | String | Yes, comma delineated elements | A serialized array of Private subnet CIDRs      |
| `availability_zones` | String | Yes, comma delineated elements | A serialized array of availability zone IDs |
| `default_sg`         | String | No                             | Default security group ID for VPC           |
| `vpc_id`             | String | No                             | ID of VPC resource                          |

### Contributing

#### Environment Bootstrap

#### Issue/Bug/Feature-request Tracking

### Authors
