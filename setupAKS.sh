#!/bin/env sh

export NAME="sem"
export AZURE_RESOURCE_GROUP="sem"
az group create --name "${AZURE_RESOURCE_GROUP}" -l germanywestcentral

# Create AKS cluster
az aks create \
  --resource-group "${AZURE_RESOURCE_GROUP}" \
  --name "${NAME}" \
  --network-plugin none \
  --node-vm-size Standard_DS3_v2 \
  --node-count 2

# Get the credentials to access the cluster with kubectl
az aks get-credentials --resource-group "${AZURE_RESOURCE_GROUP}" --name "${NAME}"