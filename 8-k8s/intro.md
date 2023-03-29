Some cmd on kubernetes

kubernetes components
    Pod
    Service and Ingress
    ConfigMap and Secret
    Deployment and Statefulset
    Volumes

POD
This is a group of 1 or more containers and its the small unit of k8s
This is an abstration over container, usually 1 application/container per pods
Pods are ephemeral

SERVICE
Basically as static or permanent IP address that can be attached to each pod
It can serve as a loadBalancer, Lifecycles of services and pods are not connected,
if pod crashes, the service and its IP address will be the same.
When creating a service you can specify its type : 
Internal Service (default), for e.g database which should not be accessible from outside
External Service: Application that are accessible through the browser

INGRESS
Ingress is the entrypoint to your K8s cluster
Request goes to ingress first, which does the forwarding to the service

CONFIGURATION (CONFIGMAP AND SECRET)
To store non-confidential data in key-value pairs you use configMap
To store sensitive data such as password or token you use secret
Pods can consume both configMap and secret as environment variables, CLI arguments
or as config files in a volume

VOLUME
When a container crashes, K8s restarts the container but with a clean state, meaning the data is lost.
Volume basically attaches a physical storage on a hard drive to your pod. 
Storage could be either on a local server or outside the K8s cluster

DEPLOYMENT
This is a blueprint for Pods, you work with deployments and by defining the number of replicas, K8s creates Pods
Having load balanced replicas our setup is much more robust

STATEFULSET
BluePrint for stateful application like database, in addition to replicating features Statefulset makes sure database reads and writes are synchronised to avoid data inconsistencies



KUBERNETES ARCHITECTURE
A kubernetes cluster consists of a set of worker machines called Nodes
Worker Node and Control Plane.

WORKER NODE
The containerized applications run on the worker nodes and each node run multiple Pods on it. Much more compute resources neededd, because the actual workload run on them.

CONTROL PLANE
It manages the worker nodes and the Pods in the cluster. Much more important and needs to be replicated.
So in production, replicas run across multiple machnines


WORKER NODE COMPONENTS
Each worker node needs to have 3 processes installed namely: 
Container Runtime, Kubelet and Kube-proxy

CONTAINER RUNTIME
Software responsible for running containers e.g CRI-O or Docker

KUBELET
Agent that makes sure containers are running in a Pod, also talks to underlying server (to get resources for Pod ) and container runtime (to start containers in Pod)

KUBE-PROXY
A network proxy with intelligent forward of requests to the pods


CONTROL PLANE COMPONENTS
Each control plane needs to have 4 processes installed namely: 
API Server, Scheduler, controller Manager and etcd
Control plane makes global decisions about the cluster
It detects the responds to cluster events

API SERVER
The cluster gateway - single entrypoint to the cluster, it acts as a gatekeeper for authentication, validating the request. Clients to interacts with the API server UI, API and CLI

SCHEDULER
It decides on which Node new pod should be schedule, factors taken into account for scheduling decisions: resource requirement, hardware/software/policy constraints, data locally

CONTROLLER MANAGER
Detects state changes, like carshing of pod and tries to recover the cluster state as soon as possible
For that it makes request to the scheduler to reschedule those Pods and the same cycle happens.

ETCD
K8s backing store for all cluster data.
A consistent high available key-valye store. Think of it as a cluster brain, every change in the cluster gets save or updated into it
All other processes like Scheduler, Controller manager etc work based on th data in etcd as well as communicate with each other through etcd store. The actual application data is not stored in the etcd store.

INCREASE KUBERNETES CLUSTER CAPACITY
As your application grows and its demand for resources increases, you may actually add more Nodes to your cluster, thus forming a more powerful and robust cluster to meet your application resource requirement.

ADD A CONTROL PLANE
Get a fresh new server, install all control plane processes on it and join it to the K8s cluster using a K8s command


ADD A WORKER NODE
Get a fresh new server, install all the worker node processes like container runtime, Kubelet and KubeProxy on it and Join it to the K8s cluster using K8s command


BASIC KUBECTL COMMANDS
kubectl get {k8s-component}
kubectl get (nodes, pods, services, deployment)

kubectl create {K8s-component} {name} {options}
kubectl create deployment my-nginx-depl --image=nginx
kubectl edit {k8s-component} {name}
kubectl delete {k8x-component} {name}

kubectl logs (pod-name)
kubectl describe {pod-name}

kubectl exec -it {pod-name} -- bash
kubectl apply -f config-file.yaml

DELETE ALL RESOURCES
kubectl delete all --all

FOR SECRET YAML
converting username and password to base64 and insert this into secret.yaml file

Encode username and password to base64
use the following syntax
    echo -n 'username' | base64
        dXNlcm5hbWU=
    echo -n 'password' | base64
        cGFzc3dvcmQ=


CREATE A SECRET AND CONFIGMAP
kubectl apply -f mongo-secret.yaml
kubectl apply -f mongo-configMap.yaml

You have to create secret and configMap first before referencing them as environment variables on other resources

CREATE A DEPLOYMENT
kubectl apply -f mongo-deployment.yaml

CREATE A SERVICE
kubectl apply -f mongo-service.yaml

GET ALL KUBECTL COMPONENTS
kubectl get all

GET ALL KUBECTL COMPONENTS AND FILTER
kubectl get all | grep mongodb

GET LOGS OF A POD
kubectl logs mongo-express-78fcf796b8-jsrcc

CREATE K8s ON LINODE
Create kubernetes clusters with the number of nodes, master node will be automatically created. Download the test-kubeconfig yaml file 
-   Go on your local terminal and type
-   chmod 400 test-kubeconfig.yaml   // read only permission for user, others users should not permitted
-   export KUBECONFIG=test-kubeconfig.yaml
  
  check if you are now connected to linode K8s clusters
  - kubectl get node (this should display your node clusters on linode cloud)

Now we want to deploy 3 mango db nodes in the k8s clusters
We can use helm chart to get the configuration files needed
on the terminal type the following:
    -   helm repo add bitnami https://charts.bitnami.com/bitnami

search the helm repo on terminal
    -   helm search repo bitnami

create architecture yaml file
fill the yaml file as expected.
On the terminal type
    - helm install mongodb --values downloads/test-mongodb.yaml bitnami/mongodb

kubectl get pods, to see the number of nodes working

kubectl apply -f /download/test-mongo-express.yaml

Install ingress
$ helm repo add nginx-stable https://helm.nginx.com/stable
$ helm repo update
$ helm install nginx-ingress nginx-stable/nginx-ingress --set controller.publishService.enabled=true

Deploy using Helmfile
install helmfile first
        brew install helmfile
        helmfile sync

check installed resources
    - helmfile list

uninstall resources
    - helmfile destroy