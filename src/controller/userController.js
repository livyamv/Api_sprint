const connect = require("../db/connect");
const jwt = require("jsonwebtoken");
const validateUser = require("../services/validateUser");
const validateCpf = require("../services/validateCpf");
const bcrypt = require("bcrypt");
const SALT_ROUNDS = 10;  

module.exports = class userController {
  static async createUser(req, res) {
    const { name, cpf, email, password } = req.body;

    const validationError = validateUser(req.body);
    if (validationError) {
      return res.status(400).json(validationError);
    }

    try {
      const cpfError = await validateCpf(cpf);
      if (cpfError) {
        return res.status(400).json(cpfError);
      }

      const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS);

      const query = `INSERT INTO user (name, cpf, email, password) VALUES (?, ?, ?, ?)`;
      
      connect.query(query, [name, cpf, email, hashedPassword], (err) => {
        console.log(err);
        if (err) {
          if (err.code === "ER_DUP_ENTRY") {            
            if (err.message.includes("for key 'user.email'")) {
              return res.status(400).json({ error: "Email já cadastrado" });
            }
          } else {
            return res
              .status(500)
              .json({ error: "Erro interno do servidor", err });
          }
        }
        return res.status(201).json({ message: "Usuário criado com sucesso" });
      });
    } catch (error) {
      return res.status(500).json({ error });
    }
  }
  static async getAllUsers(req, res) {
    const query = `SELECT * FROM user`;

    try {
      connect.query(query, function (err, results) {
        if (err) {
          console.error(err);
          return res.status(500).json({ error: "Erro interno do servidor" });
        }

        return res
          .status(200)
          .json({ message: "Obtendo todos os usuários", users: results });
      });
    } catch (error) {
      console.error("Erro ao executar a consulta:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async getUserById(req, res) {
    const userId = req.params.id;
  
    const query = `SELECT name, email, cpf, password FROM user WHERE id_usuario = ?`;
  
    connect.query(query, [userId], (err, results) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ error: "Erro ao buscar usuário" });
      }
  
      if (results.length === 0) {
        return res.status(404).json({ error: "Usuário não encontrado" });
      }
  
      return res.status(200).json({
        message: "Dados do usuário",
        user: results[0],
      });
    });
  }
  
  static async updateUser(req, res) {
    const { name, cpf, email, password } = req.body;
    const id = req.params.id;
      
    // Agora a validação aceita atualização sem senha
    const validationError = validateUser({ name, cpf, email}, true);
    if (validationError) {
      return res.status(400).json(validationError);
    }
  
    try {
      const cpfError = await validateCpf(cpf);
      if (cpfError) {
        return res.status(400).json(cpfError);
      }
  
      let hashedPassword = null;
      if (password) {
        const bcrypt = require("bcrypt");
        hashedPassword = await bcrypt.hash(password, 10);
      }
  
      const query = `
        UPDATE \`user\` 
        SET name = ?, cpf = ?, email = ?${password ? ", password = ?" : ""}
        WHERE id_usuario = ?
      `;
  
      const values = password
        ? [name, cpf, email, hashedPassword, id]
        : [name, cpf, email, id];
  
      connect.query(query, values, (err, results) => {
        if (err) {
          return res.status(500).json({ error: "Erro interno do servidor" });
        }
  
        if (results.affectedRows === 0) {
          return res.status(404).json({ error: "Usuário não encontrado" });
        }
  
        return res.status(200).json({ message: "Usuário atualizado com sucesso" });
      });
    } catch (error) {
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async deleteUser(req, res) {
    const userId = req.params.id;
    const query = `DELETE FROM user WHERE id_usuario = ?`;
    const values = [userId];

    try {
      connect.query(query, values, function (err, results) {
        if (err) {
          console.error(err);
          return res.status(500).json({ error: "Erro interno do servidor" });
        }

        if (results.affectedRows === 0) {
          return res.status(404).json({ error: "Usuário não encontrado" });
        }

        return res
          .status(200)
          .json({ message: "Usuário excluído com ID: " + userId });
      });
    } catch (error) {
      console.error("Erro ao executar a consulta:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }
  
  static async loginUser(req, res) {
    const { cpf, password } = req.body;

    if (!cpf || !password) {
      return res.status(400).json({ error: "CPF e senha são obrigatórios" });
    }

    const query = `SELECT * FROM user WHERE cpf = ?`;

    try {
      connect.query(query, [cpf], (err, results) => {
        if (err) {
          console.error("Erro ao executar a consulta:", err);
          return res.status(500).json({ error: "Erro interno do servidor --- try" });
        }

        if (results.length === 0) {
          return res.status(401).json({ error: "Usuário não encontrado" });
        }

        const user = results[0];

        //Comparar a senha enviada na requisição com o hash do banco
        const passwordOK =  bcrypt.compareSync(password, user.password);

        if (!passwordOK) {
          return res.status(401).json({ error: "Senha incorreta" });
        }

        const token = jwt.sign({ id: user.id_usuario }, process.env.SECRET, { //(payload:id_user - dado que é guardado), secret, options
          expiresIn: "1h", //o token ira expirar em uma hora
        });

        // Remove um atributo de um objeto
        delete user.password;

        return res.status(200).json({
          message: "Login bem-sucedido",
          user,
          token,
        });

      });
    } catch (error) {
      console.error("Erro ao executar a consulta:", error);
      return res.status(500).json({ error: "Erro interno do servidor --- catch" });
    }
  }
};