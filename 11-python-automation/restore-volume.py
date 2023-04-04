import boto3
from operator import itemgetter
import schedule

ec2_client = boto3.client('ec2', region_name="eu-west-3")
ec2_resource = boto3.resource('ec2', region_name="eu-west-3")

instance_id = "i-0678745e198e3c8ec"
volumes = ec2_client.describe_volumes(Filters=[{'Name': 'attachment.instance-id', 'Values': [instance_id]}])
instance_volume = volumes['Volumes'][0]

snapshots = ec2_client.describe_snapshots(OwnerIds=['self'],
                                          Filters=[{"Name": "volume-id", "Values": [instance_volume["VolumeId"]]}])
latest_snapshots = sorted(snapshots['Snapshots'],
                          key=itemgetter("StartTime"), reverse=True)[0]
print(latest_snapshots)
new_volume = ec2_client.create_volume(
    SnapshotId=latest_snapshots['SnapshotId'],
    AvailabilityZone="eu-west-3b",
    TagSpecifications=[
        {
            'ResourceType': 'volume',
            'Tags': [
                {
                    'Key': 'Name',
                    'Value': 'PROD'
                }
            ]
        }
    ]
)

while True:
    vol = ec2_resource.Volume(new_volume['VolumeId'])
    if vol.state == 'available':
        ec2_resource.Instance(instance_id).attach_volume(
            VolumeId=new_volume['VolumeId'],
            Device='/dev/xvdb'
        )
        break

print('############################# OPERATION COMPLETED ##############################################')
