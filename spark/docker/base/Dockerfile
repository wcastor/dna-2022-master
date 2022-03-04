FROM wcastor/dna-2022-hadoop-base:1.0

ARG spark_version
ARG hadoop_version
ARG shared_workspace=/opt/workspace

RUN curl https://archive.apache.org/dist/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop${hadoop_version}.tgz -o spark.tgz && \
    tar -xf spark.tgz && \
    mkdir /spark && \
    mkdir -p ${shared_workspace}/data && \
    mv spark-${spark_version}-bin-hadoop${hadoop_version}/* /spark && \
    echo "alias pyspark=/spark/bin/pyspark" >> ~/.bashrc && \
    echo "alias spark-shell=/spark/bin/spark-shell" >> ~/.bashrc && \
    mkdir /spark/logs && \
    rm spark.tgz

ENV SHARED_WORKSPACE=${shared_workspace}
# -- Runtime

VOLUME ${shared_workspace}
CMD ["bash"]
