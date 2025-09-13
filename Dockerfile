ARG VERSION

FROM docker.elastic.co/elasticsearch/elasticsearch:${VERSION} AS Baseline

FROM bellsoft/liberica-openjdk-debian:17

ARG VERSION
ARG HTTP_PROXY
ARG HTTPS_PROXY
ENV VERSION=${VERSION}

WORKDIR /crack

COPY --from=baseline /usr/share/elasticsearch/lib /usr/share/elasticsearch/lib
COPY --from=baseline /usr/share/elasticsearch/modules/x-pack-core /usr/share/elasticsearch/modules/x-pack-core
COPY build_crack_jar.sh /crack

RUN apt update && apt install -y zip

CMD [ "bash", "build_crack_jar.sh" ]