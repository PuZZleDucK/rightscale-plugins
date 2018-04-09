# AWS EC2 Plugin

## Overview
The AWS EC2 Plugin integrates RightScale Self-Service with the basic functionality of AWS EC2.

## Requirements
- A general understanding CAT development and definitions.
  - Refer to the guide documentation for details [SS Guides](http://docs.rightscale.com/ss/guides/).
- Admin rights to a RightScale account with SelfService enabled.
  - Admin is needed to set/retrieve the RightScale Credentials for the EC2 API.
- AWS Account credentials with the appropriate permissions to manage elastic cloud compute instances.
- The following RightScale Credentials:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
- ??? The following packages are also required (See the Installation section for details):
  - ??? [sys_log](../../libraries/sys_log.rb)

## Installation
1. Be sure your RightScale account is SelfService enabled
1. Follow the Getting Started section to create a Service Account and RightScale Credentials
1. Navigate to the appropriate SelfService portal
   - For more details on using the portal review the [SS User Interface Guide](http://docs.rightscale.com/ss/guides/ss_user_interface_guide.html)
1. In the Design section, use the `Upload CAT` interface to complete the following:
   1. Upload each of packages listed in the Requirements Section
   1. Upload the `aws_ec2_plugin.rb` file located in this repository

## How to Use
The EC2 Plugin has been packaged as `plugin/rs_aws_ec2`. In order to use this plugin you must import this plugin into a CAT.
```
import "plugin/rs_aws_ec2"
```
For more information on using packages, please refer to the RightScale online documenataion. [Importing a Package](http://docs.rightscale.com/ss/guides/ss_packaging_cats.html#importing-a-package)

AWS EC2 resources can now be created by specifying a resource declaration with the desired fields. See the Supported Actions section for a full list of supported actions.
The resulting resource can be manipulated just like the native RightScale resources in RCL and CAT. See the Examples Section for more examples and complete CAT's.
## Supported Resources
 - ec2
 - tags

## Usage
```
#Creates an EC2 instance
resource "my_ec2", type: "rs_aws_ec2.ec2" do
  dry_run false
  no_reboot false
end

```

## Resources
## ec2
#### Supported Fields
| Field Name | Required? | Description |
|------------|-----------|-------------|
|block_device_mapping_1|No|Attach one or more block devices to the ec2 instance.|
|block_device_mapping_2|No|Attach one or more block devices to the ec2 instance.|
|block_device_mapping_3|No|Attach one or more block devices to the ec2 instance.|
|description|No|Provide a description for the ec2 image being created.|
|dry_run|No|Checks you have the required permissions for the action, without making a request, and provides an error response.|
|instance_id|Yes|The ID of the instance.|
|name|Yes|Specify a name for the new image.|
|no_reboot|No|If set, Amazon EC2 doesn't shut down the instance before creating the image.|

## Supported Actions
| Action | API Implementation | Support Level |
|--------------|:----:|:-------------:|
| create | [CreateImage](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateImage.html) | Untested |
| destroy | [DeleteImage](https://docs.aws.amazon.com/appstream2/latest/APIReference/API_DeleteImage.html) | Untested |
| list, get, show | [DescribeImages](https://docs.aws.amazon.com/appstream2/latest/APIReference/API_DescribeImages.html) | Untested |
| create_tag | [CreateTags](http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html) | Untested |
| delete_tag | [DeleteTags](http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteTags.html) | Untested |

## tags
#### Supported Fields
| Field Name | Required? | Description |
|------------|-----------|-------------|
|resource_id_1| Yes | The IDs of one or more resources to tag. |
|tag_1_key| Yes | Tag Key |
|tag_1_value | Yes | Tag Value |

## Supported Actions
| Action | API Implementation | Support Level |
|--------------|:----:|:-------------:|
| create | [CreateTags](http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html) | Supported |
| destroy | [DeleteTags](http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteTags.html) | Supported |

# Implementation Notes
- The AWS EC2 Plugin makes no attempt to support non-AWS resources. (i.e. Allow the passing the RightScale or other resources as arguments to an EC2 resource).

Full list of possible actions can be found on the [AWS EC2 API Documentation](http://docs.aws.amazon.com/AWSEC2/latest/APIReference/Welcome.html)
## Examples
Please review [ec2_plugin_test_cat.rb](./ec2_plugin_test_cat.rb) for a basic example implementation.

## Known Issues / Limitations

## Getting Help
Support for this plugin will be provided though GitHub Issues and the RightScale public slack channel #plugins.
Visit http://chat.rightscale.com/ to join!

## License
The AWS EC2 Plugin source code is subject to the MIT license, see the [LICENSE](../../LICENSE) file.
