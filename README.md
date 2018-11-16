# nug-k8s-event
NetApp Kubernetes Service Files

## Prerequisites
1. Sign up a new account at GCP, AWS or Azure. Free credits everywhere!
   * https://cloud.google.com/
   * https://aws.amazon.com/
   * https://portal.azure.com/
1. Sign up at https://cloud.netapp.com

## Install Kubectl
1. If you chose GCP or Azure, you have Cloud Shell with kubectl installed. Good choice.

1. If you chose AWS, fire up an Ubuntu instance & install kubectl:

		sudo snap install kubectl --classic

1. Test access:

		kubectl version
	
If not using ubuntu, or you don't like ```snap```:

	sudo apt-get update && sudo apt-get install -y apt-transport-https
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl

## Launch a NetApp Kubernetes Service cluster
1. Go to https://cloud.netapp.com, NetApp Kubernetes Service
1. Choose your cloud & follow authentication instructions. GCP & AWS are easiest.
	* AWS: https://stackpointcloud.com/community/tutorial/how-to-create-auth-credentials-on-amazon-web-services-aws
	* GCP: https://stackpointcloud.com/community/tutorial/google-compute-engine-setup-and-authentication
	* Azure: https://stackpointcloud.com/community/tutorial/how-to-create-auth-credentials-on-azure

1. Install HAproxy (load balancer) as a NKS Solution

## Configure kubectl
1. Prep kubectl in your shell/VM.
1. Download kubeconfig for your cluster from the NKS console

		export KUBECONFIG=/path/to/kubeconfig
		kubectl config use-context stackpoint

1. Test connection: 

		kubectl get nodes

## Deploy whoami
1. Let’s deploy whoami from GitHub, https://hub.docker.com/r/emilevauge/whoami/

		kubectl run whoami --image=emilevauge/whoami

1. Scale the deployment to four replicas

		kubectl scale deployment/whoami --replicas=4

1. Allow port 80 traffic

		kubectl expose deployment/whoami --port=80 --target-port=80 --type=NodePort

## Configure Ingress Rules
1. Grab the whoami-ingress.yaml file & create ingress rules

		kubectl create -f whoami-ingress.yaml

1. Check cluster:

		kubectl get ingress/whoami

## Test access!
1. Test retrieving the whoami http service. Using the HA Proxy load balancer IP.

		curl -s http://xx.xx.xx.xx

## Test lots of access!
1. Grab the whoami-hammer.sh script file
1. Modify the script to point at the HA Proxy IP.
1. Run the script.

		sh whoami-hammer.sh

1. See the distribution of hits across the four workers

1. Adjust the number of replicas & rerun

		kubectl scale deployment/whoami --replicas=8
		sh whoami-hammer.sh

## DELETE EVERYTHING.

DELETE EVERYTHING.