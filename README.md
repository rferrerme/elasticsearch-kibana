## Elasticsearch and Kibana running in a Docker container

This will create a Docker container with Elasticsearch and Kibana, plus some sample data to be able to play with them.

### Requirements

* [Docker](https://www.docker.com)

### Notes about connectivity

The container will map the Elasticsearch and Kibana ports to the **host that runs Docker**.

There are two scenarios:

* Using Docker in Linux:
    * The host that runs Docker is `localhost`

* Using Docker in Windows or OS X:
    * The host that runs Docker is a Virtual Machine, not localhost
    * To get its IP address:
        * If you are using boot2docker: `boot2docker ip`
        * If you are using Docker Machine: `docker-machine ip <machine-name>`

You will have to connect to the host that runs Docker to reach Elasticsearch or Kibana. We will refer to that host as `<DOCKER_HOST>` later in this guide.

### Build the Docker image

We will use a Java 8 base image from the `Dockerfile` project.

You need to pull a base image first:

```
docker build -t dockerfile/ubuntu github.com/dockerfile/ubuntu
```

Then clone the Java Dockerfile repository:

```
git clone https://github.com/dockerfile/java.git
````

And build the Java 8 image:

```
docker build -t dockerfile/java:oracle-java8 java/oracle-java8
```

Finally build the Docker image that we will use which includes both Elasticsearch and Kibana:

```
docker build -t elasticsearch-kibana .
````

### Run Elasticsearch

Run the container in the background (it will start Elasticsearch):

```
docker run -d --name kibana -p 9200:9200 -p 5601:5601 elasticsearch-kibana
```

The name of the container is `kibana`. You can check its output if needed using:

```
docker logs kibana
```

### Load sample data


Download the data:

```
wget -O accounts.zip https://github.com/bly2k/files/blob/master/accounts.zip?raw=true
```

Extract it:
```
unzip accounts.zip
```

Put it into Elasticsearch (point to the Docker host to reach Elasticsearch):

```
curl -XPOST 'http://<DOCKER_HOST>:9200/bank/account/_bulk?pretty' --data-binary @accounts.json
```

Check that there is a `bank` index loaded:

```
curl 'http://<DOCKER_HOST>:9200/_cat/indices?v'
```

### Run kibana

```
docker exec -it kibana kibana-4.0.2-linux-x64/bin/kibana
```

The terminal will show some activity from Kibana.

### Connect to Kibana

Use a web browser to connect to Kibana at the Docker host:  `http://<DOCKER_HOST>:5601`.

Some tips to see the data that we loaded:

* Disable `Index contains time-based events` and enter `bank` for the `Index name`
* Then press `Create` and the button with a **star** to `Set as default index`
* Go to `Discover` to start exploring the data and then move to `Visualize` and `Dashboard` for more

### Learn

Use any of the online tutorials to learn about Elasticsearch and Kibana, e.g.: [Kibana 4 Tutorial](https://www.timroes.de/2015/02/07/kibana-4-tutorial-part-1-introduction/)

Have fun!

### Credits:

* [Dockerfile Project](https://github.com/dockerfile)
* [Bihn Ly](https://github.com/bly2k)
* [Tim Roes](https://www.timroes.de)