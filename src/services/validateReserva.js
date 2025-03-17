const connect = require("../db/connect");

module.exports = function validateReserva({
  dateStart,
  dateEnd,
  days,
  user,
  classroom,
  timeStart,
  timeEnd,
}) {
  if (
    !dateStart ||
    !dateEnd ||
    !days ||
    !user ||
    !classroom ||
    !timeStart ||
    !timeEnd
  ) {
    return res
      .status(400)
      .json({ error: "Todos os campos devem ser preenchidos" });
  }
};