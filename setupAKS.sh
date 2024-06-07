#!/bin/env sh

export NAME="sem"
export AZURE_RESOURCE_GROUP="sem"
az group create --name "${AZURE_RESOURCE_GROUP}" -l germanywestcentral

# Create AKS cluster
az aks create \
  --resource-group "${AZURE_RESOURCE_GROUP}" \
  --name "${NAME}" \
  --network-plugin none \
  --generate-ssh-keys

# Get the credentials to access the cluster with kubectl
az aks get-credentials --resource-group "${AZURE_RESOURCE_GROUP}" --name "${NAME}"

# eBPF

# Cilium

cilium install --set azure.resourceGroup="sem"

# Hubble

cilium hubble enable

# Tetragon

helm repo add cilium https://helm.cilium.io
helm repo update
helm install tetragon cilium/tetragon -n kube-system