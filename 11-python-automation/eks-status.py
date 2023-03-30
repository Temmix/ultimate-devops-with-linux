import boto3

client = boto3.client('eks', region_name="eu-west-3")
clusterNames = client.list_clusters()['clusters']

for clusterName in clusterNames:
    response = client.describe_cluster(name=clusterName)
    cluster_info = response['cluster']
    cluster_status = cluster_info['status']
    cluster_endpoint = cluster_info['endpoint']
    cluster_version = cluster_info['version']

    print(f"Cluster {clusterName} status is {cluster_status}")
    print(f"Cluster {clusterName} version is {cluster_version}")
    print(f"Cluster endpoint is : {cluster_endpoint}")
print("###################################################")