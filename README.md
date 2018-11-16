# nug-k8s-event
NetApp Kubernetes Service Files


Wifi: Ricoh NZ Visitor
User: wifi.wel@ricoh.co.nz
Pass: r1c0h1234
Install kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/

Do the NKS thing before proceeding.

-Install a k8s cluster
-Install HAproxy (load balancer

Setup kubectl:
Download kubeconfig after creating cluster
export KUBECONFIG=/path/to/kubeconfig
kubectl config use-context stackpoint

Test connection:
kubectl get nodes

Let’s deploy whoami from GitHub: (https://hub.docker.com/r/emilevauge/whoami/) 
kubectl run whoami --image=emilevauge/whoami

kubectl scale deployment/whoami --replicas=6

kubectl expose deployment/whoami --port=80 --target-port=80 --type=NodePort

Create the whoami-ingress.yaml file with this content:
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
name: whoami
spec:
backend:
serviceName: whoami
servicePort: 80

Create method with file:
kubectl create -f whoami-ingress.yaml

Check cluster:
kubectl get ingress/whoami

Retrieve the page. Use the load balancer IP:
curl -s http://xx.xx.xx.xx

Create whoami-hammer.sh script file:
for t in {1..10};
do
curl -s http://35.233.180.194/ \
|grep "Hostname:" \
|cut -d" " -f2;
done \
|sort \
|uniq -c

Run the whoami-hammer.sh script.