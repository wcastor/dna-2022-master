FROM wcastor/dna-2022-hadoop-base:1.0

RUN apt-get update && apt-get install -y wget libpostgresql-jdbc-java procps libsasl2-modules libsasl2-dev && rm -rf /var/lib/apt/lists/*

# Install Apache Hive
ENV HIVE_VERSION=3.1.0
ENV HIVE_HOME=/opt/hive
ENV HIVE_CONF_DIR=$HIVE_HOME/conf
ENV PATH $PATH:$HIVE_HOME/bin
RUN wget https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz \
  && tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz \
  && mkdir -p ${HIVE_HOME} \
  && mv apache-hive-$HIVE_VERSION-bin/* /opt/hive \
  && chown -R root:root $HIVE_HOME \
  && mkdir -p $HIVE_HOME/hcatalog/var/log \
  && mkdir -p $HIVE_HOME/var/log \
  && mkdir -p /data/hive/ \
  && mkdir -p $HIVE_CONF_DIR \
  && chmod 777 $HIVE_HOME/hcatalog/var/log \
  && chmod 777 $HIVE_HOME/var/log

# Configure
ADD hive/files/hive-site.xml $HIVE_CONF_DIR/

ADD hive/files/init-hive.sh /
RUN chmod +x /init-hive.sh

EXPOSE 10000

ENTRYPOINT ["/init-hive.sh"]