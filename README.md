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
```

Now, when going to [http://localhost:9200/_plugin/head/](http://localhost:9200/_plugin/head/), you should see something like this.
![5 Nodes Unassigned](./images/elasticsearch-unassigned-nodes.png?raw=true)
