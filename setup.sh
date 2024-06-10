# eBPF

# Cilium

cilium install --set azure.resourceGroup="sem"
cilium status --wait

# Example Application eBPF

kubectl create -f https://raw.githubusercontent.com/cilium/cilium/v1.15.3/examples/minikube/http-sw-app.yaml

# Hubble

cilium hubble enable --ui

# Tetragon

helm repo add cilium https://helm.cilium.io
helm repo update
helm install tetragon cilium/tetragon -n kube-system

# File Access Monitoring

kubectl apply -f https://raw.githubusercontent.com/cilium/tetragon/main/examples/quickstart/file_monitoring.yaml

# Deploy KEDA
helm repo add kedacore https://kedacore.github.io/charts --force-update
helm install keda kedacore/keda --namespace keda --create-namespace

# Deploy redis
helm repo add bitnami https://charts.bitnami.com/bitnami --force-update
helm install redis bitnami/redis --namespace demo --create-namespace --set architecture=standalone --set global.redis.password=lEoa6dGvGP

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

# FluentBit
cd helm/fluentbit
helm repo add fluent https://fluent.github.io/helm-charts
helm dependency build

helm upgrade --install fluentbit -n fluentbit --create-namespace .
cd ../..

# deploy demoserviceprovider
cd helm/demoserviceprovider
helm upgrade provider . -n demo --create-namespace --install

cd ../..

# deploy demoserviceconsumer
cd helm/demoserviceconsumer
helm upgrade consumer . -n demo --create-namespace --install

cd ../..

# Telepresence

telepresence helm install
telepresence connect

# # Install Metrics-Server (Linkerd)
# helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
# helm repo update
# helm upgrade --install --set args={--kubelet-insecure-tls} metrics-server metrics-server/metrics-server --namespace kube-system

# Install Cert-manager
helm repo add jetstack https://charts.jetstack.io --force-update
helm repo update

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.6.3/cert-manager.crds.yaml

helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.6.3

# Install Jaeger-Operator

kubectl create -f https://github.com/jaegertracing/jaeger-operator/releases/download/v1.57.0/jaeger-operator.yaml -n observability

# Deploy Jaeger all in one
kubectl apply -f jaeger.yaml