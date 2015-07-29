FROM dockerfile/java:oracle-java8
RUN wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.5.2.tar.gz
RUN tar -xvf elasticsearch-1.5.2.tar.gz
RUN wget https://download.elastic.co/kibana/kibana/kibana-4.0.2-linux-x64.tar.gz
RUN tar -xvf kibana-4.0.2-linux-x64.tar.gz
EXPOSE 9200 5601
CMD ["elasticsearch-1.5.2/bin/elasticsearch"]
