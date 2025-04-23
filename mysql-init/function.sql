DELIMITER $$

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