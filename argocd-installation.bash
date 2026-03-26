#!/usr/bin/env bash

echo "Argocd Creation"

kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch deployment argocd-server -n argocd --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/command", "value": ["argocd-server"]}, {"op": "add", "path": "/spec/template/spec/containers/0/args", "value": ["--insecure"]}]'

sleep 25

echo "Expose the UI via NodePort"
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

echo 'password': `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo`

echo 'http port:' ` kubectl get svc -n argocd -o jsonpath="{.items[6].spec.ports[0].nodePort}"`

echo 'https port:' ` kubectl get svc -n argocd -o jsonpath="{.items[6].spec.ports[1].nodePort}"`
