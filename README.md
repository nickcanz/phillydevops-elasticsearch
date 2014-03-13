phillydevops-elasticsearch
==========================

## Installation and setup

1. Install [Docker](https://www.docker.io/gettingstarted/#h_installation). On OSX, I'm using [boot2docker](http://docs.docker.io/en/latest/installation/mac/#boot2docker). For verification, `docker version` should return a version.
1. Build the custom elasticsearch docker image, with a tag of `devops-es`.
    ```
    docker build -t devops-es elasticsearch-dockerfile/.
    ```
1. Pull down the couchdb docker image
    ```
    docker pull klaemo/couchdb
    ```

## Run an Elasticsearch instance

### Start the container
Execute `docker run -d -p 9200:9200 devops-es`
* `-d` will run the container in the background
* `-p 9200:9200` will forward port 9200 from the container to the host
* `devops-es` is the name of the image we want to run. In this case, it is a name of a tag.

### Verfiy it's running

Execute `curl http://localhost:9200` and you should see a response similar to this:
```json
{
  "status" : 200,
  "name" : "<Random name of node here>",
  "version" : {
    "number" : "1.0.1",
    "build_hash" : "5c03844e1978e5cc924dab2a423dc63ce881c42b",
    "build_timestamp" : "2014-02-25T15:52:53Z",
    "build_snapshot" : false,
    "lucene_version" : "4.6"
  },
  "tagline" : "You Know, for Search"
}
```

You should also be able to open a browser to [http://localhost:9200/_plugin/head/](http://localhost:9200/_plugin/head/) to see an overview of your cluster. Right now, there should be only 1 node, and no other information as we haven't created any indexes. 

### Create our first index

Let's create an index called phillydevops with 5 shards and 1 replica. A shard is the Elasticsearch term for the partitions in your dataset that Elasticsearch creates. For this index, we will have 10 shards in total (5 shards + 1 extra copy of each). We also create a mapping called meeting. This is going to be our data type and we could specify how we want different fields to be searched, but for simplicity we'll leave it blank to have the fields dynamically mapped. You can read more in the [Elasticsearch documentation on mappings](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/indices-put-mapping.html).

```bash
curl -XPUT 'http://localhost:9200/phillydevops/' -d '{
  "settings" : {
    "index": {
      "number_of_shards": 5,
      "number_of_replicas": 1
    }
  },
  "mappings" : {
    "meeting" : {
      "properties" : { }
    }
  }
}' 

# Response: {"acknowledged":true}
```

Now, when going to [http://localhost:9200/_plugin/head/](http://localhost:9200/_plugin/head/), you should see something like this, with five shards assigned to the node you created and five shards unassigned to any node.
![5 shards unassigned](./images/elasticsearch-unassigned-shards.png?raw=true)

### Running more nodes

We created our index with more shards than we have servers. What's great about Elasticsearch, is that it's very easy to add another node and have our data be balanced among the servers available to the cluster. Let's bring up another Elasticsearch server by running `docker run -d devops-es`. After a few seconds, we can refresh [http://localhost:9200/_plugin/head/](http://localhost:9200/_plugin/head/) and see our new server has been assigned all the previous shards automatically!
![All shards assigned](./images/elasticsearch-all-shards-assigned.png?raw=true)

If we run `docker run -d devops-es` two more times, you can see how all the shards balance out. 
![Four nodes running](./images/elasticsearch-four-nodes-running.png?raw=true)

In production, this process will take much longer depending on how much data you have, but it's still generally that easy to do. 

## Using the Couchdb river

It isn't common that Elasticsearch is used as a primary datastore, although that might change in future versions. In this example, I will use Couchdb as my data store and stream data from Couchdb to Elasticsearch automatically. 

### Running the Couchdb server

Let's start a Couchdb server.

```bash
docker run -d -p 5984:5984 klaemo/couchdb

#Verify it's running
curl http://localhost:5984 # Response: {"couchdb":"Welcome","uuid":"6c1beddeb3b71705bde82eaebaf19652","version":"1.5.0","vendor":{"version":"1.5.0","name":"The Apache Software Foundation"}}
```

### Creating a Couchdb database

We can now create a Couchdb database and put some documents into Couchdb. 

```bash
# Create a database with the name phillydevops
curl -XPUT http://localhost:5984/phillydevops # Resonse: {"ok":true}

# Put Documents into Couchdb
# stuff here
```
