pipeline {
  agent {
    docker {
      image 'jenkins-devsecops-agent'
      args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
  }

  environment {
    COSIGN_PASSWORD = credentials('cosign-pass')
  }

  stages {
    stage('Clone Repos') {
      steps {
        sh 'git clone https://github.com/azvmendes/segfin-frontend-secure frontend'
        sh 'git clone https://github.com/azvmendes/segfin-backend-secure backend'
      }
    }

    stage('Frontend Security') {
      steps {
        dir('frontend') {
          sh 'bearer scan . || true'
          sh 'gitleaks detect --source=. --report-format=json --report-path=gitleaks.json || true'
          sh 'syft . -o spdx-json > sbom.json || true'
        }
      }
    }

    stage('Backend Security') {
      steps {
        dir('backend') {
          sh 'bearer scan . || true'
          sh 'gitleaks detect --source=. --report-format=json --report-path=gitleaks.json || true'
          sh 'syft . -o spdx-json > sbom.json || true'
        }
      }
    }

    stage('Build and Scan Containers') {
      parallel {
        stage('Frontend Image') {
          steps {
            dir('frontend') {
              sh 'docker build -t segfin-frontend .'
              sh 'trivy image segfin-frontend --format json --output trivy.json || true'
              sh 'cosign sign --key cosign.key segfin-frontend'
            }
          }
        }
        stage('Backend Image') {
          steps {
            dir('backend') {
              sh 'docker build -t segfin-backend .'
              sh 'trivy image segfin-backend --format json --output trivy.json || true'
              sh 'cosign sign --key cosign.key segfin-backend'
            }
          }
        }
      }
    }

    stage('IaC Scan') {
      steps {
        sh 'checkov -d . --output json > checkov.json || true'
      }
    }

    stage('Deploy Staging + Falco') {
      steps {
        sh './deploy-staging.sh'
      }
    }

    stage('DAST - OWASP ZAP') {
      steps {
        sh 'zap-baseline.py -t http://localhost:8080 -r zap-report.html || true'
      }
    }
  }

  }
post {
  always {
    archiveArtifacts artifacts: '**/*.json, **/*.html', allowEmptyArchive: true
  }
}

