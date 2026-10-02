# Registro de Uso do Kiro - Prova TechNova

**Ferramenta utilizada:** Kiro

### Fase 1: Geração da API Node.js (CRUD)
- **Prompt enviado:** Atue como um Desenvolvedor Sênior Node.js. Crie uma API com Express.js que gerencia um CRUD completo de 'reservas' (id, cliente, data, status). A API DEVE se conectar a um banco de dados PostgreSQL usando o pacote 'pg' e ler as credenciais de variáveis de ambiente (DB_USER, DB_PASSWORD, DB_HOST, DB_NAME, DB_PORT).

Requisitos:

Rota POST /reservas (cria uma reserva)

Rota GET /reservas (lista todas)

Rota GET /reservas/:id (busca por ID)

Rota PUT /reservas/:id (atualiza)

Rota DELETE /reservas/:id (deleta)

Rota GET /health (healthcheck, faz um SELECT 1 no banco)

Uma função que roda ao iniciar a API para criar a tabela 'reservas' caso não exista.
Me entregue APENAS o código do 'package.json' e do 'src/index.js'.
- **O que a IA gerou bem:** Fez tudo como pedido
- **O que precisei corrigir:**

### Fase 2: Geração do Dockerfile e Compose
- **Prompt enviado:** Agora crie a infraestrutura local Docker para essa API.
Preciso de 3 arquivos:
Um 'Dockerfile' na raiz da pasta app/, usando a imagem node:20-alpine. Deve ser multi-stage (builder e runner), não deve rodar como root (crie um usuário) e expor a porta 3000.
Um '.dockerignore' adequado.
Um 'docker-compose.yml' na raiz do projeto contendo 2 serviços: 'api' (fazendo build do Dockerfile) e 'postgres' (imagem postgres:15-alpine). O banco precisa de um volume nomeado para persistência. Use variáveis de ambiente via .env. Configure healthcheck no banco de dados e um depends_on na API esperando o banco ficar saudável. Ambos devem estar em uma rede bridge customizada.
- **O que a IA gerou bem:** Código corretamente desenvolvido
- **O que precisei corrigir:** Tive que mudar as dependências no Dockerfile

### Fase 3: Geração do Terraform (Infraestrutura)
- **Prompt enviado:** [Vou colar o prompt 3 aqui]
- **O que a IA gerou bem:** [Ex: Criou os módulos certinhos]
- **O que precisei corrigir:** [Ex: Esqueceu de usar o LabRole]