#FROM bitnami/kafka:latest
# Download MongoDB&reg; Connector for Apache Kafka https://www.confluent.io/hub/mongodb/kafka-connect-mongodb
#RUN mkdir -p /opt/bitnami/kafka/plugins && \
#    cd /opt/bitnami/kafka/plugins && \
#    curl --remote-name --location --silent https://search.maven.org/remotecontent?filepath=org/mongodb/kafka/mongo-kafka-connect/1.2.0/mongo-kafka-connect-1.2.0-all.jar
#CMD /opt/bitnami/kafka/bin/connect-standalone.sh /opt/bitnami/kafka/config/connect-standalone.properties /opt/bitnami/kafka/config/mongo.properties

FROM confluentinc/cp-kafka-connect-base:6.1.1

RUN    mkdir -p /bitnami/kafka/config
    && confluent-hub install confluentinc/kafka-connect-s3:10.0.0 \
    && confluent-hub install debezium/debezium-connector-postgresql:1.4.1 \
    && confluent-hub install debezium/debezium-connector-mysql:latest
CMD ./connect-standalone.sh ./connect-standalone.properties
