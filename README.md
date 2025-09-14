# Hackaton - AWS

Projeto de infraestrutura como código para o sistema de extração de frames na AWS.

## Estrutura do Projeto

O projeto está organizado em dois módulos principais:

### EKS (Elastic Kubernetes Service)
- **Localização**: `EKS/`
- **Descrição**: Configuração do cluster Kubernetes na AWS
- **Arquivos principais**:
  - `main.tf` - Recursos do EKS
  - `variables.tf` - Variáveis de configuração
  - `backend.tf` - Configuração do backend do Terraform

### RDS (Relational Database Service)
- **Localização**: `RDS/`
- **Descrição**: Configuração do banco de dados PostgreSQL
- **Arquivos principais**:
  - `main.tf` - Recursos do RDS
  - `variables.tf` - Variáveis de configuração
  - `backend.tf` - Configuração do backend do Terraform

## Workflows

### Workflow EKS
- **Arquivo**: `.github/workflows/eks-deploy.yml`
- **Função**: Deploy automático do cluster EKS
- **Trigger**: Push para branch `main` em diretório `EKS/`

### Workflow RDS
- **Arquivo**: `.github/workflows/rds-deploy.yml`
- **Função**: Deploy automático do banco RDS
- **Trigger**: Push para branch `main` em diretório `RDS/`

## Secrets Necessárias

Para que os workflows funcionem corretamente, as seguintes secrets devem ser configuradas no repositório GitHub:

### AWS Credentials
- `AWS_ACCESS_KEY_ID` - Access Key ID da AWS
- `AWS_SECRET_ACCESS_KEY` - Secret Access Key da AWS
- `AWS_SESSION_TOKEN` - Session Token da AWS (necessário para AWS Academy)
- `AWS_REGION` - Região da AWS (ex: us-east-1)

### Terraform Backend
- `TF_VAR_backend_bucket` - Nome do bucket S3 para armazenar o estado do Terraform
- `TF_VAR_backend_key` - Chave do arquivo de estado no bucket S3
- `TF_VAR_backend_region` - Região do bucket S3

### RDS (apenas para workflow RDS)
- `TF_VAR_db_password` - Senha do banco de dados PostgreSQL
- `TF_VAR_db_username` - Usuário do banco de dados PostgreSQL

## Configuração das Secrets

1. Acesse o repositório no GitHub
2. Vá em **Settings** > **Secrets and variables** > **Actions**
3. Clique em **New repository secret**
4. Adicione cada secret listada acima com seus respectivos valores

## Ordem de Deploy

1. **RDS**: Deploy primeiro para criar o banco de dados
2. **EKS**: Deploy depois para criar o cluster Kubernetes

Os workflows são independentes e podem ser executados separadamente conforme necessário. 