Loja Veloz – Plataforma de Pedidos em Microsserviços

Entrega contínua: do Docker Compose ao Kubernetes com Observabilidade e CI/CD
Trabalho acadêmico – Cloud DevOps | UniFECAF


Vídeo Pitch
LINKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK

Arquitetura
                        ┌─────────────────┐
         Internet ──▶   │   API Gateway   │
                        └────────┬────────┘
                                 │
           ┌─────────────────────┼─────────────────────┐
           ▼                     ▼                     ▼
    ┌─────────────┐      ┌──────────────┐     ┌──────────────┐
    │   Pedidos   │      │  Pagamentos  │     │   Estoque    │
    └──────┬──────┘      └──────────────┘     └──────────────┘
           │
           ▼
    ┌─────────────┐
    │  PostgreSQL │
    └─────────────┘
Serviços
ServiçoPortaTecnologiaAPI Gateway8080NginxServiço de Pedidos3001Python/FastAPIServiço de Pagamentos3002Python/FastAPIServiço de Estoque3003Python/FastAPIPostgreSQL5432PostgreSQL 15Prometheus9090PrometheusGrafana3000Grafana

Ambiente Local (Docker Compose)
Pré-requisitos

Docker >= 24.x
Docker Compose >= 2.x

Subindo o ambiente
bash# 1. Clone o repositório
git clone https://github.com/SEU_USUARIO/loja-veloz-devops.git
cd loja-veloz-devops

# 2. Configure variáveis de ambiente
cp .env.example .env

# 3. Suba todos os serviços com um único comando
docker compose up -d

# 4. Verifique se todos estão rodando
docker compose ps
Endpoints locais
ServiçoURLAPI Gatewayhttp://localhost:8080Pedidos APIhttp://localhost:3001/docsPagamentos APIhttp://localhost:3002/docsEstoque APIhttp://localhost:3003/docsGrafanahttp://localhost:3000 (admin/admin)Prometheushttp://localhost:9090

Kubernetes – Deploy em Produção
Pré-requisitos

kubectl configurado
Acesso ao cluster (EKS, GKE ou Minikube)

bash# Criar namespace
kubectl apply -f k8s/namespace.yaml

# Aplicar ConfigMaps e Secrets
kubectl apply -f k8s/configmaps/
kubectl apply -f k8s/secrets/

# Deploy dos serviços
kubectl apply -f k8s/api-gateway/
kubectl apply -f k8s/pedidos/
kubectl apply -f k8s/pagamentos/
kubectl apply -f k8s/estoque/

# Verificar pods
kubectl get pods -n loja-veloz

CI/CD – GitHub Actions
O pipeline executa automaticamente a cada push:

CI (ci.yml): lint → testes → build da imagem → scan de segurança
CD (cd.yml): push para registry → deploy no Kubernetes (rolling update)


Observabilidade

Métricas: Prometheus + Grafana
Logs: stdout/stderr → coleta centralizada
Tracing: OpenTelemetry (instrumentação nos serviços)


IaC – Terraform
bashcd terraform/
terraform init
terraform plan
terraform apply

Estrutura do Repositório
loja-veloz-devops/
├── services/          # Código-fonte e Dockerfiles de cada microsserviço
├── k8s/               # Manifests Kubernetes
├── .github/workflows/ # Pipelines CI/CD
├── terraform/         # Infraestrutura como Código
└── docs/              # Documentação técnica

Referências

Documentação Kubernetes
Docker Compose Reference
12-Factor App
OpenTelemetry
Terraform Docs
GitHub Actions
Google Online Boutique (referência de microsserviços)
