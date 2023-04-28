#!/bin/env bash

# build demoservice docker image & load to kind
cd demoServiceProvider
docker build -t demoserviceprovider .
kind load docker-image demoserviceprovider --name=jaeger-demo
cd ..

# deploy demoservice in kind, perform port-forward
# cd helm/demoserviceprovider
# helm upgrade provider . -n demo --create-namespace --install
# cd ../..
