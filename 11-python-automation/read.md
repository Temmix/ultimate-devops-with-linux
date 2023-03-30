For this to work, use run terraform on git branch python-automation (this will help to spin up 3 ec2 servers)

Install boto3 to communicate with aws
pip install boto3

Install schedule in order to write scheduler in python
pip install schedule

For using scripts health-check.py and add-tags.py 
    Manaully create multiple ec2 in different region
    
For using script eks-status.py
    use the git branch using-eks-clusters to spin up the eks cluster
