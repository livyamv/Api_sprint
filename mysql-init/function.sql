delimiter $$

create function verifica_disponibilidade_sala(
    p_fk_number varchar(20),
    p_inicio datetime,
    p_fim datetime
) returns varchar(20)
deterministic   -- dada a mesma entrada, a função sempre retorna o mesmo resultado
begin
    declare disponivel int;

    -- Verificar disponibilidade da sala
    select count(*) -- conta quantas reservas existem e aramzena o resultado na variavel 'disponivel'
    into disponivel
    from schedule
    where fk_number = p_fk_number -- reservas da sala informada como parâmetro
    and(
        (inicio_periodo < p_fim and fim_periodo > p_inicio) --verifica se o período da nova reserva se sobrepõe a alguma reserva existente
    );

    -- Se não houver uma reserva
    if disponivel = 0 then
        return 'Sala disponível'; 
    else
        return 'Sala já reservada'; 
    end if;
end; $$

delimiter ;

select verifica_disponibilidade_sala('A2', '2025-05-05 08:30:00', '2025-05-05 09:30:00') as Disponibilidade;