module.exports = async function validateCpf(cpf, userId){
const validateCpf = async (cpf, userId) => {
  return new Promise((resolve, reject) => {
    const query = `SELECT id_usuario FROM user WHERE cpf = ? AND id_usuario != ?`;

    connect.query(query, [cpf, userId], (err, results) => {
      if (err) return reject({ error: "Erro ao validar CPF" });

      if (results.length > 0) {
        resolve({ error: "CPF já cadastrado" });
      } else {
        resolve(null); // CPF OK
      }
    });
  });
};
}