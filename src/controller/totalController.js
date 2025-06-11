const connect = require("../db/connect");

module.exports = class totalController {
  //procedure
  static async totalReservasUsuario(req, res) {
    const id = req.params.id;

    if (!id) {
      return res.status(400).json({ error: "Parâmetro id é obrigatório" });
    }

    connect.query("CALL total_reservas_usuario(?, @total);", [id], (err) => {
      if (err) {
        console.error("Erro ao chamar procedure total_reservas_usuario:", err.message);
        return res.status(500).json({ error: err.message });
      }

      connect.query("SELECT @total as total_reservas;", (err2, results2) => {
        if (err2) {
          console.error("Erro ao obter total de reservas:", err2.message);
          return res.status(500).json({ error: err2.message });
        }

        const totalReservas = results2[0].total_reservas;

        return res.status(200).json({
          message: `Total de reservas para o usuário ${id} obtido com sucesso`,
          total_reservas: totalReservas,
        });
      });
    });
  }
};
