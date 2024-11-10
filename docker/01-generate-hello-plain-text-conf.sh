set -e

envsubst '${ENVIRONMENT} ${N5SECRET}' < /etc/nginx/hello-plain-text.conf.template > /etc/nginx/conf.d/hello-plain-text.conf
