name 'aws_ec2_plugin'
type 'plugin'
rs_ca_ver 20161221
short_description "Amazon Web Services - EC2 Plugin"
long_description "Version 1.0"
package "plugin/rs_aws_ec2"
import "sys_log"

plugin "rs_aws_ec2" do
  endpoint do
    default_host "ec2.amazonaws.com"
    default_scheme "https"
    query do {
      "Version" => "2016-11-15" # TODO: check AWS API versioning
    } end
  end

  type "ec2" do
    # HREF is set to the correct template in the provision definition due to a lack of usable fields in the response to build the href
    href_templates "/?Action=DescribeEc2s&Ec2Id.1={{//CreateEc2Response/ec2/ec2Id}}","/?DescribeEc2s&Ec2Id.1={{//DescribeEc2sResponse/ec2Set/item/ec2Id}}"
    provision 'provision_ec2'
    delete    'delete_ec2'

    field "block_device_mapping_1" do
      alias_for " BlockDeviceMapping.1"
      type      "string"
      location  "query"
    end

    field "block_device_mapping_2" do
      alias_for " BlockDeviceMapping.2"
      type      "string"
      location  "query"
    end

    field "block_device_mapping_3" do
      alias_for " BlockDeviceMapping.3"
      type      "string"
      location  "query"
    end

    field "block_device_mapping_4" do
      alias_for " BlockDeviceMapping.4"
      type      "string"
      location  "query"
    end

    field "block_device_mapping_5" do
      alias_for " BlockDeviceMapping.5"
      type      "string"
      location  "query"
    end

    field "description" do
      alias_for "Description"
      type      "string"
      location  "query"
    end

    field "dry_run" do
      alias_for "DryRun"
      type      "boolean"
      location  "query"
      # DEFAULT: false
    end

    field "instance_id" do
      alias_for "InstanceId"
      type      "string"
      location  "query"
    end

    field "name" do
      alias_for "Name"
      type      "string"
      location  "query"
    end

    field "no_reboot" do
      alias_for "NoReboot"
      type      "boolean"
      location  "query"
      # DEFAULT: false
    end

    # https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateImage.html
    action "create" do # TODO: ac2 actions
      verb "POST"
      path "/?Action=CreateImage"
      output_path "//CreateImageResponse/ec2"
    end

    # https://docs.aws.amazon.com/appstream2/latest/APIReference/API_DeleteImage.html
    action "destroy" do
      verb "DELETE"
      path "/?Action=DeleteImage&InstanceId=$instanceId"
    end

    # https://docs.aws.amazon.com/appstream2/latest/APIReference/API_DescribeImages.html
    action "get" do
      verb "POST"
      output_path "//DescribeImagesResponse/imageSet/item"
    end

    # https://docs.aws.amazon.com/appstream2/latest/APIReference/API_DescribeImages.html
    action "show" do
      path "/?Action=DescribeImages"
      verb "POST"
      output_path "//DescribeImagesResponse/imageSet/item"
      field "ImageId" do
        alias_for "ImageId.1"
        location "query"
      end
    end

    # https://docs.aws.amazon.com/appstream2/latest/APIReference/API_DescribeImages.html
    action "list" do
      verb "POST"
      path "/?Action=DescribeImages"
      output_path "//DescribeImagesResponse/imageSet/item"
    end

    action "create_tag" do
      path "/?Action=CreateTags&ResourceId.1=$ec2Id"
      verb "POST"
      field "tag_1_key" do
        alias_for "Tag.1.Key"
        location "query"
      end

      field "tag_1_value" do
        alias_for "Tag.1.Value"
        location "query"
      end
    end

    action "delete_tag" do
      path "/?Action=CreateTags&ResourceId.1=$ec2Id"
      verb "DELETE"
      field "tag_1_key" do
        alias_for "Tag.1.Key"
        location "query"
      end
    end

  # https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RebootInstances.html
  action "reboot" do
    verb "POST"
    path "/?Action=RebootInstances&InstanceId.1=$InstanceId.1&InstanceId.2=$InstanceId.2"
    output_path "//RebootCacheClusterResult/CacheCluster"

    field "node_id_1" do
      alias_for "InstanceId.1"
      location "query"
    end

    field "node_id_2" do
      alias_for "InstanceId.2"
      location "query"
    end
  end

# TODO: check: ImageSet

    output "ec2Id" do
      type "simple_element" # TODO: better types
    end

    output "instanceId" do
      type "simple_element"
    end

    output "instanceType" do
      type "simple_element"
    end

    output "availabilityZone" do
      type "simple_element"
    end

    output "state" do
      type "simple_element"
    end

    output "statusCheck" do
      type "simple_element"
    end

    output "alarmStatus" do
      type "simple_element"
    end

    output "publicDns" do
      type "simple_element"
    end

    output "publicIp" do
      type "simple_element"
    end

    output "keyName" do
      type "simple_element"
    end

    output "monitoring" do
      type "simple_element"
    end

    output "launchTime" do
      type "simple_element"
    end

    output "securityGroups" do
      type "simple_element"
    end

    output "tagSet" do
      type "simple_element"
    end

    output "instanceTenancy" do
      type "simple_element"
    end
  end

  type "endpoint" do # TODO: update endpoints
    href_templates "/?Action=DescribeEc2Endpoints&Ec2EndpointId.1={{//CreateEc2EndpointResponse/ec2Endpoint/ec2EndpointId}}","/?Action=DescribeEc2Endpoints&Ec2EndpointId.1={{//DescribeEc2EndpointsResponse/ec2EndpointSet/item/ec2EndpointId}}"
    provision 'provision_endpoint'
    delete    'delete_endpoint'

    field "ec2_id" do
      alias_for "Ec2Id"
      type      "string"
      location  "query"
    end

    field "service_name" do
      alias_for "ServiceName"
      type      "string"
      location  "query"
    end

    field "route_table_id_1" do
      alias_for "RouteTableId.1"
      type      "string"
      location  "query"
    end

    field "ec2_endpoint_type" do
      alias_for "Ec2EndpointType"
      type "string"
      location "query"
    end

    field "private_dns_enabled" do
      alias_for "PrivateDnsEnabled"
      type "string"
      location "query"
    end

    field "security_group_id_1" do
      alias_for "SecurityGroupId.1"
      type "string"
      location "query"
    end

    output "ec2EndpointId" do
      type "simple_element"
    end

    output "ec2Id" do
      type "simple_element"
    end

    output "state" do
      type "simple_element"
    end

    output "routeTableIdSet" do
      type "array"
    end

    output "creationTimestamp" do
      type "simple_element"
    end

    output "policyDocument" do
      type "simple_element"
    end

    output "serviceName" do
      type "simple_element"
    end

    action "create" do
      verb "POST"
      path "/?Action=CreateEc2Endpoint"
      output_path "//CreateEc2EndpointResponse/ec2Endpoint"
    end

    action "destroy" do
      verb "POST"
      path "/?Action=DeleteEc2Endpoints&Ec2EndpointId.1=$ec2EndpointId"
    end

    action "get" do
      verb "POST"
      output_path "//DescribeEc2EndpointsResponse/ec2EndpointSet/item"
    end

    action "list" do
      verb "POST"
      path "/?Action=DescribeEc2Endpoints"
      output_path "//DescribeEc2EndpointsResponse/ec2EndpointSet/item"
    end
  end

  type "tags" do
    href_templates "/?Action=DescribeTags&Filter.1.Name=key&Filter.1.Value={{//DescribeTagsResponse/tagSet/item/key}}&Filter.2.Name=value&Filter.2.Value={{//DescribeTagsResponse/tagSet/item/value}}&Filter.3.Name=resource-id&Filter.3.Value.1={{//DescribeTagsResponse/tagSet/item/resourceId}}","/?Action=DescribeTags&Filter.1.Name=key&Filter.1.Value=$tag_1_key&Filter.2.Name=value&Filter.2.Value=$tag_1_value&Filter.3.Name=resource-id&Filter.3.Value.1=$resource_id_1"
    provision 'provision_tags'
    delete    'delete_tags'

    field "resource_id_1" do
      alias_for "ResourceId.1"
      type "string"
      location "query"
    end

    field "tag_1_key" do
      alias_for "Tag.1.Key"
      type "string"
      location "query"
    end

    field "tag_1_value" do
      alias_for "Tag.1.Value"
      type "string"
      location "query"
    end

    action "create" do
      verb "POST"
      path "/?Action=CreateTags"
    end

    action "get" do
      verb "POST"
      path "/?Action=DescribeTags"
      output_path "//DescribeTagsResponse/tagSet/item"
    end

    action "destroy" do
      verb "POST"
      path "/?Action=DeleteTags"
    end

    action "list" do
      verb "POST"
      path "/?Action=DescribeTags"
      output_path "//DescribeTagsResponse/tagSet/item"
    end

    output "resourceId" do
      type "simple_element"
    end

    output "resourceType" do
      type "simple_element"
    end

    output "key" do
      type "simple_element"
    end

    output "value" do
      type "simple_element"
    end
  end
end

 # TODO: other ec2 data types

resource_pool "vpc_pool" do  # TODO: ec2 equivilent... scaling groups
  plugin $rs_aws_vpc
  auth "key", type: "aws" do
    version     4
    service    'ec2'
    region     'us-east-1'
    access_key cred('AWS_ACCESS_KEY_ID')
    secret_key cred('AWS_SECRET_ACCESS_KEY')
  end
end

define provision_ec2(@declaration) return @ec2 do  # TODO: update definitions to ec2
  sub on_error: stop_debugging() do
    $object = to_object(@declaration)
    $fields = $object["fields"]
    $name = $fields['name']
    call start_debugging()
    @ec2 = rs_aws_ec2.ec2.create($fields)
    call stop_debugging()
    $ec2 = to_object(@ec2)
    call sys_log.detail(join(["ec2:", to_s($ec2)]))
    $state = @ec2.state
    while $state != "available" do
      sleep(10)
      call sys_log.detail(join(["state: ", $state]))
      call start_debugging()
      $state = @ec2.state
      call stop_debugging()
    end
  end
end

define provision_tags(@declaration) return @resource do
  sub on_error: stop_debugging() do
    $object = to_object(@declaration)
    $fields = $object["fields"]
    $name = $fields['name']
    call start_debugging()
    @resource = rs_aws_ec2.tags.create($fields)
    call stop_debugging()
    $ec2 = to_object(@resource)
    call sys_log.detail(join(["tags:", to_s($vpc)]))
  end
end

define delete_ec2(@ec2) do
  sub on_error: stop_debugging() do
    call start_debugging()
    @ec2.destroy()
    call stop_debugging()
  end
end

define delete_tags(@tag) do
  sub on_error: stop_debugging() do
    call start_debugging()
    @tag.destroy()
    call stop_debugging()
  end
end

define no_operation(@resource) return @resource do
  @resource=@resource
end

define start_debugging() do
  if $$debugging == false || logic_and($$debugging != false, $$debugging != true)
    initiate_debug_report()
    $$debugging = true
  end
end

define stop_debugging() do
  if $$debugging == true
    $debug_report = complete_debug_report()
    call sys_log.detail($debug_report)
    $$debugging = false
  end
end
