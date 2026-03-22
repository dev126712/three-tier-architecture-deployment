# three-tier-architecture-deployment

Install ArgoCD
````
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
````
Make the UI 'Insecure' (Disable internal TLS for the proxy)y)
```` 
kubectl patch deployment argocd-server -n argocd --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/command", "value": ["argocd-server"]}, {"op": "add", "path": "/spec/template/spec/containers/0/args", "value": ["--insecure"]}]'
````

# 2. Expose the UI via NodePort
```` 
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
````

![alt text](https://github.com/dev126712/three-tier-architecture-deployment/blob/c0cbb1e43b6e3c4fcf0aa0321ecf066e0c482a9e/Screenshot%202026-03-20%202.16.48%20PM.png)
