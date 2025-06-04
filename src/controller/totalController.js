const connect = require("../db/connect");

module.exports = class totalController {
  static async getTotalSchedulePorUsuario(req, res) {
    const id_usuario = req.params.id;

    if (!id_usuario) {
      return res.status(400).json({ error: "ID do usuário é obrigatório!" });
    }

    connect.getConnection((err, connection) => {
      if (err) {
        console.error("Erro ao obter conexão:", err);
        return res.status(500).json({ error: "Erro ao obter conexão com o banco de dados." });
      }

      // Chamada da procedure com dois parâmetros: id e variável de saída
      connection.query("CALL total_reservas_usuario(?, @total);", [parseInt(id_usuario)], (err) => {
        if (err) {
          connection.release();
          console.error("Erro ao executar procedure:", err);
          return res.status(500).json({ error: "Erro ao executar procedure." });
        }

        // Consulta a variável de saída
        connection.query("SELECT @total AS total;", (err, results) => {
          connection.release();

          if (err) {
            console.error("Erro ao buscar resultado:", err);
            return res.status(500).json({ error: "Erro ao buscar resultado." });
          }

          const total = results[0]?.total ?? 0;
          return res.status(200).json({ total });
        });
      });
    });
  }
};
