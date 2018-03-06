# Internal Ops Project

This example project uses the [Exekube framework](https://github.com/exekube/exekube).

## Features

- Creates a Kubernetes cluster on Google Cloud using the Google Kubernetes Engine (GKE)
- Bootstraps the cluster with CI services, installing the following Helm charts:
    - nginx-ingress
    - kube-lego
    - concourse
    - docker-registry
    - chartmuseum
