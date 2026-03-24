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

ArgoCD secrets

````
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
````

Expose the UI via NodePort
```` 
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
````

![alt text]()
