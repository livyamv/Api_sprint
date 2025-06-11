const connect = require("../db/connect");

module.exports = class cancelamentoController {
  //trigger
  static async cancelarSchedule(req, res) {
    const id = req.params.id;

    if (!id) {
      return res.status(400).json({ error: "Parâmetro id é obrigatório" });
    }

    connect.query(
      "DELETE FROM schedule WHERE id_schedule = ?",
      [id],
      (err, results) => {
        if (err) {
          console.error("Erro ao cancelar reserva:", err.message);
          return res.status(500).json({ error: err.message });
        }

        if (results.affectedRows === 0) {
          return res.status(404).json({ message: "Reserva não encontrada." });
        }

        return res.status(200).json({
          message: `Reserva com id ${id} cancelada com sucesso.`,
        });
      }
    );
  }
};
