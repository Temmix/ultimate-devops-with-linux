import boto3
from operator import itemgetter
import schedule

ec2_clients = boto3.client('ec2', region_name="eu-west-3")
volumes = ec2_clients.describe_volumes(Filters=[{"Name": "tag:Name", "Values": ["PROD"]}])


def clean_up_snapshots():
    for volume in volumes['Volumes']:
        self_snapshots = ec2_clients.describe_snapshots(OwnerIds=['self'],
                                                        Filters=[{"Name": "volume-id", "Values": [volume["VolumeId"]]}])
        sorted_snapshots = sorted(self_snapshots['Snapshots'],
                                  key=itemgetter("StartTime"), reverse=True)

        # Delete all snapshots except the first/latest 2 snapshots
        for snap in sorted_snapshots[2:]:
            ec2_clients.delete_snapshot(SnapshotId=snap['SnapshotId'])
            print(ec2_clients)
    print('***************** Snapshots clean up operation completed! ************************')


schedule.every(20).seconds.do(clean_up_snapshots)
# schedule.every().day.at("12:00")
# schedule.every().monday.at("12:00")

while True:
    schedule.run_pending()
