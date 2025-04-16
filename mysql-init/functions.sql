delimiter $$

create function verifica_disponibilidade_sala(
    p_fk_number varchar(20),
    p_inicio DATETIME,
    p_fim DATETIME
)
returns varchar(20)
deterministic
reads sql data
begin
    declare disponivel int;

   select count(*)
    into disponivel
    from schedule
    where fk_number = p_fk_number
    and (
        (inicio_periodo < p_fim and fim_periodo > p_inicio)
    );

    if disponivel = 0 then
        return 'Sala disponível'; 
    else
        return 'Sala já reservada'; 
    end if;
end; $$

delimiter ;

-- para chamar a função
select verifica_disponibilidade_sala('B6', '2025-04-16 10:00:00', '2025-04-16 12:00:00') as disponivel;