import boto3
import schedule

# Create a minimum of 3 or more ec2 instances on the specified region before running this script
ec2_client = boto3.client('ec2', region_name="eu-west-3")


def check_instance_status():
    statuses = ec2_client.describe_instance_status(IncludeAllInstances=True)
    for status in statuses["InstanceStatuses"]:
        ins_status = status['InstanceStatus']['Status']
        sys_status = status['SystemStatus']['Status']
        state = status['InstanceState']
        print(f"Instance {status['InstanceId']} is {state['Name']} with instance status {ins_status} and system status is {sys_status}")
    print('##########################################################\n')


schedule.every(5).seconds.do(check_instance_status)
# schedule.every().day.at("12:00")
# schedule.every().monday.at("12:00")

while True:
    schedule.run_pending()