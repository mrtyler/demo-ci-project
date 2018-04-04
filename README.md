# Demo Exekube Project: demo-ci-project

An example cloud project built with the [Exekube framework](https://github.com/exekube/exekube)

> :warning:
>
> This is a work in progress
>
> :warning:

Helm releases:

- A Concourse server -- self-hosted CI / CD service (<https://concourse-ci.org>)
- A private Docker Registry (https://docs.docker.com/registry)
- A private ChartMuseum repository for hosting Helm charts (https://github.com/kubernetes-helm/chartmuseum)

## Project directory structure

The `live` directory contains configuration for every environment (dev, stg, prod) for this product.

```sh
├── live/
│   ├── dev/
│   ├── stg/
│   ├── prod/
│   ├── .env # Common TF_VARs -- variables shared by multiple modules
│   └── terraform.tfvars # Terraform / Terragrunt config for modules (e.g. remote state config)
```

Every environment (dev, stg, test, prod, etc.) directory is further broken down into directories that contain resources (cloud resources) of these categories:

```sh
live/
├── dev/
│   ├── project/
│   ├── kubernetes/
│   ├── secrets/
│   ├── .env
│   └── ci.yaml
├── stg/
│   ├── project/
│   ├── kubernetes/
│   ├── secrets/
│   ├── .env
│   └── ci.yaml
├── prod/
│   ...
```

Explore the directory structure (https://github.com/exekube/demo-ci-project/tree/master/live/dev) and use this table for reference:

| Configuration types for every environment | What's in there? |
| --- | --- |
| `project` | ☁️ Google Cloud resources, e.g. project settings, network, subnets, firewall rules, DNS |
| `kubernetes` | ☸️ GKE cluster configuration, Kubernetes API resources and Helm release configuration |
| `secrets` | 🔐 Secrets specific to this environment, stored and distributed in GCS (Cloud Storage) buckets and encrypted by Google Cloud KMS encryption keys |
| `.env` | 🔩 Environment-specific variables common to several modules |
| `ci.yaml` | ✈️ Concourse pipeline [manifest for CI pipelines](https://github.com/concourse/concourse-pipeline-resource#dynamic) |


# Tutorial

## Prerequisites

- You'll need a Google Account with access to an [Organization resource](https://cloud.google.com/resource-manager/docs/quickstart-organizations)
- On your workstation, you'll need to have [Docker Community Edition](https://www.docker.com/community-edition) installed

# Getting started

## Get Exekube and a demo project

First, clone the project Git repo:

```sh
git clone https://github.com/exekube/demo-ci-project
cd demo-ci-project
```

## Configure project files

The meat of any project developed with Exekube is declarative code expressed as:

- `TF_VAR_*` environmental variables common to multiple Terraform modules or
- `*.tfvars` files that contain module-specific variables

<!---

### Global .env file

> This is used only for bootstrapping a [Google Cloud Platform project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) for every (dev, staging, testing, production) environment via the [project-init script](https://github.com/exekube/exekube/blob/master/modules/scripts/project-init)

```sh
# live/.env
ORGANIZATION_ID=889071810646
BILLING_ID=01A70D-9FAAFB-40FF75
```

-->

### Environment-specific .env file

Variables starting with `TF_VAR` can be accessed by multiple Terraform module. We do this to avoid repeating input variables in `.tfvars` files.

```sh
# live/dev/.env
TF_VAR_project_id=dev-demo-ci-296e23 # MODIFY!
TF_VAR_serviceaccount_key=/project/live/dev/secrets/kube-system/owner.json # /project/ is a directory inside of a Docker container!
TF_VAR_default_dir=/project/live/dev/kubernetes
TF_VAR_secrets_dir=/project/live/dev/secrets
TF_VAR_keyring_name=keyring
```

### Terraform and Terragrunt module configuration

1. ☁️ First, we configure the `gcp-project` module in `live/dev/project/terraform.tfvars`.
    - [gcp-project module API reference](https://github.com/exekube/exekube/blob/master/modules/gcp-project/variables.tf): module for enabling APIs for the GCP project, configuring networking, firewall rules, external IP addresses, DNS, etc.


2. ☸️ Second, we create and administer a GKE cluster via `live/dev/kubernetes` directory:
    - [helm-initializer module API reference](https://github.com/exekube/exekube/tree/master/modules/helm-initializer): module for generating TLS certificates and keys for Helm and Tiller and running `helm init`
    - [helm-release module API reference](https://github.com/exekube/exekube/blob/master/modules/helm-release/variables.tf): module for installing a generic Helm chart

3. 🔐 Manage secrets securely:

    - [gcp-kms-secret-mgmt module API reference](https://github.com/exekube/exekube/tree/master/modules/gcp-kms-secret-mgmt): module for storing / distributing secrets in GSC buckets and encrypting them transparently via Cloud KMS encryption keys
    - ...

# Workflow

## Bootstrap a GCP Project for use with Terraform

```sh
alias xk='docker-compose run --rm exekube'
export ENV=dev
export ORGANIZATION_ID=889071810646
export BILLING_ID=01A70D-9FAAFB-40FF75
```

We are now ready to create a GCP project for our dev environment. This is done via a script ([source](https://github.com/exekube/exekube/blob/master/modules/scripts/project-init)):

```diff
xk project-init
...
+ Finished successfully!
```

The script will do this:

- Create a GCP project with the `$TF_VAR_project_id` ID we specified earlier
- Create a GCP Service Account for use with Terraform, give it project owner permissions, and download its JSON-encoded key to the path at `$TF_VAR_serviceaccount_key`
- Create a GCS bucket for Terraform remote state, named `$TF_VAR_project_id-tfstate`

## Manage GCP resources (live/dev/project) declaratively

We can use Terraform + Terragrunt from here

First, we apply the [gcp-project](https://github.com/exekube/exekube/tree/master/modules/gcp-project) module, which will:

- Enable GCP APIs for the project
- Set up networking for our Kubernetes cluser
- Create firewall rules
- Create static IP addresses
- DNS zones and records, etc.

```sh
xk up live/dev/project
```

These resources cost very little compared to running GCE instances (GKE worker nodes), so we keep them created at all times for all (including non-production) environments.

## Manage Kubernetes & Helm resources (live/dev/kubernetes) declaratively

We can now create the cluster and create all Kubernetes resources via one command
(under the hood `xk up` calls `cd $TF_VAR_default_dir & terragrunt apply-all`):

```sh
xk up
```

All configuration is declarative, so just change the code live `live/dev/kubernetes/**` and run `xk up` to refresh the cluster's state. You can also create, upgrade, or destroy single modules or namespaces by specifying a path after `xk up` or `xk destroy`:

```sh
xk up live/dev/kubernetes/kube-system/ingress-controller/
xk down live/dev/kubernetes/kube-system/ingress-controller/

xk up live/dev/kubernetes/team1
xk down live/dev/kubernetes/team1
```

Once you've tested everything, just

```sh
xk down
```

to destroy all Kubernetes (and Helm) resources and then destroy the cluster.

These resources are highly ephemeral in non-production environments, meanining that you can `xk up` and `xk down` several times per day / per hour. GCE running instances are quite expensive (especially for more intensive workloads), so we only keep them running when needed.

# Contributions

Contributions are welcome!
