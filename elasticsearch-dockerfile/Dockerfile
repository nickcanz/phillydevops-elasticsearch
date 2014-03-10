#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM dockerfile/java

# Install ElasticSearch.
RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.1.tar.gz
RUN tar xzf elasticsearch-1.0.1.tar.gz
RUN mv elasticsearch-1.0.1 /opt/elasticsearch
RUN rm elasticsearch-1.0.1.tar.gz

# Set cluster name
RUN echo 'cluster.name : elasticsearch-docker' >> /opt/elasticsearch/config/elasticsearch.yml

RUN sed -i 's/es\.logger\.level\: INFO/es\.logger\.level\: DEBUG/' /opt/elasticsearch/config/logging.yml
#RUN echo 'rootLogger: ${es.logger.level}, console, file' >> /etc/elasticsearch/logging.yml
#RUN echo 'logger:' >> /etc/elasticsearch/logging.yml
#RUN echo '  action: DEBUG' >> /etc/elasticsearch/logging.yml
#RUN echo '  com.amazonaws: WARN' >> /etc/elasticsearch/logging.yml
#
RUN /opt/elasticsearch/bin/plugin -install mobz/elasticsearch-head
RUN /opt/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-lang-javascript/2.0.0.RC1
RUN /opt/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-river-couchdb/2.0.0

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300

# Define an entry point.
ENTRYPOINT ["/opt/elasticsearch/bin/elasticsearch"]
CMD ["-f"]
