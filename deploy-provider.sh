#!/bin/env bash

# build demoservice docker image & load to kind
pushd demoServiceProvider
docker build -t demoserviceprovider .
kind load docker-image demoserviceprovider --name=jaeger-demo
popd

# deploy demoservice in kind, perform port-forward
pushd helm/demoserviceprovider
helm upgrade provider . -n demo --create-namespace --install
popd
