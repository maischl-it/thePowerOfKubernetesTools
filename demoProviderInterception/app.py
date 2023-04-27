from flask import Flask
import requests

app = Flask(__name__)

# pool = redis.ConnectionPool(host='localhost', port=6379, db=0, password="testadmin")
# redis = redis.Redis(connection_pool=pool)

# redis.set('testkey', 'Hello Meetup')
    
# entry = redis.get('testkey')
# print(entry)

@app.route("/", methods=['POST', 'GET'])
def home():
    return "demoProviderInterception"

app.run(debug=True, host='0.0.0.0', port=3000)
