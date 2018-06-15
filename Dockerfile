FROM node:9-stretch

ENV NEO4J_SHA256=8a2a74f1270944d9b72f2af2c15cb350718e697af6e3800e67cb32a5d1605f6e \
    NEO4J_TARBALL=neo4j-community-3.3.2-unix.tar.gz \
    NEO4J_EDITION=community
ARG NEO4J_URI=http://dist.neo4j.org/neo4j-community-3.3.2-unix.tar.gz

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

ENV APOC_JAR=apoc-3.3.0.1-all.jar \
    GRAPHAWARE_FRAMEWORK_JAR=graphaware-server-community-all-3.3.2.52.jar \
    NEO4J_GRAPHQL_JAR=neo4j-graphql-3.3.0.0.jar \
    GRAPHAWARE_UUID_JAR=graphaware-uuid-3.3.2.52.14.jar
ARG NEO4J_GRAPHQL_URI=https://github.com/neo4j-graphql/neo4j-graphql/releases/download/3.3.0.0/neo4j-graphql-3.3.0.0.jar
ARG GRAPHAWARE_FRAMEWORK_URI=https://products.graphaware.com/download/framework-server-community/graphaware-server-community-all-3.3.2.52.jar
ARG GRAPHAWARE_UUID_URI=https://products.graphaware.com/download/uuid/graphaware-uuid-3.3.2.52.14.jar
ARG APOC_URI=https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/3.3.0.1/apoc-3.3.0.1-all.jar


RUN curl --fail --silent --show-error --location -o /var/lib/neo4j/plugins/${NEO4J_GRAPHQL_JAR} --remote-name ${NEO4J_GRAPHQL_URI}
RUN curl --fail --silent --show-error --location -o /var/lib/neo4j/plugins/${GRAPHAWARE_FRAMEWORK_JAR} --remote-name ${GRAPHAWARE_FRAMEWORK_URI}
RUN curl --fail --silent --show-error --location -o /var/lib/neo4j/plugins/${GRAPHAWARE_UUID_JAR} --remote-name ${GRAPHAWARE_UUID_URI}
RUN curl --fail --silent --show-error --location -o /var/lib/neo4j/plugins/${APOC_JAR} --remote-name ${APOC_URI}

WORKDIR /var/lib/neo4j


VOLUME /data

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 7474 7473 7687

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["neo4j"]













