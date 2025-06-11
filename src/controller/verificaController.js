const connect = require("../db/connect");

module.exports = class disponibilidadeController {
  //function
  static async verificarDisponibilidade(req, res) {
    const { fk_number, inicio, fim } = req.body;

    // Validação dos parâmetros
    if (!fk_number || !inicio || !fim) {
      return res.status(400).json({ error: "Campos fk_number, inicio e fim são obrigatórios." });
    }

    const query = "SELECT verifica_disponibilidade_sala(?, ?, ?) AS disponibilidade";

    connect.query(query, [fk_number, inicio, fim], (err, results) => {
      if (err) {
        console.error("Erro ao chamar função verifica_disponibilidade_sala:", err.message);
        return res.status(500).json({ error: err.message });
      }

      return res.status(200).json({
        message: "Verificação realizada com sucesso",
        sala: fk_number,
        periodo: { inicio, fim },
        disponibilidade: results[0].disponibilidade,
      });
    });
  }
};
