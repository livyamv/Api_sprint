DELIMITER //

CREATE TRIGGER atualizacao_reserva
AFTER UPDATE ON schedule
FOR EACH ROW
BEGIN
    DECLARE v_id_schedule INT;

    -- Pegando o ID do agendamento (schedule) para garantir a correção
    SET v_id_schedule = OLD.id_schedule;

    -- Insere uma nova linha na tabela resumo_atualizacao com as informações da atualização
    INSERT INTO resumo_atualizacao (
        id_schedule, 
        descricao, 
        periodo_antigo, 
        periodo_novo, 
        usuario_id
    ) 
    VALUES (
        v_id_schedule, 
        CONCAT('Descrição alterada de "', OLD.descricao, '" para "', NEW.descricao, '"'),  -- Descrição detalhada da alteração
        OLD.inicio_periodo, 
        NEW.inicio_periodo, 
        NEW.fk_id_usuario
    );
END //

DELIMITER ;


--teste

UPDATE schedule 
SET descricao = 'Sala teste', inicio_periodo = '2025-06-10 16:00:00', fim_periodo = '2025-06-10 17:00:00'
WHERE id_schedule = 21;

SELECT * FROM resumo_atualizacao;
