curl -XPOST http://localhost:9200/_river/phillydevops/_meta -d '{
  "type": "couchdb",
  "couchdb": {
    "host" : "172.17.0.3",
    "port" : 5984,
    "db" : "phillydevops"
  },
  "index" : {
    "index" : "phillydevops",
    "type" : "meeting",
    "bulk_size" : "1",
    "bulk_timeout" : "10ms"
  }
}'
