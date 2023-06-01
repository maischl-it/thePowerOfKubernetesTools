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

Passwort:
-ppVSgtoBKG-sgc-