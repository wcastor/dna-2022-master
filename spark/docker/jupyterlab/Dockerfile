FROM eclipse-temurin:8-jdk-focal

# -- Layer: JupyterLab + Python kernel for PySpark

ARG spark_version
ARG jupyterlab_version
RUN mkdir -p ${SHARED_WORKSPACE}
COPY spark/workspace/* ${SHARED_WORKSPACE}/
RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev && \
    pip3 install --upgrade pip && \
    pip3 install wget==3.2 pyspark==${spark_version} jupyterlab==${jupyterlab_version} pandas matplotlib seaborn scikit-learn theme-darcula

# -- Runtime

EXPOSE 8888

WORKDIR ${SHARED_WORKSPACE}
CMD ["jupyter", "lab", "--NotebookApp.token=", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]