# Three-Tier Architecture Deployment ( Helm Charts & ArgoCD )

This repository provides a complete Kubernetes deployment setup for a three-tier web application (Frontend, Backend, Database) using Helm charts and ArgoCD for GitOps-based continuous deployment. It supports multiple environments (Dev, Stage, Prod) and includes a monitoring stack with VictoriaMetrics, Grafana, and Node Exporter.

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
└── values.yaml

````

## Architecture

The application consists of three main components:

- **Frontend**: React/Node.js application served via Nginx
- **Backend**: Node.js API server
- **Database**: MongoDB instance

All components are containerized and deployed as Kubernetes deployments with services, horizontal pod autoscalers (HPA), and ingress for external access.

## Features

- **Multi-Environment Support**: Separate configurations for Dev, Stage, and Prod environments
- **GitOps Deployment**: ArgoCD applications for automated deployment and synchronization
- **Monitoring Stack**: VictoriaMetrics for metrics collection, Grafana for visualization, Node Exporter for node metrics
- **Scalability**: HPA configured for automatic scaling based on CPU utilization
- **Security**: Non-root containers, read-only root filesystems where applicable

## Prerequisites

Before deploying, ensure you have:

- Kubernetes cluster (v1.19+)
- `kubectl` configured to access your cluster
- Helm 3.x installed
- ArgoCD CLI (optional, for advanced management)

## Installation

### 1. Install ArgoCD

Run the installation script to deploy ArgoCD to your cluster:

```bash
./argocd-installation.bash
```

This script will:
- Create the `argocd` namespace
- Install ArgoCD using the stable manifest
- Configure insecure UI access
- Expose ArgoCD server via NodePort
- Display the initial admin password and ports

### 2. Access ArgoCD UI

After installation, access the ArgoCD UI using:
- **URL**: `http://<node-ip>:<http-port>` (insecure)
- **Username**: `admin`
- **Password**: Retrieved from the installation script output

## Deployment

### Application Deployment

Deploy the three-tier application for different environments using ArgoCD applications:

```bash
# Deploy to Dev environment
kubectl apply -f argocd/application-dev.yml

# Deploy to Stage environment
kubectl apply -f argocd/application-stage.yml

# Deploy to Prod environment
kubectl apply -f argocd/application-prod.yml
```

### Monitoring Stack Deployment

Deploy the monitoring stack:

```bash
kubectl apply -f argocd/monitoring-app.yml
```

## Configuration

### Environment-Specific Values

Each environment has its own values file:
- `3t-chart/values-dev.yaml` - Development environment
- `3t-chart/values-prod.yaml` - Production environment
- `3t-chart/values-stage.yaml` - Staging environment

Key configurations include:
- Image tags and repositories
- Replica counts
- Resource limits
- Ingress hosts and paths
- Database connection strings

### Component Configurations

- **Frontend**: Nginx-based, serves static files and proxies API calls
- **Backend**: Node.js application with MongoDB connection
- **Database**: MongoDB with authentication enabled

## Monitoring

The monitoring stack includes:

- **VictoriaMetrics**: Time-series database for metrics storage
- **Grafana**: Visualization dashboard (access via `http://<grafana-service>` in monitoring namespace)
- **Node Exporter**: Exports hardware and OS metrics

Access Grafana using the default credentials (admin/admin) and configure dashboards for application monitoring.

## Usage

### Accessing the Application

- **Dev**: `http://dev.chart-example.local`
- **Stage**: Configure ingress host in `values-stage.yaml`
- **Prod**: Configure ingress host in `values-prod.yaml`

### Scaling

Applications are configured with HPA. Adjust `replicaCount` and resource limits in values files for scaling requirements.

### Updates

To update the application:
1. Modify values files or chart templates
2. Commit and push changes
3. ArgoCD will automatically sync the changes (if automated sync is enabled)

## Troubleshooting

### Common Issues

1. **ArgoCD Sync Issues**
   - Check ArgoCD application status: `kubectl get applications -n argocd`
   - View sync logs in ArgoCD UI

2. **Pod Failures**
   - Check pod status: `kubectl get pods -n <namespace>`
   - View logs: `kubectl logs <pod-name> -n <namespace>`

3. **Ingress Issues**
   - Ensure ingress controller is installed (e.g., NGINX Ingress Controller)
   - Verify ingress class and annotations

4. **Database Connection Issues**
   - Check service discovery: `kubectl get svc -n <namespace>`
   - Verify database credentials in backend config

### Logs and Debugging

```bash
# View ArgoCD logs
kubectl logs -n argocd deployment/argocd-server

# View application logs
kubectl logs -n <app-namespace> deployment/<component-name>

# Check ArgoCD application status
argocd app get <app-name>
```

## Security Considerations

- Change default ArgoCD admin password
- Use secure image registries and signed images
- Implement network policies for pod communication
- Enable RBAC for ArgoCD access
- Use secrets management for sensitive data (database passwords, etc.)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes and test in dev environment
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions:
- Create an issue in this repository
- Check ArgoCD documentation: https://argo-cd.readthedocs.io/
- Helm documentation: https://helm.sh/docs/

---

![Architecture Diagram](https://github.com/dev126712/three-tier-architecture-deployment/blob/d7e66d42de555afd4ca44caadb747e672ae9e853/image.png)


