DELIMITER $$

CREATE FUNCTION verifica_disponibilidade_sala(
    p_fk_number VARCHAR(20),
    p_inicio DATETIME,
    p_fim DATETIME
) RETURNS VARCHAR(20)
NOT DETERMINISTIC   -- pode retornar resultados diferentes se os dados mudarem
READS SQL DATA
BEGIN
    DECLARE disponivel INT;

    -- Verificar se há sobreposição com outras reservas da mesma sala
    SELECT COUNT(*) 
    INTO disponivel
    FROM schedule
    WHERE fk_number = p_fk_number 
      AND (
        inicio_periodo < p_fim AND fim_periodo > p_inicio
      );

    IF disponivel = 0 THEN
        RETURN 'Sala disponível'; 
    ELSE
        RETURN 'Sala reservada'; 
    END IF;
END $$

DELIMITER ;


select verifica_disponibilidade_sala('A2', '2025-05-05 08:30:00', '2025-05-05 09:30:00') as Disponibilidade;
