const connect = require("../db/connect");
const validateSchedule = require("../services/validateSchedule");

module.exports = class scheduleController {
  static async createSchedule(req, res) {
    const { fk_id_usuario, descricao, inicio_periodo, fim_periodo, fk_number } =
      req.body;

    const validationError = validateSchedule(req.body);
    if (validationError) {
      return res.status(400).json(validationError);
    } else {
      const query = `SELECT * FROM schedule WHERE fk_number = ? 
      AND (
        (inicio_periodo < ? AND fim_periodo > ?) OR
        (inicio_periodo >= ? AND inicio_periodo < ?) OR
        (fim_periodo > ? AND fim_periodo <= ?)
      )`;

      const values = [
        fk_number,
        inicio_periodo,
        fim_periodo,
        inicio_periodo,
        fim_periodo,
        inicio_periodo,
        fim_periodo,
      ];

      try {
        const [existingSchedules] = await new Promise((resolve, reject) => {
          connect.query(query, values, (err, results) => {
            if (err) {
              reject("Erro ao verificar a disponibilidade da sala!");
            }
            resolve(results);
          });
        });

        if (existingSchedules && existingSchedules.length > 0) {
          return res
            .status(400)
            .json({ error: "A sala já está reservada nesse horário!" });
        }

        const insertQuery = `INSERT INTO schedule (fk_id_usuario, descricao, inicio_periodo, fim_periodo, fk_number) 
                           VALUES (?, ?, ?, ?, ?)`;

        const insertValues = [
          fk_id_usuario,
          descricao,
          inicio_periodo,
          fim_periodo,
          fk_number,
        ];

        connect.query(insertQuery, insertValues, (err) => {
          if (err) {
            console.log(err);
            return res
              .status(500)
              .json({ error: "Erro ao criar o agendamento!" });
          }
          return res
            .status(201)
            .json({ message: "Reserva criada com sucesso!" });
        });
      } catch (error) {
        return res.status(500).json({ error: error.message });
      }
    }
  }

  static async getAllSchedules(req, res) {
    const query = `SELECT * FROM schedule`;

    try {
      connect.query(query, function (err, results) {
        if (err) {
          console.error(err);
          return res.status(500).json({ error: "Erro interno do servidor" });
        }

        return res.status(200).json({
          message: "Todas as reservas",
          schedules: results,
        });
      });
    } catch (error) {
      console.error("Erro ao executar a consulta:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async getSalasSemReservas(req, res) {
    const query = `
      SELECT c.number
      FROM classroom c
      LEFT JOIN schedule s ON c.number = s.fk_number
      WHERE s.fk_number IS NULL;
    `;

    try {
      const results = await new Promise((resolve, reject) => {
        connect.query(query, (err, results) => {
          if (err) {
            return reject(err);
          }
          resolve(results);
        });
      });

      if (results.length === 0) {
        return res.status(404).json({
          message: "Não há salas disponíveis sem reservas.",
        });
      }

      return res.status(200).json({
        message: "Salas sem reservas",
        classrooms: results,
      });
    } catch (error) {
      console.error("Erro ao executar a consulta:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async updateSchedule(req, res) {
    const {
      id_schedule,
      fk_id_usuario,
      descricao,
      inicio_periodo,
      fim_periodo,
      fk_number,
    } = req.body;

    // Valida os campos do agendamento
    const validationError = validateSchedule(req.body);
    if (validationError) {
      return res.status(400).json(validationError);
    }

    const query = `UPDATE schedule SET fk_id_usuario = ?, descricao = ?, inicio_periodo = ?, fim_periodo = ?, fk_number = ? 
                   WHERE id_schedule = ?`;
    const values = [
      fk_id_usuario,
      descricao,
      inicio_periodo,
      fim_periodo,
      fk_number,
      id_schedule,
    ];

    try {
      connect.query(query, values, (err, results) => {
        if (err) {
          console.log(err);
          return res
            .status(500)
            .json({ error: "Erro ao atualizar o agendamento!" });
        }

        if (results.affectedRows === 0) {
          return res.status(404).json({ error: "Agendamento não encontrado!" });
        }

        return res
          .status(200)
          .json({ message: "Agendamento atualizado com sucesso!" });
      });
    } catch (error) {
      return res.status(500).json({ error });
    }
  }

  static async deleteSchedule(req, res) {
    const idSchedule = req.params.id;

    const query = `DELETE FROM schedule WHERE id_schedule = ?`;

    try {
      connect.query(query, idSchedule, (err, results) => {
        if (err) {
          console.log(err);
          return res.status(500).json({ error: "Erro ao excluir reserva!" });
        }

        if (results.affectedRows === 0) {
          return res.status(404).json({ error: "Reserva não encontrada!" });
        }

        return res
          .status(200)
          .json({ message: "Reserva excluída com sucesso!" });
      });
    } catch (error) {
      console.log("Erro ao executar a consulta!", error);
      return res.status(500).json({ error: "Erro interno do servidor!" });
    }
  }
};
