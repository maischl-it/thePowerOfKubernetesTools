#!/bin/env bash

# build demoservice docker image & load to kind
pushd demoServiceConsumer
docker build -t demoserviceconsumer .
kind load docker-image demoserviceconsumer --name=jaeger-demo
popd

# deploy demoservice in kind, perform port-forward
pushd helm/demoserviceconsumer
helm upgrade consumer . -n demo --create-namespace --install
popd
