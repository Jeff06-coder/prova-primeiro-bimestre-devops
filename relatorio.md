# Relatorio do Processo - Prova do Primeiro Bimestre (DevOps)

**Aluno:** Jefferson Camargo Coelho
**RA:** 6325120
**Disciplina:** DevOps - 2026.2
**Ferramenta de IA utilizada:** Kiro

---

## Questao 1 - A Jornada Completa (Aulas 01 a 07)

A jornada comecou pela base ensinada na Aula 01: versionamento com Git. Criei o repositorio `prova-primeiro-bimestre-devops` no GitHub e estabeleci um fluxo com feature branches e Conventional Commits (feat:, chore:, docs:, fix:), garantindo rastreabilidade desde o primeiro arquivo.

Com o repositorio estruturado, avancei para a aplicacao em si. A API de Reservas foi construida em Node.js com Express, implementando o CRUD completo do recurso `reservas` com persistencia em PostgreSQL via pacote `pg`. Todos os campos exigidos (id, cliente, data, status) foram modelados diretamente no banco, sem uso de memoria em runtime.

A Aula 01 tambem trouxe o Docker. Containerizei a API criando um Dockerfile multi-stage: o stage builder instala as dependencias de producao isoladamente e o stage runner copia apenas o necessario, rodando com um usuario sem privilegios (appuser). Isso resultou em uma imagem enxuta e segura.

A Aula 02 introduziu o Docker Compose. Com ele, orquestrei a API junto ao PostgreSQL em um unico docker-compose.yml, usando rede bridge customizada, volume nomeado para persistencia do banco, healthcheck no servico do postgres e depends_on com condition: service_healthy, garantindo que a API so sobe apos o banco estar pronto.

As Aulas 03 a 05 cobriram a infraestrutura AWS: VPC, EC2, RDS, Security Groups e o AWS Academy Learner Lab. Apliquei cada conceito: VPC com subnets publicas e privadas em duas AZs, EC2 na subnet publica com LabInstanceProfile, RDS PostgreSQL nas subnets privadas com publicly_accessible = false e storage_encrypted = true.

A Aula 06 fechou o ciclo com Terraform modularizado e Remote State. Criei quatro modulos independentes (vpc, security-group, ec2, rds), cada um com main.tf, variables.tf e outputs.tf. A composicao no main.tf raiz conecta os modulos passando outputs como inputs. O backend de state remoto usa S3 + DynamoDB em um diretorio separado (infra/backend/).

A Aula 07 tratou de IA como copiloto, documentada nas questoes seguintes.

