curl -XPUT 'http://localhost:9200/phillydevops/' -d '{
  "settings" : {
    "index": {
      "number_of_shards": 10,
      "number_of_replicas": 1
    }
  },
  "mappings" : {
    "meeting" : {
      "properties" : { }
    }
  }
}'


