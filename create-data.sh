#curl -XPUT 'http://localhost:9200/phillydevops/' -d '{
#  "settings" : {
#    "index": {
#      "number_of_shards": 5,
#      "number_of_replicas": 2
#    }
#  }
#}'

curl -XPOST 'http://localhost:9200/phillydevops/meeting' -d '{
  "date" : "2014-03-18T18:00:00+05:00",
  "title" : "How Postmark uses Elasticsearch"
}'

curl -XPOST 'http://localhost:9200/phillydevops/meeting' -d '{
  "date" : "2014-03-18T18:00:00+05:00",
  "title" : "How Foo does Bar"
}'
