FROM node:17-stretch

ENV NEO4J_SHA256=b598edeb3401e5ec40fb7bc3370307addfcaa21565f731016c9c7f8e70af659a \
    NEO4J_TARBALL=neo4j-community-4.1.0-unix.tar.gz \
    NEO4J_EDITION=community
ARG NEO4J_URI=https://dist.neo4j.org/neo4j-community-4.1.0-unix.tar.gz

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk bash wget curl

RUN curl --fail --silent --show-error --location --remote-name ${NEO4J_URI} \
    && echo "${NEO4J_SHA256}  ${NEO4J_TARBALL}" | sha256sum -cw - \
    && tar --extract --file ${NEO4J_TARBALL} --directory /var/lib \
    && mv /var/lib/neo4j-* /var/lib/neo4j \
    && rm ${NEO4J_TARBALL} \
    && mv /var/lib/neo4j/data /data \
    && ln -s /data /var/lib/neo4j/data

ENV PATH /var/lib/neo4j/bin:$PATH

ENV NEO4J_AUTH "neo4j/neo"

ENV APOC_JAR=apoc-4.1.0.0-all.jar\
    GRAPHAWARE_FRAMEWORK_JAR=graphaware-server-community-all-3.5.14.55.jar \
    NEO4J_GRAPHQL_JAR=neo4j-graphql-3.3.0.0.jar \
    GRAPHAWARE_UUID_JAR=graphaware-uuid-3.3.2.52.14.jar\
    GRAPHAWARE_NEOTOELASTIC_JAR=neo4j-to-elasticsearch-3.5.12.55.10.jar
ARG GRAPHAWARE_FRAMEWORK_URI=https://neo4j-plugins-public.s3.eu-west-1.amazonaws.com/graphaware-server-all-3.5.14.55.jar
ARG GRAPHAWARE_UUID_URI=https://neo4j-plugins-public.s3.eu-west-1.amazonaws.com/uuid-3.5.14.55.19.jar
ARG APOC_URI=https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/4.1.0.0/apoc-4.1.0.0-all.jar
ARG GRAPHAWARE_NEOTOELASTIC_URI=https://neo4j-plugins-public.s3.eu-west-1.amazonaws.com/neo4j-to-elasticsearch-3.5.12.55.10.jar

RUN curl --fail --silent --show-error --location -o /var/lib/neo4j/plugins/${GRAPHAWARE_FRAMEWORK_JAR} --remote-name ${GRAPHAWARE_FRAMEWORK_URI}
RUN curl --fail --silent --show-error --location -o /var/lib/neo4j/plugins/${GRAPHAWARE_UUID_JAR} --remote-name ${GRAPHAWARE_UUID_URI}
RUN curl --fail --silent --show-error --location -o /var/lib/neo4j/plugins/${APOC_JAR} --remote-name ${APOC_URI}
RUN curl --fail --silent --show-error --location -o /var/lib/neo4j/plugins/${GRAPHAWARE_NEOTOELASTIC_JAR} --remote-name ${GRAPHAWARE_NEOTOELASTIC_URI}

WORKDIR /var/lib/neo4j


VOLUME /data

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 7474 7473 7687

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["neo4j"]













