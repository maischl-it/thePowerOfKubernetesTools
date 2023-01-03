#!/bin/env sh

kind create cluster --name jaeger-demo --config kind.yaml

# Install cert-manager and ingress-nginx (Prerequisites)
CERT_MANAGER_VERSION=v1.10.1
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/$CERT_MANAGER_VERSION/cert-manager.crds.yaml
helm install cert-manager jetstack/cert-manager -n cert-manager --create-namespace --version $CERT_MANAGER_VERSION
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# Install jaeger-operator & wait for pod to become ready
helm install jaeger jaegertracing/jaeger-operator --set rbac.clusterRole=true -n observability --create-namespace
kubectl wait pod -n observability -l app.kubernetes.io/instance=jaeger --for condition=Ready --timeout=60s

# Deploy Jaeger all in one
kubectl apply -f jaeger.yaml

