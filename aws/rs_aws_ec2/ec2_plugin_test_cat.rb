name 'AWS EC2 Test CAT'
rs_ca_ver 20161221
short_description "AWS EC2 Test - Test CAT"
import "sys_log"
import "plugin/rs_aws_ec2"

output "list_ec2" do
  label 'list action'
end

resource "my_ec2", type: "rs_aws_ec2.ec2" do
  cidr_block "10.0.0.0/16"  # TODO: ec2 resource properties
  instance_tenancy "default"
end

resource "my_rs_ec2_tag", type: "rs_aws_ec2.tags" do
  resource_id_1 @my_rs_ec2.resource_uid
  tag_1_key "Name"
  tag_1_value @@deployment.name
end

operation 'list_ec2' do
  definition 'list_ec2s'
  output_mappings do{
    $list_ec2 => $object
  } end
end

operation "launch" do  # TODO: ???
  definition "generated_launch"
end

operation "terminate" do
  definition "generated_terminate"
end

define list_ec2s(@my_ec2) return $object do
  call rs_aws_ec2.start_debugging()
  @ec2s = rs_aws_ec2.ec2.list()
  $object = to_object(first(@ec2s))
  $object = to_s($object)
  call rs_aws_ec2.stop_debugging()
end

  # TODO: update ec2 definitions
define generated_launch(@my_ec2,@my_rs_ec2,@my_rs_ec2_tag) return @my_ec2,@my_rs_ec2,@my_rs_ec2_tag do
  provision(@my_ec2)
  provision(@my_rs_ec2)
  @ec21 = rs_aws_ec2.ec2.show(ec2Id: @my_rs_ec2.resource_uid) # remove _rs? and ec21?
  provision(@my_rs_ec2_tag)
  @ec21.create_tag(tag_1_key: "new_key", tag_1_value: "new_value")
end

define generated_terminate(@my_ec2,@my_rs_ec2) do
  delete(@my_ec2)
  delete(@my_rs_ec2)
end
