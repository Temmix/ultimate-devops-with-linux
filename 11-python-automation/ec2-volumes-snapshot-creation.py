import boto3
import schedule

ec2_clients = boto3.client('ec2', region_name="eu-west-3")


def create_ec2_volume_snapshot():
    volumes = ec2_clients.describe_volumes(Filters=[{"Name": "tag:Name", "Values": ["PROD"]}])
    # Filters=[{'Name': 'tag:Name', 'Values': ['PROD']}]

    for volume in volumes['Volumes']:
        new_snapshot = ec2_clients.create_snapshot(VolumeId=volume['VolumeId'])
        print(new_snapshot)
    print('#######################################################################')


schedule.every(20).seconds.do(create_ec2_volume_snapshot)
# schedule.every().day.at("12:00")
# schedule.every().monday.at("12:00")

while True:
    schedule.run_pending()
