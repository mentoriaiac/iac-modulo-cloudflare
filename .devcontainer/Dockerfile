# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.163.1/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

ARG TERRAFORM_VERSION
ARG TFSEC_VERSION

ENV TERRAFORM_VERSION=0.14.8
ENV TFSEC_VERSION=0.38.4

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    make

RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"  && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv  terraform /bin/terraform

RUN curl -Lso tfsec https://github.com/tfsec/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64 && \
    chmod +x tfsec && \
    mv tfsec /bin/tfsec