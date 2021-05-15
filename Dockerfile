FROM  bitnami/kafka:latest
USER  root
RUN   mkdir -p /bin/confluent/share/ && mkdir -p /opt/bitnami/kafka/plugins
COPY  share/java /bin/confluent/share/java 
COPY  jars/*.jar /usr/share/java/
COPY  confluent-hub /bin
COPY  connect-standalone.properties /opt/bitnami/kafka/config/connect-standalone.properties
RUN   confluent-hub install --no-prompt confluentinc/kafka-connect-s3:10.0.0 --component-dir /opt/bitnami/kafka/plugins  --worker-configs /opt/bitnami/kafka/config/connect-standalone.properties \
   && confluent-hub install --no-prompt debezium/debezium-connector-postgresql:1.4.1 --component-dir /opt/bitnami/kafka/plugins  --worker-configs /opt/bitnami/kafka/config/connect-standalone.properties \
   && confluent-hub install --no-prompt debezium/debezium-connector-mysql:latest --component-dir /opt/bitnami/kafka/plugins  --worker-configs /opt/bitnami/kafka/config/connect-standalone.properties
CMD /opt/bitnami/kafka/bin/connect-standalone.sh /opt/bitnami/kafka/config/connect-standalone.properties \
    /opt/bitnami/kafka/plugins/confluentinc-kafka-connect-s3/etc/quickstart-schema-source-for-s3.properties
