const express = require('express')
const cors = require('cors');
require("dotenv-safe").config(); //Solicita o dotenv - verifica se os arquivos ".env" e ".env.example" estão iguais
const jwt = require("jsonwebtoken"); //Carregando as configurações do jsonwebtoken
const testConnect = require('./db/testeConnect')

class AppController {
    constructor() {
      this.express = express();
      this.middlewares();
      this.routes();
      testConnect();
    }

    middlewares() {
      this.express.use(express.json());
      this.express.use(cors());
    }

    routes() {
      const apiRoutes= require('./routes/apiRoutes');
      this.express.use('/api/reservas/v1/', apiRoutes);
      //http://localhost:5000/api/reservas/v1
    }
  }

  module.exports = new AppController().express;