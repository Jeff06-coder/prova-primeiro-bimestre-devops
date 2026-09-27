# ── Stage 1: builder ──────────────────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

# Copia apenas os arquivos de manifesto para aproveitar o cache de camadas
COPY src/package.json src/package-lock.json* ./

# Instala somente as dependências de produção
RUN npm install --omit=dev

# ── Stage 2: runner ───────────────────────────────────────────────────────────
FROM node:20-alpine AS runner

# Cria um usuário e grupo sem privilégios de root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copia os node_modules já instalados do stage anterior
COPY --from=builder /app/node_modules ./node_modules

# Copia o código-fonte da aplicação
COPY src/ ./src/

# Transfere a propriedade dos arquivos para o usuário não-root
RUN chown -R appuser:appgroup /app

# Alterna para o usuário sem privilégios
USER appuser

EXPOSE 3000

CMD ["node", "src/index.js"]
