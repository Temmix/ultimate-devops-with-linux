import boto3

# Default region in .aws config file
# ec2_client = boto3.client('ec2')

ec2_client = boto3.client('ec2', region_name="eu-west-3")
all_available_vpcs = ec2_client.describe_vpcs()

vpcs = all_available_vpcs["Vpcs"]

for vpc in vpcs:
    print(f"The vpcId is {vpc['VpcId']}")
    cidr_block_assoc_sets = vpc["CidrBlockAssociationSet"]
    for assoc_set in cidr_block_assoc_sets:
        print(
            f"The association set block state is {assoc_set['CidrBlockState']}")


# working with vpc
ec2_resource = boto3.resource('ec2', region_name="eu-west-3")

new_vpc = ec2_resource.create_vpc(CidrBlock="10.0.0.0/16")
new_vpc.create_subnet(CidrBlock="10.0.1.0/24")
new_vpc.create_subnet(CidrBlock="10.0.2.0/24")
new_vpc.create_tags(Tags=[{'Key': 'Name', 'Value': 'my-vpc'}])

# You have to clean up this resources manually, one merit of terraform
