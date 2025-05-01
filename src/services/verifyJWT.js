const jwt = require("jsonwebtoken");

function verifyJWT(req, res, next) {
  const token = req.headers["authorization"]; //verificado com a SECRET definida no .env

  if (!token) {
    return res
      .status(401)
      .json({ auth: false, message: "Token não foi fornecido" });
  }

  jwt.verify(token, process.env.SECRET, (err, decoded) => {
    if (err) {
      return res
        .status(403)
        .json({ auth: false, message: "Falha na autenticação do Token" });
    }
    req.userId = decoded.id; //o id do token é recuperado e armazenado no req (para saber se o usuário está autenticado)
    next(); // para continuar a requisição
  });
}
module.exports = verifyJWT;