DELIMITER $$

CREATE TRIGGER cancelamento_reserva
BEFORE DELETE ON schedule
FOR EACH ROW
BEGIN
  INSERT INTO historico_reserva (
    id_schedule,
    fk_id_usuario,
    fk_number,
    descricao,
    inicio_periodo,
    fim_periodo,
    data_reserva,
    data_exclusao
  ) VALUES (
    OLD.id_schedule,
    OLD.fk_id_usuario,
    OLD.fk_number,
    OLD.descricao,
    OLD.inicio_periodo,
    OLD.fim_periodo,
    NOW(),
    NOW()
  );
END$$

DELIMITER ;


-- teste
DELETE FROM schedule WHERE id_schedule = 8;

-- verifica se a trigger funcionou
select * from historico_reserva;
