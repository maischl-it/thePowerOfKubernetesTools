#!/bin/env bash

# build demoservice docker image & load to kind
# cd demoServiceConsumer
# docker build -t demoserviceconsumer .
# kind load docker-image demoserviceconsumer --name=tech-demo
# cd ..

# deploy demoservice in kind, perform port-forward
# cd helm/demoserviceconsumer
# helm upgrade consumer . -n demo --create-namespace --install
# cd ../..
