import boto3

ec2_client_paris = boto3.client('ec2', region_name="eu-west-3")
ec2_resource_paris = boto3.resource('ec2', region_name="eu-west-3")
instance_ids_paris = []

ec2_client_frankfurt = boto3.client('ec2', region_name="eu-central-1")
ec2_resource_frankfurt = boto3.resource('ec2', region_name="eu-central-1")
instance_ids_frankfurt = []


reservations_paris = ec2_client_paris.describe_instances()['Reservations']
for res in reservations_paris:
    instances = res['Instances']
    for instance in instances:
        instance_ids_paris.append(instance['InstanceId'])

reservations_frankfurt = ec2_client_frankfurt.describe_instances()['Reservations']
for res in reservations_frankfurt:
    instances = res['Instances']
    for instance in instances:
        instance_ids_frankfurt.append(instance['InstanceId'])


response_paris = ec2_resource_paris.create_tags(Resources=instance_ids_paris,
                                                Tags=[{'Key': 'environment', 'Value': 'production'}])

response_frankfurt = ec2_resource_frankfurt.create_tags(Resources=instance_ids_frankfurt,
                                                        Tags=[{'Key': 'environment', 'Value': 'development'}])

