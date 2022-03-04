ARG spark_version
FROM wcastor/dna-2022-spark-base:${spark_version}

# -- Runtime
ADD spark/docker/spark-master/master.sh /master.sh
RUN chmod a+x /master.sh

ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /spark/logs
EXPOSE 8080 7077 6066

CMD ["/bin/bash", "/master.sh"]
