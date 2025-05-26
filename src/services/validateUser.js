const connect = require("../db/connect");

module.exports = function validateUser({
    name,
    cpf,
    email,
    password,
  }) {
    if (!name || !cpf || !email || !password) {
      return { error: "Todos os campos devem ser preenchidos" };
    }
  
    if (isNaN(cpf) || cpf.length !== 11) {
      return {
        error: "CPF inválido. Deve conter exatamente 11 dígitos numéricos",
      };
    }
  
    if (!email.includes("@")) {
      return { error: "Email inválido. Deve conter @" };
    }
  
    // Retorna null se não houver erro
    return null; 
  };
  
  