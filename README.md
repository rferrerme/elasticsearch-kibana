## Elasticsearch and Kibana running in a Docker container

### Requirements:

* [Docker](https://www.docker.com)

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

Finally build the Docker image that we will use which includes both `elasticsearch` and `kibana`:

```
docker build -t elasticsearch-kibana .
````

### Run elasticsearch

Run the container in the background (it will start `elasticsearch`):

```
docker run -d --name kibana -p 9200:9200 -p 5601:5601 elasticsearch-kibana
```

You can check its output if needed using:

```
docker logs kibana
```

### Load data


Download some sample data:

```
wget -O accounts.zip https://github.com/bly2k/files/blob/master/accounts.zip?raw=true
```

Extract it:
```
unzip accounts.zip
```

Put it into `elasticsearch`:

```
curl -XPOST 'http://localhost:9200/bank/account/_bulk?pretty' --data-binary @accounts.json
```

Check that there is a `bank` index loaded:

```
curl 'http://localhost:9200/_cat/indices?v'
```

### Run kibana

```
docker exec -it kibana kibana-4.0.2-linux-x64/bin/kibana
```

The terminal will show some activity from Kibana.

### Connect to kibana

Use a web browser to connect to your machine at port `5601`.

***Note***: if you are using Docker from e.g. Windows or OS X then the container is running inside a VM. You should connect to the IP of that VM to reach kibana.

Some tips to see the data that we loaded:

* Disable `Index contains time-based events` and enter `bank` for the `Index name`
* Then press `Create` and the button with a **star** to `Set as default index`
* Go to `Discover` to start exploring the data and then move to `Visualize` and `Dashboard` for more

### Learn

Use any of the online tutorials to learn about `elasticsearch` and `kibana`, e.g.: [Kibana 4 Tutorial](https://www.timroes.de/2015/02/07/kibana-4-tutorial-part-1-introduction/)

Have fun!

### Credits:

* [Dockerfile Project](https://github.com/dockerfile)
* [Bihn Ly](https://github.com/bly2k)
* [Tim Roes](https://www.timroes.de)