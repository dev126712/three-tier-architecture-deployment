# three-tier-architecture-deployment

Install ArgoCD
````
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
````

ArgoCD secrets

````
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
````

Expose the UI via NodePort
```` 
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
````

![alt text]()
