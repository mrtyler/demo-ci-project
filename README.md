# Demo Exekube Project: demo-ci-project

An example cloud project built with the [Exekube framework](https://github.com/exekube/exekube)

> :warning:
> This is a work in progress
> :warning:

The exekube/demo-ci-project contains configuration for deploying a Kubernetes cluster onto the Google Cloud Platform (GCP), as well as Kubernetes resources (via Helm charts) that result in this software released into the cloud:

- A self-hosted CI / CD service (<https://concourse-ci.org>)
- A private Docker Registry (https://docs.docker.com/registry)
- A private ChartMuseum repository for hosting Helm charts (https://github.com/kubernetes-helm/chartmuseum)

## Project structure

The `live` directory contains configuration for every environment (dev, stg, prod) for this product.

```sh
├── live/
│   ├── dev/
│   ├── stg/
│   ├── prod/
│   ├── .env # variables common for every environment
│   └── terraform.tfvars # terraform config common to every environment
```

Every environment (dev, stg, test, prod, etc.) directory is further broken down into directories that contain resources (cloud resources) of these categories:

```sh
live/
├── dev/
│   ├── project/
│   ├── kubernetes/
│   ├── secrets/
│   ├── .env
│   └── ci.yaml # ci.yaml contains Concourse pipelines manifest
├── prod/
│   ├── project/
│   ├── kubernetes/
│   ├── secrets/
│   ├── .env
│   └── ci.yaml
```

| Configuration types for every environment] | What's in there? |
| --- | --- |
| `project` | ☁️ Cloud project resources, e.g. network, subnets, firewall rules, dns |
| `kubernetes` | ☸️ kube-api resources (via Helm releases) -- workloads, config, storage, and networking Kubernetes resources |
| `secrets` | 🔐 Secrets specific to this environment, stored and distributed via a GCS (Cloud Storage) buckets and encrypted by Google Cloud KMS encryption keys |
| `.env` | 🔩 Environment-specific variables common to several modules |


... to be continued ...
