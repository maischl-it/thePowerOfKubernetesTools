#!/bin/env sh

kind create cluster --name tech-demo

# Install cert-manager (Prerequisite of jaeger)
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.10.1/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io --force-update
helm install cert-manager jetstack/cert-manager -n cert-manager --create-namespace --version v1.10.1

# Install jaeger-operator & wait for pod to become ready
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts --force-update
helm install jaeger jaegertracing/jaeger-operator --set rbac.clusterRole=true -n observability --create-namespace
kubectl wait pod -n observability -l app.kubernetes.io/instance=jaeger --for condition=Ready --timeout=60s

# Install Metrics-Server (Linkerd)
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm repo update
helm upgrade --install --set args={--kubelet-insecure-tls} metrics-server metrics-server/metrics-server --namespace kube-system

# Deploy Jaeger all in one
kubectl apply -f jaeger.yaml

# Deploy KEDA
helm repo add kedacore https://kedacore.github.io/charts --force-update
helm install keda kedacore/keda --namespace keda --version 2.10.2 --create-namespace

# Deploy redis
helm repo add bitnami https://charts.bitnami.com/bitnami --force-update
helm install redis bitnami/redis --namespace demo --create-namespace --set architecture=standalone --set global.redis.password=testadmin

# ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Linkerd

linkerd install --crds | kubectl apply -f -
linkerd install | kubectl apply -f -
linkerd viz install | kubectl apply -f - # install the on-cluster metrics stack
linkerd check

# Kubecost

helm upgrade --install kubecost \
  --repo https://kubecost.github.io/cost-analyzer/ cost-analyzer \
  --namespace kubecost --create-namespace

# Deploy Provider

cd demoServiceProvider
docker build -t demoserviceprovider .
kind load docker-image demoserviceprovider --name=tech-demo
cd ..

# Deploy Consumer

cd demoServiceConsumer
docker build -t demoserviceconsumer .
kind load docker-image demoserviceconsumer --name=tech-demo
cd ..

# Telepresence

telepresence helm install
telepresence connect