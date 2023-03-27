CREATE EKS CLUSTER USING COMMAND LINE

After configuring your aws


check you have aws config setup
    aws configure list

Install eksctl using brew    
    brew tap weaveworks/tap
    brew install weaveworks/tap/eksctl

Create a cluster on aws using eksctl
   eksctl create cluster \
     --name temmix-cluster  \
     --version 1.25  \
     --region eu-west-2  \
     --nodegroup-name temmix-nodes \
     --node-type t2.micro  \
     --nodes 2  \
     --nodes-min 1  \
     --nodes-max 3

Delete the cluster
    eksctl delete cluster --name=temmix-cluster


- Spin up linode or akamai kubernetes cluster
    export KUBECONFIG=~/path/akamai-cluster-kubeconfig.yaml
    kubectl get node 

- add akamai-cluster-kubeconfig.yaml as a secret file to credential in jenkins
- add kubernetes cli to the plugins in jenkins
- 

Create a docker secret from the terminal using kubectl
    kubectl create secret docker-registry my-registry-key \
    --docker-server=docker.io \
    --docker-username=temmix  \
    --docker-password=13Seikos
