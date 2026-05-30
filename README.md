[README.md](https://github.com/user-attachments/files/28427895/README.md)

 Loja Veloz – Plataforma de Pedidos em Microsserviços

> Entrega contínua: do Docker Compose ao Kubernetes com Observabilidade e CI/CD  
> Trabalho acadêmico – Cloud DevOps | UniFECAF

---

Vídeo Pitch

▶️ [Assista no YouTube](https://youtu.be/SEU_LINK_AQUI)

---

Arquitetura

```
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
```

Serviços

| Serviço | Porta | Tecnologia |
|---|---|---|
| API Gateway | 8080 | Nginx |
| Serviço de Pedidos | 3001 | Python/FastAPI |
| Serviço de Pagamentos | 3002 | Python/FastAPI |
| Serviço de Estoque | 3003 | Python/FastAPI |
| PostgreSQL | 5432 | PostgreSQL 15 |
| Prometheus | 9090 | Prometheus |
| Grafana | 3000 | Grafana |

---

Ambiente Local (Docker Compose)

Pré-requisitos

- Docker >= 24.x
- Docker Compose >= 2.x

Subindo o ambiente

```bash
# 1. Clone o repositório
git clone https://github.com/SEU_USUARIO/loja-veloz-devops.git
cd loja-veloz-devops

# 2. Configure variáveis de ambiente
cp .env.example .env

# 3. Suba todos os serviços com um único comando
docker compose up -d

# 4. Verifique se todos estão rodando
docker compose ps
```

Endpoints locais

| Serviço | URL |
|---|---|
| API Gateway | http://localhost:8080 |
| Pedidos API | http://localhost:3001/docs |
| Pagamentos API | http://localhost:3002/docs |
| Estoque API | http://localhost:3003/docs |
| Grafana | http://localhost:3000 (admin/admin) |
| Prometheus | http://localhost:9090 |

---

Kubernetes – Deploy em Produção

Pré-requisitos

- kubectl configurado
- Acesso ao cluster (EKS, GKE ou Minikube)

```bash
# Criar namespace
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
```

---

CI/CD – GitHub Actions

O pipeline executa automaticamente a cada push:

1. **CI** (`ci.yml`): lint → testes → build da imagem → scan de segurança
2. **CD** (`cd.yml`): push para registry → deploy no Kubernetes (rolling update)

---

Observabilidade

- **Métricas**: Prometheus + Grafana
- **Logs**: stdout/stderr → coleta centralizada
- **Tracing**: OpenTelemetry (instrumentação nos serviços)

---

IaC – Terraform

```bash
cd terraform/
terraform init
terraform plan
terraform apply
```

---

Estrutura do Repositório

```
loja-veloz-devops/
├── services/          # Código-fonte e Dockerfiles de cada microsserviço
├── k8s/               # Manifests Kubernetes
├── .github/workflows/ # Pipelines CI/CD
├── terraform/         # Infraestrutura como Código
└── docs/              # Documentação técnica
```

---

Referências

- [Documentação Kubernetes](https://kubernetes.io/docs/)
- [Docker Compose Reference](https://docs.docker.com/compose/)
- [12-Factor App](https://12factor.net/)
- [OpenTelemetry](https://opentelemetry.io/)
- [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Google Online Boutique (referência de microsserviços)](https://github.com/GoogleCloudPlatform/microservices-demo)
