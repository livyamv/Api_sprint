delimiter //

create procedure total_reservas_usuario(
    in p_id_usuario int,   -- parâmetro de entrada
    out p_total int        -- parâmetro de saída - total de reservas do usuário
)
begin
    select count(*)     -- conta quantas reservas existem no banco 
    into p_total        -- armazena a soma das reservas
    from schedule
    where fk_id_usuario = p_id_usuario;  -- reservas que pertencem ao usuário informado como parâmetro
end; //

delimiter ;


call total_reservas_usuario(7, @total);
select @total as Total_de_reservas;
