# n5-challenge

- [Challenge description (spanish)](#challenge-description-spanish)
- [Repository structure](#repository-structure)
  - [Charts](#charts)
  - [Helmfile](#helmfile)
  - [Docker](#docker)
  - [Terraform](#terraform)
- [Workflows](#workflows)
  - [Terraform Dev Plan](#terraform-dev-plan)
  - [Terraform Dev Apply](#terraform-dev-apply)
  - [Terraform Dev Destroy](#terraform-dev-destroy)
  - [Docker Build and Push](#docker-build-and-push)
  - [Helmfile Diff](#helmfile-diff)
  - [Helmfile Apply](#helmfile-apply)
  - [Test Environments](#test-environments)
- [Notes](#notes)

## Challenge description (spanish)

Utilizando helmfile crear un deployment multi-stage. Utilizando los siguientes
comandos, deberiamos poder deployar la misma imagen con diferentes
configuraciones a el mismo cluster de Kubernetes.

* helmfile -e dev apply
* helmfile -e stage apply

La imagen a deployar es la siguiente: https://hub.docker.com/r/nginxdemos/hello/

Se necesita modificar la imagen para que agregue la siguiente información:

* El environment (dev or stage)
* A secret value

Para agregar de forma segura el secret a helm charts utilizar helm secrets.
En función de tener la tarea realizada, se espera que la imagen sea deployada
automáticamente por cada cambio que se realiace en el provedor cloud
seleccionado.

En caso de tocar Azure, se debe utilizar AKS.
En caso de tocar AWS, se debe utilizar EKS.

El deployment de la infraestructura debe ser utilizando IaC (Infraestructure as
code).

Herramientas necesarias:
* Kubernetes
* Helm Chars
* Helmfile
* Helm secrets
* Terraform o CloudFormation
* Gitlab/Jenkins/CircleCI

## Repository structure

* charts/: Helm charts for the deployment of the application.
* docker/: Dockerfile for the application.
* helmfiles/: Helmfiles for the deployment of the application.
* terraform/: Terraform code for the deployment of the infrastructure.
* .github/workflows/: Github Actions workflows for the deployment and validation of the application.

### Charts

I've created a single helm chart called `n5challenge` to deploy de application. To meet the challenge requirements, I've added a configurable secret value `secrets.n5secret` and a configurable environment variable `env.environment`.

### Helmfile

To simplify the config for this challenge, I've defined the environments in the `helmfile.yaml` file.
I've defined both `dev` and `stage`, and I've added the `env.environment` and `secrets.n5secret` values for each environment.
`env.environment` is defined in plain text, and `secrets.n5secret` is defined as a secret using `helm-secrets`, with the actual value stored in an Azure's keyvault instance in my personal subscriptions (the configuration of the keyvault itself is outside of the scope of this challenge).

### Docker

I've created a docker image based on the `nginxdemos/hello:plain-text` image.
I've chosen `plain-text` over the `latest` tag to more easily validate the output on the console.
I've customized the image to add the environment variables `ENVIRONMENT` and `N5SECRET`, and added the script `/docker-entrypoint.d/01-generate-hello-plain-text-conf.sh` to generate `/etc/nginx/conf.d/hello_plain_text.conf` config file based on the `/etc/nginx/hello-plain-text.conf.template` template.
The script uses `envsubst` to replace the ENVIRONMENT and N5SECRET variables in the template.

### Terraform

I've made a simple terraform module to define an AKS cluster. I've chosen the simplest configuration possible, with a single node pool and a single node.
The state is hosted in a storage account in my personal azure subscription.

## Workflows

All the scripts and validations are defined using Github Actions workflows.
They use several repository secrets to authenticate against my Azure subscription and my Dockerhub account.
We have the following workflows:

### Terraform Dev Plan

This workflow validates the terraform code and plans the changes for the dev environment.
It is only triggered when a PR against the `main` branch is opened or updated.

### Terraform Dev Apply

This workflow applies the changes on Azure. It's triggered every time a PR is merged into the `main` branch.

### Terraform Dev Destroy

This one is only triggered manually, and it destroys all the resources created by the terraform apply workflow on my Azure subscription.
Super useful to save some money :).

### Docker Build and Push

This workflow is triggered on the main branch after [Terraform Dev Apply](#terraform-dev-apply) succeeds, to ensure that the infraestructure is up and running before building the docker image.
It builds the docker image and pushes it to my personal dockerhub account.
It uses the general purpose tag `plain-text` for the latest version, and also uses the short version of the git commit hash as a tag.
The repository is public, so the image is available at [https://hub.docker.com/repository/docker/santiagold/hello/general](https://hub.docker.com/repository/docker/santiagold/hello/general).

### Helmfile Diff

This workflow is triggered when a PR to the main branch is created or updated.
It uses helmfile diff to show the changes that would be applied if the PR is merged.

### Helmfile Apply

This workflow is triggered on the main branch after the [Docker Build and Push](#docker-build-and-push) workflow succeeds.
It installs the helm chart using the `helmfile`, and overrides the `image.tag` value with the short version of the git commit hash.

### Test Environments

This workflow is triggered manually, it uses kubectl to make a request to nginx using `curl` from the deployment's pod in stage and dev namespaces.

## Notes

I'm hosting everything on this same repository just to keep things simple for this test.
For a real-world scenario, I would separate the terraform code and the helm charts into their own repositories, and I would use a private docker registry to store the images.
For terraform itself I would seperate the modules into their own repositories.
The services deployed on AKS are not exposed outside the cluster on purpose, for a real-world scenario I would add an ingress controller and a public IP to access the services.
The quality of service used for the pods is `BestEffort`, since this AKS cluster is created just for this service and is not critical, I don't care about the pods being evicted or rescheduled. For production workloads I would go for `Guaranteed` or `Burstable` QoS.
