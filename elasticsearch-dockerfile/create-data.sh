curl -XPOST 'http://localhost:9200/phillydevops/meeting' -d '{
  "date" : "2014-03-18T18:00:00+05:00",
  "title" : "How Postmark uses Elasticsearch"
}'

curl -XPOST 'http://localhost:9200/phillydevops/meeting' -d '{
  "date" : "2014-03-18T18:00:00+05:00",
  "title" : "How Foo does Bar"
}'
