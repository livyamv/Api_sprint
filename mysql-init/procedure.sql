delimiter //

create procedure total_reservas_usuario(
    in p_id_usuario int,
    out p_total int
)
begin
    select count(*)
    into p_total
    from schedule
    where fk_id_usuario = p_id_usuario;
end; //

delimiter ;

call total_reservas_usuario(8, @total);  
select @total as Total_de_reservas;
