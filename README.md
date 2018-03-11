# Internal Ops Project

This example project uses the [Exekube framework](https://github.com/exekube/exekube).

The **Internal Ops Project** contains configuration for deploying a Kubernetes cluster onto the Google Kubernetes Engine (GKE), as well as Kubernetes resources that result in this software released into the cloud:

- CI / CD self-hosted service (✈️ Concourse, Jenkins, or Drone)
- A private 🐳 Docker Registry (v2)
- A 📋 ChartMuseum repository for hosting Helm charts

## Project structure

The `live` directory contains configuration for every environment (dev, stg, test, prod) for this product. The `live/terraform.tf` directory contains Terraform / Terragrunt configuration common for every environment.

```
├── live
│   ├── dev
│   ├── stg
│   ├── test
│   ├── prod
│   └── terraform.tfvars
```

## Environment (product environment) configuration

Every environment (dev, stg, test, prod) directory is broken down into resources (cloud resources) of these categories: **project, cluster, releases, secrets**:

```
live/
├── prod
│   ├── cluster
│   │   └── terraform.tfvars
│   ├── releases
│   │   ├── chartmuseum
│   │   │   ├── terraform.tfvars
│   │   │   └── values.yaml
│   │   ├── concourse
│   │   │   ├── terraform.tfvars
│   │   │   └── values.yaml
│   │   ├── docker-registry
│   │   │   ├── terraform.tfvars
│   │   │   └── values.yaml
│   │   ├── ingress-controller
│   │   │   ├── terraform.tfvars
│   │   │   └── values.yaml
│   │   └── kube-lego
│   │       ├── terraform.tfvars
│   │       └── values.yaml
│   └── secrets
│       ├── chartmuseum
│       │   ├── basic-auth-password
│       │   └── basic-auth-username
│       ├── ci
│       │   ├── apps-pipelines.yaml
│       │   ├── common.yaml
│       │   ├── forms-app-pipeline.yaml
│       │   └── rails-react-boilerplate.yaml
│       ├── concourse
│       │   ├── basic-auth-password
│       │   ├── basic-auth-username
│       │   ├── encryption-key
│       │   ├── github-auth-client-id
│       │   ├── github-auth-client-secret
│       │   ├── host-key
│       │   ├── host-key-pub
│       │   ├── old-encryption-key
│       │   ├── postgresql-user
│       │   ├── session-signing-key
│       │   ├── vault-ca-cert
│       │   ├── vault-client-token
│       │   ├── worker-key
│       │   └── worker-key-pub
│       ├── dashboard-rbac.yaml
│       ├── docker-registry
│       │   ├── basic-auth-password
│       │   └── basic-auth-username
│       ├── letsencrypt.yaml
│       └── sa
│           └── owner.json
├── stg
└── terraform.tfvars

15 directories, 37 files
```
... to be continued ...
