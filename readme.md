# Install

```
sh setup.sh
```

```
sh deploy-consumer.sh
sh deploy-provider.sh
```

# Jaeger-UI

```
k port-forward svc/simplest-query 16686
```

# Call Consumer

```
k port-forward -n demo svc/consumer-demoserviceconsumer 5000
```

# Telepresence

Install Traffic-Manager
```
telepresence helm install 
```

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
7J0YDOpofPZxpmKL

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
kubeshark tap -n fairgleichen-qa "fairgleichen*" 
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
