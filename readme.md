# Install

```
sh setupAKS.sh
sh setup.sh
```

# Jaeger-UI

```
k port-forward svc/simplest-query 16686
```

# Call Consumer

```
k port-forward -n demo svc/consumer-demoserviceconsumer 5000
```

## Metrics

http://localhost:5000/metrics

# Telepresence

Connect to Cluster
```
telepresence connect
```

Intercept Provider
```
telepresence intercept provider-demoserviceprovider -n demo -p 3000 --env-file provider.env
```

Leave Interception
```
telepresence leave provider-demoserviceprovider-demo
```

# DemoProviderInterception

Install Dependencies
```
pip install -r requirements.txt
```

Run
```
python3 app.py
```

# Keda

Metrics

```
k get secret/argocd-initial-admin-secret -n argocd -o yaml | code -
```

ScaledObject abrufen

```
k get scaledobject -n demo -o yaml | code -
```

# ArgoCD

Extract Secret
```
k get secret/argocd-initial-admin-secret -n argocd -o yaml | code -
```

Port-Forward
```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

User:
admin

Passwort (generated):
ybIs9JR-175MvcgC

# Linkerd

Dashboard
```
linkerd viz dashboard &
```
Passwort:
-ppVSgtoBKG-sgc-

# Kubeshark

Start network monitoring

```
kubeshark tap -n demo
```

Remove all deployed resources

```
kubeshark clean
```

# Kubecost

UI

```
kubectl port-forward --namespace kubecost deployment/kubecost-cost-analyzer 9090
```

# Kubescape

Scan

```
kubescape scan --enable-host-scan --verbose  --format html --output results.html
```

# FluentBit

Read logs

```
k logs pod/fluentbit-fluent-bit-fcw8v -n fluentbit --tail=5
```

# eBPF

## Cilium

### Hubble

Hubble UI aufrufen

```
cilium hubble ui
```

#### Example API-Calls

XWing

```
kubectl exec xwing -n default -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
```

Tiefighter

```
kubectl exec tiefighter -n default -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
```

### L7 CiliumNetworkPolicy

```
k apply -f ebpf/networkPolicyL7.yaml
```

## Tetragon

### Monitoring

Enable File-Monitoring

```
kubectl apply -f ebpf/tracingPolicyFileMonitoring.yaml
```

Enable Network-Monitoring

```
kubectl apply -f ebpf/tracingPolicyNetworkMonitoring.yaml
```

### Live-Monitoring

```
kubectl logs -n kube-system -l app.kubernetes.io/name=tetragon -c export-stdout -f | tetra getevents -o compact -n default
```

#### Test

Curl

```
kubectl exec -ti pod/xwing -- bash -c 'curl https://ivfp.de'
```

FileAccess

```
kubectl exec -ti pod/xwing -- bash -c 'cat /etc/fstab >> /tmp/tetragon'
```

### TracingPolicies

FileAccess

```
k apply -f ebpf/tracingPolicyFDInstall.yaml
```

Test

```
kubectl exec -ti pod/xwing -- bash -c 'cat /tmp/tetragon'
```

### Metrics

Port-Forward vom Metrics-Server

```
kubectl -n kube-system port-forward service/tetragon 2112:2112
```

Metrics-URL

http://localhost:2112/metrics