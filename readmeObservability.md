# Jaeger-UI

```
k port-forward svc/simplest-query 16686
```

# Call Consumer

```
k port-forward -n demo svc/consumer-demoserviceconsumer 5000
```

# eBPF

## Cilium/Hubble

Hubble UI aufrufen

```
cilium hubble ui
```

### Example API-Calls

XWing

```
kubectl exec xwing -n default -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
```

Tiefighter

```
kubectl exec tiefighter -n default -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
```

## Live-Monitoring

```
kubectl logs -n kube-system -l app.kubernetes.io/name=tetragon -c export-stdout -f | tetra getevents -o compact -n default
```

## Test

Curl

```
kubectl exec -ti pod/xwing -- bash -c 'curl https://ivfp.de'
```

FileAccess

```
kubectl exec -ti pod/xwing -- bash -c 'cat /etc/fstab >> /tmp/tetragon'
```

## L7 CiliumNetworkPolicy

```
k apply -f ebpf/networkPolicyL7.yaml
```

Test

```
kubectl exec tiefighter -n default -- curl -s -XPOST deathstar.default.svc.cluster.local/v1/request-landing
```


## TracingPolicies (Tetragon)

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
