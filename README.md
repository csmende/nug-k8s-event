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

1. Test install:

		kubectl version

## Launch a NetApp Kubernetes Service cluster
1. Go to https://cloud.netapp.com, sign in and click on NetApp Kubernetes Service Start Free Trial.
1. Select + New Cluster
1. Choose your cloud and follow authentication instructions. GCP & AWS are easiest.
	* AWS: https://stackpointcloud.com/community/tutorial/how-to-create-auth-credentials-on-amazon-web-services-aws
	* GCP: https://stackpointcloud.com/community/tutorial/google-compute-engine-setup-and-authentication
	* Azure: https://stackpointcloud.com/community/tutorial/how-to-create-auth-credentials-on-azure
1. Wait for cluster to show successful install.

## Add a load balancer 
1. Click into your cluster, and scroll down to + Service
1. Select HAproxy and click install.

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
1. Modify the script to point at your HA Proxy IP.
1. Run the script.

		sh whoami-hammer.sh

1. See the distribution of hits across the four workers

1. Adjust the number of replicas & rerun

		kubectl scale deployment/whoami --replicas=8
		sh whoami-hammer.sh

## Enjoy!
1. You now have a fully functional Kubernetes cluster running with a sample app.
1. Explore some of the other services like Prometheus 

## DELETE ALL THE THINGS.

Don't forget to remove your cluster when you're done!
