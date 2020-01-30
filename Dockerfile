# Based on "https://raw.githubusercontent.com/fluent/fluentd-docker-image/master/v1.9/alpine/Dockerfile" (accessed 2020-01-30).

ARG BUILD_DATE=none
ARG BUILD_FLUENTD_VERSION=v1.9.0-1.0
ARG BUILD_FLUENTD_PLUGIN_PROMETHEUS_VERSION=1.7.0
ARG BUILD_VERSION=${BUILD_FLUENTD_VERSION}_${BUILD_FLUENTD_PLUGIN_PROMETHEUS_VERSION}
ARG VCS_REF=none

FROM fluentd:${BUILD_FLUENTD_VERSION}

# Do not split this into multiple RUN!
# Docker creates a layer for every RUN-Statement
# therefore an 'apk delete' has no effect
RUN \
 gem install fluent-plugin-prometheus -v ${BUILD_FLUENTD_PLUGIN_PROMETHEUS_VERSION} \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent
ENTRYPOINT ["tini",  "--", "/bin/entrypoint.sh"]
CMD ["fluentd"]

LABEL \
  version="${BUILD_VERSION}" \
  maintainer="Alex Talbot <alexandertgtalbot@gmail.com>" \
  org.label-schema.build-date=${BUILD_DATE} \
  org.label-schema.description="Based on the official Fluentd Docker image with fluent-plugin-prometheus installed" \
  org.label-schema.url="https://github.com/alexandertgtalbot/fluentd-prometheus" \
  org.label-schema.vcs-url="https://github.com/alexandertgtalbot/fluentd-prometheus" \
  org.label-schema.vcs-ref=${VCS_REF} \
  org.label-schema.version="Fluent Organization" \
  org.label-schema.version=${BUILD_DOCKER_TAG} \
  org.label-schema.schema-version="1.0" \
  com.microscaling.docker.dockerfile="/Dockerfile" \
  com.microscaling.license="Apache License 2.0"
