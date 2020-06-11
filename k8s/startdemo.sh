@_ECHO_OFF
clear
cd k8s
#kubectl run petclinic --image=marygabry1508/petclinic --restart=Never --port=8080 --dry-run -o yaml
#kubectl run petclinic --image=marygabry1508/petclinic --restart=Always --replicas=1 --port=8080 --dry-run -o yaml
#kubectl expose deployment petclinic --port=8080 --target-port=8080 --type=LoadBalancer --dry-run -o yaml
@_ECHO_ON
#Cluster configuration
bat /Users/marygabry/Downloads/kubeconfig-barchetta.yml
kubectl cluster-info
kubectl get nodes -o wide
clear
kubectl get namespaces
kubectl -n kube-system get all
kubectl config set-context $(kubectl config current-context) --namespace=default
clear
#POD
bat pod/petclinic.yaml
kubectl create -f pod/petclinic.yaml
kubectl get pod
kubectl describe pod petclinic
clear
#PORT forward
python -m webbrowser "http://localhost:8081/"
kubectl port-forward pod/petclinic 8081:8080
clear
kubectl logs petclinic
kubectl delete pod petclinic
kubectl get pod
clear
#DEPLOYMENT
bat deployment/petclinic.yaml
kubectl create -f deployment/petclinic.yaml
kubectl get all
clear
kubectl describe deployment petclinic
clear
kubectl describe replicaset petclinic
clear
kubectl get pod
kubectl delete pod petclinic
kubectl get pod
clear
#INCREASE REPLICAS
kubectl edit deployment petclinic
kubectl get pod
clear
#LB
bat service/petclinic.yaml
kubectl create -f service/petclinic.yaml
kubectl get service
@_ECHO_OFF
python -m webbrowser "http://$(kubectl get service petclinic -o json |jq '. | { hostname: .status.loadBalancer.ingress[].hostname}.hostname'| sed s/\"//g):8080"
@_ECHO_ON
kubectl delete deployment petclinic
kubectl delete service petclinic
kubectl get all
clear
# NEXT
# Persistent volumes
kubectl get storageclass
bat pv/pvc.yaml
kubectl create -f pv/pvc.yaml
kubectl describe pvc pvc-1g
clear
bat pv/pod.yaml
kubectl create -f pv/pod.yaml
kubectl describe pod pod-1g
#PVC BOUND
kubectl describe pvc pvc-1g
#ADD PIZZA
kubectl exec -it pod-1g -- /bin/sh
clear
kubectl delete pod pod-1g
bat pv/pod2.yaml
kubectl create -f pv/pod2.yaml
kubectl get po
#CHECK the surprise
kubectl exec -it pod-2g -- /bin/sh
kubectl delete pod pod-2g
