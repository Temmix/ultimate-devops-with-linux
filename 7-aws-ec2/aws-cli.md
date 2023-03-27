INTERACTING WITH AWS USING CLI

    Install aws-cli on your machine first
        - Check if it is already installed by  aws --version
        - Else brew install awscli

    Configure the aws-cli
        aws configure
        Then it will prompt for the following information
            Aws Access key: AKIKJDMANSIUEFNJASKNDJ, 
            Aws Secret Access Key: dJkdjkkJKJDKSFUDKDJFKSEUI,
            Default region name: eu-west-2, Default output format: json

    AWS CONFIGURATION ON LOCAL MACHINE
        ls ~/.aws
            config  credentials

        ls -l ~/.aws
            -rw-------  1 Temmi  staff   43 17 Jan 22:40 config
            -rw-------  1 Temmi  staff  116 17 Jan 22:40 credentials

        cat ~/.aws/config
        cat ~/.aws/credentials

    GET INFORMATION ABOUT SECURITY GROUP AND VPC
        ~ aws ec2 describe-instances
        ~ aws ec2 describe-security-groups 
        ~ aws ec2 describe-security-groups  --group-ids sg-02940e097fca98427
        ~ aws ec2 describe-subnets   subnet-e37ec099
        ~ aws ec2 describe-vpcs   vpc-168fe77e

    ami-084e8c05825742534

    CREATE A SECURITY GROUP
        aws ec2 create-security-group --group-name my-sG --description "My sG" --vpc-id vpc-168fe77e

    SET THE FIREWALL INBOUND SETTINGS
        aws ec2 authorize-security-group-ingress \
        --group-id sg-02940e097fca98427 \
        --protocol tcp \
        --port 22 \
        --cidr 90.243.178.104/32

    CREATE A KEY-PAIR FOR SSH
        aws ec2 create-key-pair \
        --key-name MyKpCli \
        --query 'KeyMaterial' \
        --output text > MyKpCli.pem

    THEN MOVE THE KEY-PAIR INTO .SSH DIRECTORY
        mv MyKpCli.pem ~/.ssh/

    CREATE EC2 INSTANCE WITH THE NECESSARY INFORMATION
        aws ec2 run-instances \
        --image-id ami-084e8c05825742534  \
        --count 1 \
        --instance-type t2.micro  \
        --key-name MyKpCli  \
        --security-group-ids sg-02940e097fca98427  \
        --subnet-id subnet-e37ec099 