# three-tier-architecture-deployment

Structure:
````
.
├── 3t-chart
│   ├── charts
│   │   ├── backend
│   │   │   ├── Chart.yaml
│   │   │   ├── templates
│   │   │   │   ├── configmap.yaml
│   │   │   │   ├── deployment.yaml
│   │   │   │   ├── _helpers.tpl
│   │   │   │   ├── hpa.yaml
│   │   │   │   └── service.yaml
│   │   │   └── values.yaml
│   │   ├── database
│   │   │   ├── Chart.yaml
│   │   │   ├── templates
│   │   │   │   ├── deployment.yaml
│   │   │   │   ├── _helpers.tpl
│   │   │   │   ├── hpa.yaml
│   │   │   │   └── service.yaml
│   │   │   └── values.yaml
│   │   └── frontend
│   │       ├── Chart.yaml
│   │       ├── templates
│   │       │   ├── deployment.yaml
│   │       │   ├── _helpers.tpl
│   │       │   ├── hpa.yaml
│   │       │   ├── ingress.yaml
│   │       │   └── service.yaml
│   │       └── values.yaml
│   ├── Chart.yaml
│   └── values.yaml
├── argocd
│   ├── application.yml
│   └── monitoring-app.yml
├── monitoring-chart
│   ├── charts
│   │   ├── grafana
│   │   │   ├── Chart.yaml
│   │   │   ├── templates
│   │   │   │   └── grafana.yaml
│   │   │   └── values.yaml
│   │   ├── node-exporter
│   │   │   ├── Chart.yaml
│   │   │   ├── templates
│   │   │   │   └── node-exporter.yaml
│   │   │   └── values.yaml
│   │   └── victoria-metrics
│   │       ├── Chart.yaml
│   │       ├── templates
│   │       │   ├── victoriametrics.yaml
│   │       │   ├── vm-config.yaml
│   │       │   └── vm-rbac.yaml
│   │       └── values.yaml
│   ├── Chart.yaml
│   ├── templates
│   │   └── namespace.yml
│   └── values.yaml
├── README.md
├── Screenshot 2026-03-20 2.16.48 PM.png
└── values.yaml
````

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

![alt text](https://github.com/dev126712/three-tier-architecture-deployment/blob/f0e4a8d0ff50b5ad63d5f2ed639f3b936cf76be0/Screenshot%202026-03-26%2011.13.50%20AM.png)
![alt text](https://github.com/dev126712/three-tier-architecture-deployment/blob/9b9735a7a04cd2ba671de387dce2e28ee7883db2/Screenshot%202026-03-26%2011.13.50%20AM.png)
![alt text]()

