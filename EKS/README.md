# Infraestrutura EKS com Terraform

Este projeto implementa a infraestrutura de um cluster EKS (Elastic Kubernetes Service) na AWS utilizando Terraform.

## Estrutura do Projeto

```
.
├── .github/
│   └── workflows/
│       └── terraform.yml    # Pipeline de CI/CD
├── main.tf                  # Configuração principal do EKS
├── variables.tf            # Definição das variáveis 
├── backend.tf              # Configuração do backend S3
└── provider.tf             # Configuração do provider AWS
```

## Pré-requisitos

- Terraform >= 1.8.3
- Conta AWS com permissões adequadas
- Bucket S3 para armazenamento do state file
- Tabela DynamoDB para lock state
- VPC existente na AWS

## Variáveis Necessárias

### Variáveis do Terraform
- `vpc_id`: ID da VPC onde o EKS será criado
- `iam_role_arn`: ARN da IAM Role para ser usada pelo EKS

### Secrets do GitHub
- `AWS_ACCESS_KEY_ID`: Access Key da AWS
- `AWS_SECRET_ACCESS_KEY`: Secret Key da AWS
- `AWS_SESSION_TOKEN`: Token de sessão da AWS (se necessário)
- `VPC_ID`: ID da VPC
- `IAM_ROLE_ARN`: ARN da IAM Role
- `TERRAFORM_BUCKET`: Nome do bucket S3 para armazenamento do state

## Recursos Criados

- Cluster EKS
- Node Group com as seguintes configurações:
  - Tipo de instância: t3.medium
  - Tamanho mínimo: 1
  - Tamanho desejado: 2
  - Tamanho máximo: 3
  - Subnets: Selecionadas automaticamente em diferentes zonas de disponibilidade

## Pipeline CI/CD

O projeto inclui um pipeline CI/CD configurado no GitHub Actions que:
1. Inicializa o Terraform
2. Valida a configuração
3. Aplica as mudanças automaticamente

## Como Usar

1. Configure as secrets necessárias no GitHub:
   ```bash
   AWS_ACCESS_KEY_ID
   AWS_SECRET_ACCESS_KEY
   AWS_SESSION_TOKEN
   VPC_ID
   IAM_ROLE_ARN
   TERRAFORM_BUCKET
   ```

2. Faça push para a branch main para iniciar o pipeline:
   ```bash
   git push origin main
   ```

## Segurança

- Todas as credenciais sensíveis são armazenadas como secrets no GitHub
- O state file é armazenado em um bucket S3 com versionamento
- Lock state é implementado usando DynamoDB para evitar conflitos de concorrência

## Manutenção

Para modificar a infraestrutura:
1. Faça as alterações necessárias nos arquivos .tf
2. Faça commit das mudanças
3. O pipeline irá automaticamente aplicar as alterações

## Limpeza

Para destruir a infraestrutura:
1. Execute `terraform destroy` localmente
2. Ou adicione um job de destroy no pipeline (não recomendado para produção)

## Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Faça commit das mudanças (`git commit -m 'Adiciona nova feature'`)
4. Faça push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request
