# Install

'''
sh setup.sh
'''

'''
sh deploy-consumer.sh
sh deploy-provider.sh
'''

# Jaeger-UI

'''
k port-forward svc/simplest-query 16686
'''

# Call Consumer

'''
k port-forward svc/consumer-demoserviceconsumer 5000
'''