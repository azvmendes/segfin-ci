FROM jenkins/jenkins:lts-jdk17

USER root

# Instalações base
RUN apt-get update && apt-get install -y \
    curl git unzip jq docker.io gnupg lsb-release software-properties-common python3-pip python3-venv \
    && apt-get clean

# Docker CLI
RUN curl -fsSL https://get.docker.com | bash

# Gitleaks
RUN curl -sSL https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks-linux-amd64 -o /usr/local/bin/gitleaks && \
    chmod +x /usr/local/bin/gitleaks

# Syft
RUN curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | bash -s -- -b /usr/local/bin

# Trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | bash -s -- -b /usr/local/bin

# Bearer
RUN curl -sfL https://raw.githubusercontent.com/Bearer/bearer/main/install.sh | bash -s -- -b /usr/local/bin

# Checkov
RUN pip install checkov --break-system-packages

# Cosign
RUN curl -sSL https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64 -o /usr/local/bin/cosign && \
    chmod +x /usr/local/bin/cosign

# OWASP ZAP CLI
RUN pip install python-owasp-zap-v2.4

USER jenkins
