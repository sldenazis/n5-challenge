set -e

envsubst '${ENVIRONMENT}' < /etc/nginx/hello-plain-text.conf.template > /etc/nginx/conf.d/hello-plain-text.conf
