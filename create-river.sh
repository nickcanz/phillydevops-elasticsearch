curl -XDELETE http://localhost:9200/_river/phillydevops
curl -XPOST http://localhost:9200/_river/phillydevops/_meta -d '{
  "type": "couchdb",
  "couchdb": {
    "host" : "172.17.0.7",
    "port" : 5984,
    "db" : "phillydevops",
    "filter": null
  },
  "index" : {
    "index" : "phillydevops",
    "type" : "meeting",
    "bulk_size" : "10",
    "bulk_timeout" : "100ms"
  }
}'
