#!/bin/bash
#
# -- Build Apache Spark Standalone Cluster Docker Images

# ----------------------------------------------------------------------------------------------------------------------
# -- Variables ---------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

BUILD_DATE="$(date -u +'%Y-%m-%d')"

SHOULD_BUILD_BASE="true"
SHOULD_BUILD_SPARK="true"
SHOULD_BUILD_JUPYTERLAB="true"

SPARK_VERSION="3.2.1"
JUPYTERLAB_VERSION="3.2.9"

HADOOP_VERSION="3.2"
SCALA_VERSION="2.12.10"
SCALA_KERNEL_VERSION="0.10.9"
HIVE_VERSION="3.1.0"

# ----------------------------------------------------------------------------------------------------------------------
# -- Functions----------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

function cleanContainers() {

    container="$(docker ps -a | grep 'dna-2022-spark-jupyterlab' | awk '{print $1}')"
    docker stop "${container}"
    docker rm "${container}"

    container="$(docker ps -a | grep 'dna-2022-spark-worker' -m 1 | awk '{print $1}')"
    while [ -n "${container}" ];
    do
      docker stop "${container}"
      docker rm "${container}"
      container="$(docker ps -a | grep 'dna-2022-spark-worker' -m 1 | awk '{print $1}')"
    done

    container="$(docker ps -a | grep 'dna-2022-spark-master' | awk '{print $1}')"
    docker stop "${container}"
    docker rm "${container}"

    container="$(docker ps -a | grep 'dna-2022-spark-base' | awk '{print $1}')"
    docker stop "${container}"
    docker rm "${container}"

    container="$(docker ps -a | grep 'dna-2022-os-base' | awk '{print $1}')"
    docker stop "${container}"
    docker rm "${container}"

    container="$(docker ps -a | grep 'dna-2022-hive' | awk '{print $1}')"
    docker stop "${container}"
    docker rm "${container}"

    container="$(docker ps -a | grep 'dna-2022-hive-metastore' | awk '{print $1}')"
    docker stop "${container}"
    docker rm "${container}"

    container="$(docker ps -a | grep 'dna-2022-hadoop-base-namenode' -m 1 | awk '{print $1}')"
    while [ -n "${container}" ];
    do
      docker stop "${container}"
      docker rm "${container}"
      container="$(docker ps -a | grep 'dna-2022-hadoop-base-namenode' -m 1 | awk '{print $1}')"
    done

    container="$(docker ps -a | grep 'dna-2022-hadoop-base-datanode' -m 1 | awk '{print $1}')"
    while [ -n "${container}" ];
    do
      docker stop "${container}"
      docker rm "${container}"
      container="$(docker ps -a | grep 'dna-2022-hadoop-base-datanode' -m 1 | awk '{print $1}')"
    done

    container="$(docker ps -a | grep 'dna-2022-hadoop-base-nodemanager' -m 1 | awk '{print $1}')"
    while [ -n "${container}" ];
    do
      docker stop "${container}"
      docker rm "${container}"
      container="$(docker ps -a | grep 'dna-2022-hadoop-base-nodemanager' -m 1 | awk '{print $1}')"
    done

    container="$(docker ps -a | grep 'dna-2022-hadoop-base-resourcemanager' -m 1 | awk '{print $1}')"
    while [ -n "${container}" ];
    do
      docker stop "${container}"
      docker rm "${container}"
      container="$(docker ps -a | grep 'dna-2022-hadoop-base-resourcemanager' -m 1 | awk '{print $1}')"
    done

    container="$(docker ps -a | grep 'dna-2022-hadoop-base-historyserver' -m 1 | awk '{print $1}')"
    while [ -n "${container}" ];
    do
      docker stop "${container}"
      docker rm "${container}"
      container="$(docker ps -a | grep 'dna-2022-hadoop-base-historyserver' -m 1 | awk '{print $1}')"
    done

    container="$(docker ps -a | grep 'dna-2022-hadoop-base' -m 1 | awk '{print $1}')"
    while [ -n "${container}" ];
    do
      docker stop "${container}"
      docker rm "${container}"
      container="$(docker ps -a | grep 'dna-2022-hadoop-base' -m 1 | awk '{print $1}')"
    done

}

function cleanImages() {

    if [[ "${SHOULD_BUILD_JUPYTERLAB}" == "true" ]]
    then
      docker rmi -f "$(docker images | grep -m 1 'dna-2022-spark-jupyterlab' | awk '{print $3}')"
    fi

    if [[ "${SHOULD_BUILD_SPARK}" == "true" ]]
    then
      docker rmi -f "$(docker images | grep -m 1 'dna-2022-spark-worker' | awk '{print $3}')"
      docker rmi -f "$(docker images | grep -m 1 'dna-2022-spark-master' | awk '{print $3}')"
      docker rmi -f "$(docker images | grep -m 1 'dna-2022-spark-base' | awk '{print $3}')"
    fi

    if [[ "${SHOULD_BUILD_BASE}" == "true" ]]
    then
      docker rmi -f "$(docker images | grep -m 1 'dna-2022-os-base' | awk '{print $3}')"
    fi
    docker rmi -f "$(docker images | grep -m 1 'dna-2022-hive' | awk '{print $3}')"
    docker rmi -f "$(docker images | grep -m 1 'dna-2022-hive-metastore' | awk '{print $3}')"
    docker rmi -f "$(docker images | grep -m 1 'dna-2022-hadoop-base-namenode' | awk '{print $3}')"
    docker rmi -f "$(docker images | grep -m 1 'dna-2022-hadoop-base-datanode' | awk '{print $3}')"
    docker rmi -f "$(docker images | grep -m 1 'dna-2022-hadoop-base-nodemanager' | awk '{print $3}')"
    docker rmi -f "$(docker images | grep -m 1 'dna-2022-hadoop-base-resourcemanager' | awk '{print $3}')"
    docker rmi -f "$(docker images | grep -m 1 'dna-2022-hadoop-base-historyserver' | awk '{print $3}')"
    docker rmi -f "$(docker images | grep -m 1 'dna-2022-hadoop-base' | awk '{print $3}')"

}

function buildImages() {
  docker buildx create --use
  docker buildex use dnabuilder
  docker buildx build --platform=linux/amd64,linux/arm64 -f base/Dockerfile -t wcastor/dna-2022-hadoop-base:1.0 --push .
  docker buildx build --platform=linux/amd64,linux/arm64 -f namenode/Dockerfile -t wcastor/dna-2022-hadoop-base-namenode:1.0 --push .
  docker buildx build --platform=linux/amd64,linux/arm64 -f datanode/Dockerfile -t wcastor/dna-2022-hadoop-base-datanode:1.0 --push .
  docker buildx build --platform=linux/amd64,linux/arm64 -f nodemanager/Dockerfile -t wcastor/dna-2022-hadoop-base-nodemanager:1.0 --push .
  docker buildx build --platform=linux/amd64,linux/arm64 -f resourcemanager/Dockerfile -t wcastor/dna-2022-hadoop-base-resourcemanager:1.0 --push .
  docker buildx build --platform=linux/amd64,linux/arm64 -f historyserver/Dockerfile -t wcastor/dna-2022-hadoop-base-historyserver:1.0 --push .
  docker buildx build --platform=linux/amd64,linux/arm64 \
    --build-arg spark_version=${SPARK_VERSION} \
    --build-arg hadoop_version=${HADOOP_VERSION} \
    -f spark/docker/base/Dockerfile \
    -t wcastor/dna-2022-os-base:latest --push .
  docker buildx build --platform=linux/amd64,linux/arm64 \
    -f spark/docker/spark-base/Dockerfile \
    -t wcastor/dna-2022-spark-base:${SPARK_VERSION} --push .
  docker buildx build --platform=linux/amd64,linux/arm64 \
    --build-arg spark_version=${SPARK_VERSION} \
    -f spark/docker/spark-master/Dockerfile \
    -t wcastor/dna-2022-spark-master:${SPARK_VERSION} --push .
  docker buildx build --platform=linux/amd64,linux/arm64 \
    --build-arg spark_version=${SPARK_VERSION} \
    -f spark/docker/spark-worker/Dockerfile \
    -t wcastor/dna-2022-spark-worker:${SPARK_VERSION} --push .
  docker buildx build --platform=linux/amd64,linux/arm64 \
    --build-arg spark_version=${SPARK_VERSION} \
    --build-arg jupyterlab_version=${JUPYTERLAB_VERSION} \
    -f spark/docker/jupyterlab/Dockerfile \
    -t wcastor/dna-2022-spark-jupyterlab:${JUPYTERLAB_VERSION}-spark-${SPARK_VERSION} --push .
  docker buildx build --platform=linux/amd64,linux/arm64 \
    -f hive/Dockerfile \
    -t wcastor/dna-2022-hive:${HIVE_VERSION} --push .
  docker buildx build --platform=linux/amd64,linux/arm64 \
    -f hive-metastore/Dockerfile \
    -t wcastor/dna-2022-hive-metastore:${HIVE_VERSION} --push .
}

# ----------------------------------------------------------------------------------------------------------------------
# -- Main --------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

cleanContainers;
cleanImages;
buildImages;
