# Deploy-verktyg: kubectl, sops, yq, jq och envsubst ovanpå aws-cli.
# Taggen anger kubectl-versionen.
FROM docker.io/amazon/aws-cli:2.36.46

ARG KUBECTL_VERSION=v1.33.13
ARG SOPS_VERSION=v3.13.3
ARG YQ_VERSION=v4.53.6

RUN dnf install -y jq gettext tar gzip git diffutils && dnf clean all

RUN curl -fsSLo /usr/local/bin/kubectl "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
 && echo "$(curl -fsSL https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256)  /usr/local/bin/kubectl" | sha256sum -c - \
 && chmod +x /usr/local/bin/kubectl

RUN curl -fsSLo /usr/local/bin/sops "https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.amd64" \
 && curl -fsSL "https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.checksums.txt" \
    | grep " sops-${SOPS_VERSION}.linux.amd64$" | awk '{print $1"  /usr/local/bin/sops"}' | sha256sum -c - \
 && chmod +x /usr/local/bin/sops

RUN curl -fsSLo /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" \
 && chmod +x /usr/local/bin/yq

ENTRYPOINT []
CMD ["/bin/bash"]
