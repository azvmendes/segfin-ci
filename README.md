# Segfin CI - DevSecOps Pipeline

Este repositório orquestra o pipeline seguro de CI/CD para os projetos:
- Frontend: [segfin-frontend-vulnerable](https://github.com/azvmendes/segfin-frontend-secure)
- Backend: [segfin-backend-vulnerable](https://github.com/azvmendes/segfin-backend-secure)

Inclui:
- SAST, SCA, SBOM
- Scan de secrets, containers e IaC
- Assinatura de imagens
- Deploy em staging
- Monitoramento (Falco)
- Testes DAST com OWASP ZAP
