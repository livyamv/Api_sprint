const connect = require("../db/connect");

module.exports = function validateClassroom({ number, description, capacity }) {
//Validar campos obrigatórios
  if (!number || !description || !capacity) {
    return res
      .status(400)
      .json({ error: "Todos os campos devem ser preenchidos" });
  }
}
