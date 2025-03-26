module.exports = function validateSchedule({
  fk_id_usuario,
  descricao,
  inicio_periodo,
  fim_periodo,
  fk_number,
}) {
  // Verifica se todos os campos obrigatórios foram preenchidos
  if (
    !fk_id_usuario ||
    !descricao ||
    !inicio_periodo ||
    !fim_periodo ||
    !fk_number
  ) {
    return { error: "Todos os campos devem ser preenchidos" };
  }

  // Verifica se as datas de início e fim são válidas
  const startDate = new Date(inicio_periodo);
  const endDate = new Date(fim_periodo);

  if (isNaN(startDate.getTime()) || isNaN(endDate.getTime())) {
    return { error: "Datas inválidas" };
  }
  // Verifica se a datahora_fim é maior que a datahora_inicio
  else if (endDate.getTime() <= startDate.getTime()) {
    return { error: "Data ou Hora Inválida" };
  }
  // Verifica se a duração da reserva excede 1 hora
  else if (endDate - startDate > 60 * 60 * 1000) {
    // 1 hora em milissegundos
    return { error: "O tempo de Reserva excede o limite (1h)" };
  }

  // Se tudo estiver correto, retorna null
  return null;
};
