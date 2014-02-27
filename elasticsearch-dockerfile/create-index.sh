curl -XPUT 'http://localhost:9200/phillydevops/' -d '{
  "settings" : {
    "index": {
      "number_of_shards": 5,
      "number_of_replicas": 2
    }
  },
  "mappings" : {
    "meeting" : {
      "properties" : {
        "title" : { "type" : "string", "index": "analyzed" },
        "date" : { "type": "date", "index": "analyzed" }
      }
    }
  }
}'


