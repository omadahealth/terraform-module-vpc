## terraform-module-vpc

Terraform module which declares a AWS VPC

### Usage

Example usage.

```
module "test-vpc" {
  cidr   = "10.255.254.0/24"
  name   = "test-vpc"
  environment = "test"
  region = "us-west-2"
}
```

#### Variables

| Variable Name | Type   | Purpose                                                         |
| ------------- | ------ | --------------------------------------------------------------- |
| `cidr`        | String | Defines the IP space for the VPC (CIDR, <ip>/<netmask>, format) |
| `name`        | String | Value of `Name` tag associated with VPC resource                |
| `environment` | String | Value of `Environment` tag associated with VPC resource         |
| `tenancy`     | String | Used to specify instance tenancy requirement                    |
| `region`      | String | Defines the region in which to launch VPC resource              |

#### Outputs

| Output Name              | Type   | Serialized                     | Purpose                                       |
| ------------------------ | ------ | ------------------------------ | --------------------------------------------- |
| `dmz_subnet_ids`         | String | Yes, comma delineated elements | A serialized array of DMZ subnet IDs          |
| `private_subnet_ids`     | String | Yes, comma delineated elements | A serialized array of Private subnet IDs      |
| `dmz_subnet_cidrs`       | String | Yes, comma delineated elements | A serialized array of DMZ subnet CIDRs        |
| `private_subnet_cidrs`   | String | Yes, comma delineated elements | A serialized array of Private subnet CIDRs    |
| `availability_zones`     | String | Yes, comma delineated elements | A serialized array of availability zone IDs   |
| `default_sg`             | String | No                             | Default security group ID for VPC             |
| `vpc_id`                 | String | No                             | ID of VPC resource                            |
| `private_route_tables`   | String | Yes, comma delineated elements | A serialized array of Private Route table IDs |
| `dmz_route_table`        | String | No                             | ID of DMZ route table                         |


### Testing

To test this module go into the test directory and do a `make test`.  This will create a test vpc with a few instances in both the dmz and private networks, then do some sanity checks for connectivity with those instances then destroy it all.

### Contributing

#### Environment Bootstrap

#### Issue/Bug/Feature-request Tracking

### Authors
