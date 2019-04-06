FROM alpine:3.9

ARG VCS_REF
ARG BUILD_DATE
ARG BUILD_VERSION
ARG BUILD_TYPE
ARG PAPERLESS_VERSION

# Set export and consumption directories
ENV \
  TZ='Europe/Berlin' \
  PAPERLESS_HOME=/opt/paperless \
  PAPERLESS_EXPORT_DIR=/export \
  PAPERLESS_CONSUMPTION_DIR=/consume

# ---------------------------------------------------------------------------------------

# hadolint ignore=DL3003,DL3008,DL3013,DL3014,DL3015,DL3017,DL3018,DL3019
RUN \
  apk update  --quiet && \
  apk upgrade --quiet && \
  apk add     --quiet \
    python3 \
    gnupg \
    libmagic \
    libpq \
    bash \
    curl \
    sudo \
    poppler \
    tesseract-ocr \
    tesseract-ocr-data-deu \
    imagemagick \
    ghostscript \
    unpaper \
    optipng && \
  apk add     --quiet --virtual .build-dependencies \
    python3-dev \
    poppler-dev \
    postgresql-dev \
    gcc \
    g++ \
    musl-dev \
    shadow \
    tzdata \
    zlib-dev \
    jpeg-dev \
    git && \
  cp "/usr/share/zoneinfo/${TZ}" /etc/localtime && \
  echo "${TZ}" > /etc/timezone && \
  mkdir -p "${PAPERLESS_HOME}" && \
  addgroup \
    -g 1000 \
    paperless && \
  adduser \
    -D \
    -u 1000 \
    -G paperless \
    -h "${PAPERLESS_HOME}" \
    paperless && \
  cd /tmp && \
  git clone https://github.com/danielquinn/paperless.git && \
  cd /tmp/paperless && \
  if [ "${BUILD_TYPE}" = "stable" ] ; then \
    echo "switch to stable Tag ${PAPERLESS_VERSION}" && \
    git checkout tags/"${PAPERLESS_VERSION}" 2> /dev/null ; \
  fi && \
  pip3 install \
    --quiet \
    --upgrade \
    pip && \
  pip3 install \
    --requirement /tmp/paperless/requirements.txt && \
  cp -ar /tmp/paperless/src   "${PAPERLESS_HOME}"/ && \
  cp -ar /tmp/paperless/data  "${PAPERLESS_HOME}"/ && \
  cp -ar /tmp/paperless/media "${PAPERLESS_HOME}"/ && \
  mkdir -p \
    "${PAPERLESS_CONSUMPTION_DIR}" \
    "${PAPERLESS_EXPORT_DIR}" && \
  chown \
    -Rh \
    paperless:paperless \
    "${PAPERLESS_HOME}" && \
  apk del --quiet .build-dependencies && \
  rm -rf \
    /build \
    /tmp/* \
    /root/.cache \
    /var/cache/apk/*

COPY rootfs /

WORKDIR ${PAPERLESS_HOME}
# USER paperless

VOLUME ["${PAPERLESS_HOME}/data", "${PAPERLESS_HOME}/media", "${PAPERLESS_CONSUMPTION_DIR}", "${PAPERLESS_EXPORT_DIR}"]
ENTRYPOINT ["/init/run.sh"]
CMD ["--help"]

HEALTHCHECK \
  --interval=30s \
  --timeout=2s \
  --retries=10 \
  --start-period=15s \
  CMD /init/healthcheck.sh

# ---------------------------------------------------------------------------------------

EXPOSE 8000

LABEL \
  version=${BUILD_VERSION} \
  maintainer="Bodo Schulz <bodo@boone-schulz.de>" \
  org.label-schema.build-date=${BUILD_DATE} \
  org.label-schema.name="paperless Docker Image" \
  org.label-schema.description="Inofficial paperless Docker Image" \
  org.label-schema.url="https://github.com/danielquinn/paperless" \
  org.label-schema.vcs-ref=${VCS_REF} \
  org.label-schema.vcs-url="https://github.com/bodsch/docker-paperless" \
  org.label-schema.vendor="Bodo Schulz" \
  org.label-schema.version=${ICINGAWEB_VERSION} \
  org.label-schema.schema-version="1.0" \
  com.microscaling.docker.dockerfile="/Dockerfile" \
  com.microscaling.license="GNU General Public License v3.0"

# ---------------------------------------------------------------------------------------
