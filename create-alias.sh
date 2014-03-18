curl-XPUThttp://localhost:9200/phillydevops2

curl-XPOSThttp://localhost:9200/_aliases-d'
{
"actions":[
{"add":{"index":"phillydevops2","alias":"phillydevops_forealz"}}
]
}'


#curl-XPOSThttp://localhost:9200/_aliases-d'
#{
#"actions":[
#{"remove":{"index":"phillydevops2","alias":"phillydevops_forealz"}},
#{"add":{"index":"phillydevops","alias":"phillydevops_forealz"}}
#]
#}'
