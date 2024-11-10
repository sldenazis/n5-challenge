FROM nginxdemos/hello:plain-text

COPY ./01-generate-hello-plain-text-conf.sh /docker-entrypoint.d/01-generate-hello-plain-text-conf.sh
RUN chmod +x /docker-entrypoint.d/01-generate-hello-plain-text-conf.sh
COPY ./hello-plain-text.conf.template /etc/nginx/hello-plain-text.conf.template

ENV ENVIRONMENT="local"
ENV N5SECRET="changeme"
