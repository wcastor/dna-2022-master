FROM wcastor/dna-2022-hadoop-base:1.0

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

ADD nodemanager/run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8042

CMD ["/run.sh"]
