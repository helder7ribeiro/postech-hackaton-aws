# Módulo RDS - Frames

Este módulo Terraform provisiona recursos RDS (Relational Database Service) para o projeto Frame Extractor.

## Recursos Provisionados

- **AWS DB Instance**: Instância PostgreSQL RDS
- **AWS DB Subnet Group**: Grupo de subnets para o RDS

## Configuração

### Variáveis Obrigatórias

- `vpc_id`: ID da VPC onde o RDS será criado
- `db_username`: Nome de usuário para o banco de dados
- `db_password`: Senha para o banco de dados (sensível)
- `db_name`: Nome do banco de dados
- `vpc_security_group_ids`: Lista de IDs dos security groups

### Variáveis Opcionais

- `db_subnet_group_name`: Nome do subnet group (padrão: "updown-subnet-group")

## Uso

```bash
cd RDS
terraform init
terraform plan
terraform apply
```

## Especificações da Instância

- **Engine**: PostgreSQL 17.4
- **Instance Class**: db.t3.micro (Free Tier)
- **Storage**: 20 GB
- **Public Access**: Habilitado
- **Skip Final Snapshot**: Habilitado (para facilitar destruição) 