const express = require('express');
const { Pool } = require('pg');

// ── Conexão com o banco ────────────────────────────────────────────────────────
const pool = new Pool({
  user:     process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  host:     process.env.DB_HOST,
  database: process.env.DB_NAME,
  port:     parseInt(process.env.DB_PORT || '5432', 10),
});

// ── Inicialização da tabela ────────────────────────────────────────────────────
async function initDB() {
  const createTableSQL = `
    CREATE TABLE IF NOT EXISTS reservas (
      id      SERIAL        PRIMARY KEY,
      cliente VARCHAR(255)  NOT NULL,
      data    DATE          NOT NULL,
      status  VARCHAR(50)   NOT NULL DEFAULT 'pendente'
    );
  `;
  await pool.query(createTableSQL);
  console.log('Tabela "reservas" verificada/criada com sucesso.');
}

// ── App Express ───────────────────────────────────────────────────────────────
const app = express();
app.use(express.json());

// GET /health — verifica conexão com o banco
app.get('/health', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({ status: 'ok', database: 'connected' });
  } catch (err) {
    res.status(503).json({ status: 'error', message: err.message });
  }
});

// POST /reservas — cria uma reserva
app.post('/reservas', async (req, res) => {
  const { cliente, data, status } = req.body;

  if (!cliente || !data) {
    return res.status(400).json({ error: 'Os campos "cliente" e "data" são obrigatórios.' });
  }

  try {
    const result = await pool.query(
      `INSERT INTO reservas (cliente, data, status)
       VALUES ($1, $2, $3)
       RETURNING *`,
      [cliente, data, status || 'pendente']
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET /reservas — lista todas as reservas
app.get('/reservas', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM reservas ORDER BY id ASC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET /reservas/:id — busca reserva por ID
app.get('/reservas/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query('SELECT * FROM reservas WHERE id = $1', [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Reserva não encontrada.' });
    }

    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// PUT /reservas/:id — atualiza uma reserva
app.put('/reservas/:id', async (req, res) => {
  const { id } = req.params;
  const { cliente, data, status } = req.body;

  if (!cliente || !data || !status) {
    return res.status(400).json({ error: 'Os campos "cliente", "data" e "status" são obrigatórios.' });
  }

  try {
    const result = await pool.query(
      `UPDATE reservas
       SET cliente = $1, data = $2, status = $3
       WHERE id = $4
       RETURNING *`,
      [cliente, data, status, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Reserva não encontrada.' });
    }

    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// DELETE /reservas/:id — remove uma reserva
app.delete('/reservas/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query(
      'DELETE FROM reservas WHERE id = $1 RETURNING *',
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Reserva não encontrada.' });
    }

    res.status(204).send();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── Inicialização do servidor ─────────────────────────────────────────────────
const PORT = process.env.PORT || 3000;

initDB()
  .then(() => {
    app.listen(PORT, () => {
      console.log(`Servidor rodando na porta ${PORT}`);
    });
  })
  .catch((err) => {
    console.error('Falha ao inicializar o banco de dados:', err.message);
    process.exit(1);
  });
