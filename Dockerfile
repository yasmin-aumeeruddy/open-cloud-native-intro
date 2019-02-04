FROM open-liberty as server-setup
COPY /target/defaultServer.zip /config/
RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip \
    && unzip /config/defaultServer.zip \
    && mv /wlp/usr/servers/defaultServer/* /config/ \
    && rm -rf /config/wlp \
    && rm -rf /config/defaultServer.zip \
    && apt-get remove -y unzip

FROM open-liberty
LABEL maintainer="Graham Charters" vendor="IBM" github="https://github.com/WASdev/ci.maven"
COPY --from=server-setup /config/ /config/
EXPOSE 9080 9443