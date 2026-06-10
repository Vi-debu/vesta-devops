# Vesta API – DevOps Tools & Cloud Computing

## Integrantes

- Vinícius da Silva Bitú – RM 560227
- Gabriel Cruz Ferreira – RM 559613
- João Victor Madella – RM 561007
- Kauã Ferreira dos Santos – RM 560992
- Nathália Mantovani – RM 559904

---

# 1. Descrição da Solução

O Vesta é uma aplicação desenvolvida em Java utilizando Spring Boot com o objetivo de auxiliar instituições de acolhimento no gerenciamento de usuários, famílias, abrigos e recursos.

A solução permite o controle dos recursos disponíveis em cada abrigo, mantendo as informações armazenadas em banco de dados Oracle.

Para automatizar os processos de integração e entrega contínua, foi utilizada a plataforma Azure DevOps, integrando Azure Repos, Azure Boards e Azure Pipelines.

---

# 2. Arquitetura da Solução

## Arquitetura Geral

```text
GitHub
(Repositório de Código)
      │
      ▼
Azure Repos
      │
      ▼
Azure Pipeline (CI)
Build Maven e geração do artefato
      │
      ▼
Azure Pipeline (CD)
Deploy automatizado
      │
      ▼
Azure Web App
(Java 21 + Spring Boot)
      │
      ▼
Oracle Database
(Banco de Dados)
      ▲
      │
Usuário
(Postman / Swagger)
```

## Fluxo de Execução

1. O desenvolvedor realiza alterações no código.
2. O código é enviado para o repositório.
3. O Azure Pipelines inicia automaticamente a execução da pipeline.
4. O Maven realiza a compilação da aplicação.
5. O artefato é gerado.
6. O deploy é realizado no Azure Web App.
7. A API fica disponível para acesso.
8. Os dados são persistidos no Oracle Database.

---

# 3. Recursos Provisionados em Nuvem

Todos os recursos foram criados através do Azure CLI.

## Resource Group

```bash
az group create \
--name rg-vesta \
--location brazilsouth
```

## App Service Plan

```bash
az appservice plan create \
--name plan-vesta \
--resource-group rg-vesta \
--sku B1 \
--is-linux
```

## Azure Web App

```bash
az webapp create \
--resource-group rg-vesta \
--plan plan-vesta \
--name vestags \
--runtime "JAVA:17-java17"
```

---

# 4. Ferramentas Utilizadas

- Azure DevOps
- Azure Boards
- Azure Repos
- Azure Pipelines
- Azure CLI
- GitHub
- Java 21
- Spring Boot
- Maven
- Oracle Database
- Azure App Service
- Swagger
- Postman

---

# 5. Estrutura do Projeto

```text
vesta-api
│
├── src
│   ├── main
│   ├── resources
│   └── test
│
├── pom.xml
├── azure-pipelines.yml
└── README.md
```

---

# 6. Pipeline CI/CD

## Integração Contínua (CI)

- Download do código-fonte
- Restauração das dependências Maven
- Compilação da aplicação
- Execução do build
- Geração do artefato

## Entrega Contínua (CD)

- Download do artefato
- Publicação da aplicação
- Deploy no Azure Web App
- Disponibilização da API

---

# 7. Banco de Dados

O projeto utiliza Oracle Database para armazenamento das informações da aplicação.

## Principais Entidades

### TB_REGIAO
Armazena as regiões atendidas pelo sistema.

### TB_INSTITUICAO
Representa órgãos e instituições responsáveis pelos abrigos.

### TB_PERFIL_ACESSO
Controla os perfis de acesso dos usuários.

### TB_ABRIGO
Armazena os dados dos abrigos cadastrados.

### TB_USUARIO
Responsável pelo cadastro e autenticação dos usuários.

### TB_FAMILIA
Armazena as famílias atendidas pelos abrigos.

### TB_PESSOA_ABRIGADA
Controla as pessoas vinculadas às famílias acolhidas.

### TB_RECURSO
Armazena os recursos disponíveis para utilização nos abrigos.

### TB_ESTOQUE_ABRIGO
Controla a quantidade de recursos disponíveis em cada abrigo.

### TB_OCORRENCIA
Registra ocorrências operacionais e situações reportadas pelos usuários.

### TB_SOLICITACAO_RECURSO
Controla solicitações de recursos realizadas pelos abrigos.

### TB_MOVIMENTACAO_RECURSO
Registra entradas, saídas e ajustes de estoque.

### TB_TRANSFERENCIA_ABRIGO
Controla transferências de famílias entre abrigos.

### TB_ALERTA
Armazena alertas automáticos gerados pelo sistema.

---

# 8. Relacionamentos

## Estrutura Principal

```text
TB_REGIAO
    │
    ├── TB_INSTITUICAO
    │
    └── TB_ABRIGO
            │
            ├── TB_USUARIO
            │
            ├── TB_FAMILIA
            │       │
            │       └── TB_PESSOA_ABRIGADA
            │
            ├── TB_ESTOQUE_ABRIGO
            │       │
            │       └── TB_RECURSO
            │
            ├── TB_OCORRENCIA
            │
            ├── TB_SOLICITACAO_RECURSO
            │
            └── TB_ALERTA
```

## Relacionamento utilizado na demonstração

```text
TB_ABRIGO
      │
      └── TB_ESTOQUE_ABRIGO
                    │
                    └── TB_RECURSO
```

Esse relacionamento permite controlar os recursos disponíveis em cada abrigo e a quantidade existente em estoque.
---

# 9. Exemplos de CRUD em JSON

## Cadastro de Abrigo

### POST /abrigos

```json
{
  "nmAbrigo": "Abrigo Esperança",
  "dsEndereco": "Rua das Flores, 100",
  "qtCapacidadeMaxima": 80,
  "idRegiao": 1,
  "idInstituicao": 1
}
```

## Cadastro de Usuário

### POST /usuarios

```json
{
  "nmUsuario": "Administrador",
  "dsEmail": "admin@vesta.com",
  "idPerfil": 1,
  "idAbrigo": 1
}
```

## Cadastro de Recurso

### POST /recursos

```json
{
  "nmRecurso": "Cesta Básica",
  "tpRecurso": "ALIMENTO",
  "dsUnidadeMedida": "UNIDADE"
}
```

## Consulta

### GET /abrigos

```http
GET /abrigos
```

## Atualização

### PUT /estoques/1

```json
{
  "qtAtual": 50
}
```

## Exclusão

### DELETE /recursos/1

```http
DELETE /recursos/1
```

---

# 10. Comandos SQL Utilizados nos Testes

## Inserção

```sql
INSERT INTO TB_ABRIGO (NOME, ENDERECO, CAPACIDADE)
VALUES ('Abrigo Esperança', 'Rua das Flores, 100', 80);
```

## Consulta

```sql
SELECT * FROM TB_ABRIGO;
```

## Atualização

```sql
UPDATE TB_ESTOQUE_ABRIGO
SET QUANTIDADE = 50
WHERE ID_ESTOQUE = 1;
```

## Exclusão

```sql
DELETE FROM TB_ESTOQUE_ABRIGO
WHERE ID_ESTOQUE = 1;
```

---

# 11. Execução Local

## Clonar Repositório

```bash
git clone https://github.com/Vi-debu/vesta-devops.git
```

## Acessar Projeto

```bash
cd vesta-api
```

## Executar Aplicação

```bash
mvn spring-boot:run
```

---

# 12. Resultado Obtido

Com a implementação realizada foi possível:

- Automatizar o processo de build da aplicação.
- Gerar artefatos através do Azure Pipelines.
- Publicar a aplicação em um Azure Web App.
- Disponibilizar a API para acesso externo.
- Realizar testes através do Swagger e Postman.
- Persistir dados em Oracle Database.
- Integrar Azure Repos, Azure Boards e Azure Pipelines.

---

## Disciplina

DevOps Tools & Cloud Computing

## Curso

Análise e Desenvolvimento de Sistemas – FIAP

## Ano

2026
