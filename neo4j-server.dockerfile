FROM neo4j-graph-algorithms:latest as neo4j
#For normal use cases ("neo4j:3.3-enterprise" for neo4j enterprise)
#FROM neo4j:3.3 as neo4j

RUN apk --update add curl

# TODO: Is this COPY neccessary?
COPY ./neo4j-app/local-package/* /tmp/

WORKDIR /var/lib/neo4j

RUN mv data /data \
    && ln -s /data /var/lib/neo4j/data 


VOLUME /data
VOLUME /conf

COPY neo4j-app/docker-entrypoint.sh /docker-entrypoint.sh
COPY neo4j-app/import-data.sh /import-data.sh
COPY neo4j-app/create-index.sh /create-index.sh
COPY neo4j-app/index.cql /index.cql

EXPOSE 7474 7473 7687

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["neo4j"]
