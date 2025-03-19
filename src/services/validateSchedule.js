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
  if (!dateStart || !dateEnd || !days || !user || !classroom || !timeStart || !timeEnd) {
    return { error: "Todos os campos devem ser preenchidos" };
  }

  const isWithinTimeRange = (time) => {
    const [hours, minutes] = time.split(":").map(Number);
    const totalMinutes = hours * 60 + minutes;
    return totalMinutes >= 7.5 * 60 && totalMinutes <= 23 * 60;
  };

  if (!isWithinTimeRange(timeStart) || !isWithinTimeRange(timeEnd)) {
    return { error: "A sala de aula só pode ser reservada dentro do intervalo de 7:30 às 23:00" };
  }
};
