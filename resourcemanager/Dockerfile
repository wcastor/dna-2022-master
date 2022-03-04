FROM wcastor/dna-2022-hadoop-base:1.0

HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

ADD resourcemanager/run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8088

CMD ["/run.sh"]
