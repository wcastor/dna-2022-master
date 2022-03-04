ARG spark_version
FROM wcastor/dna-2022-spark-base:${spark_version}

# -- Runtime

ADD spark/docker/spark-worker/worker.sh /worker.sh
RUN chmod a+x /worker.sh
ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /spark/logs
ENV SPARK_MASTER "spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}"

EXPOSE 8081

CMD ["/bin/bash", "/worker.sh"]