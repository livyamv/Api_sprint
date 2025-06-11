CREATE TABLE `historico_reserva` (
    `id_historico` INT AUTO_INCREMENT PRIMARY KEY,   
    `id_schedule` INT NOT NULL,                       
    `fk_id_usuario` INT NOT NULL,                     
    `fk_number` CHAR(5) NOT NULL,                    
    `descricao` VARCHAR(255),                         
    `inicio_periodo` DATETIME NOT NULL,               
    `fim_periodo` DATETIME NOT NULL,                  
    `data_reserva` DATETIME, 
    `data_exclusao` DATETIME DEFAULT CURRENT_TIMESTAMP 
);