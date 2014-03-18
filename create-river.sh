curl -XDELETE http://localhost:9200/_river/phillydevops
curl -XPOST http://localhost:9200/_river/phillydevops/_meta -d '{
  "type": "couchdb",
  "couchdb": {
    "host" : "COUCHDB IP ADDRESS",
    "port" : 5984,
    "db" : "phillydevops",
    "script": "ctx.doc.newfield = ctx.doc.group.name + \" meets about the topic: \" + ctx.doc.name"
  },
  "index" : {
    "index" : "phillydevops",
    "type" : "meeting",
    "bulk_size" : "10",
    "bulk_timeout" : "100ms"
  }
}'
