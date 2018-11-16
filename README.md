# nug-k8s-event
NetApp Kubernetes Service Files

Step 1)

Sign up a new account at GCP, AWS or Azure. Free credits everywhere!
Sign up at https://cloud.netapp.com

Step 2)

If you chose GCP or Azure, you have Cloud Shell with kubectl installed. Good choice.

If you chose AWS, fire up an Ubuntu instance & install kubectl:
	
	sudo apt-get update && sudo apt-get install -y apt-transport-https
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl

Step 3)

Go to https://cloud.netapp.com & sign in. Click on NetApp Kubernetes Service Start Free Trial.

Click on + Add Cluster. Choose your cloud & follow authentication instructions. GCP & AWS are easiest.

Once the cluster is up and running, go to Solutions and + Add Solution.

Install HAproxy (load balancer)

Step 4)

Prep kubectl in your shell/VM:
Download kubeconfig for your cluster from the NKS console

	export KUBECONFIG=/path/to/kubeconfig
	kubectl config use-context stackpoint

Test connection: 

	kubectl get nodes

Step 5)

Let’s deploy whoami from GitHub, https://hub.docker.com/r/emilevauge/whoami/

	kubectl run whoami --image=emilevauge/whoami

Scale the deployment to four replicas

	kubectl scale deployment/whoami --replicas=4

Allow port 80 traffic

	kubectl expose deployment/whoami --port=80 --target-port=80 --type=NodePort

Step 5) 

Grab the whoami-ingress.yaml file & create ingress rules

	kubectl create -f whoami-ingress.yaml

Check cluster:

	kubectl get ingress/whoami

Step 6)

Test retrieving the whoami http service. Using the HA Proxy load balancer IP.

	curl -s http://YOUR.HA.PROXY.IP

Step 7)

Grab the whoami-hammer.sh script file.
Modify the script to point to your cluster's HA Proxy IP.
Run the script.

	sh whoami-hammer.sh

See the distribution of hits across the four workers

Adjust the number of replicas & rerun

	kubectl scale deployment/whoami --replicas=8
	sh whoami-hammer.sh

Step 8) 

DELETE EVERYTHING. :)





