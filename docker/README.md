# Hello docker image

This is a docker image based on nginxdemos/hello:plain-text.
It's modified to return a differente message depending on the environment variables ENVIRONMENT and N5SECRET.

## Kubernetes notes

* If we run the container with a readonly filesystem, it's necessary to mount a volume for /etc/nginx/conf.d to be able to change the configuration file. EmptyDir is recommended for this purpose..
