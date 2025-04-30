delimiter $$

create function verifica_disponibilidade_sala(
    p_fk_number varchar(20),
    p_inicio datetime,
    p_fim datetime
) returns varchar(20)
deterministic
begin
    declare disponivel int;

    -- Verificar disponibilidade da sala
    select count(*)
    into disponivel
    from schedule
    where fk_number = p_fk_number
    and(
        (inicio_periodo < p_fim and fim_periodo > p_inicio)
    );

    -- Se não houver uma reserva
    if disponivel = 0 then
        return 'Sala disponível'; 
    else
        return 'Sala já reservada'; 
    end if;
end; $$

delimiter ;

select verifica_disponibilidade_sala('B6', '2025-04-25 14:00:00', '2025-04-25 14:30:00') as Disponibilidade;


DELIMITER $$

CREATE FUNCTION proxima_disponibilidade_sala(
    p_fk_number VARCHAR(20),
    p_a_partir DATETIME
) RETURNS DATETIME
DETERMINISTIC
BEGIN
    DECLARE proximo_horario DATETIME;

    -- Verifica o fim da última reserva após o horário especificado
    SELECT COALESCE(MAX(fim_periodo), p_a_partir)
    INTO proximo_horario
    FROM schedule
    WHERE fk_number = p_fk_number
      AND fim_periodo > p_a_partir;

    RETURN proximo_horario;
END $$

DELIMITER ;


-- Exemplo de uso:
select proxima_disponibilidade_sala('A3', '2025-02-20 14:00:00') as ProximaDisponibilidade;
