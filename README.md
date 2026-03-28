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
│   ├── values-dev.yaml
│   ├── values-prod.yaml
│   └── values-stage.yaml
├── argocd
│   ├── application-dev.yml
│   ├── application-prod.yml
│   ├── application-stage.yml
│   └── monitoring-app.yml
├── argocd-installation.bash
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
└── values.yaml
````

Multiple Environment with their own argocd manifest files & confugaration files throught helm
- Dev
- Stage
- Prod

![alt text](https://github.com/dev126712/three-tier-architecture-deployment/blob/d7e66d42de555afd4ca44caadb747e672ae9e853/image.png)

