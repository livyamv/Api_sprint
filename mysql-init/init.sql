-- Criação do banco de dados
CREATE DATABASE agenda_senai;

USE agenda_senai;

-- Criação da tabela `classroom`
CREATE TABLE `classroom` (
  `number` char(5) NOT NULL,
  `description` varchar(255) NOT NULL,
  `capacity` int(11) NOT NULL,
  PRIMARY KEY (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dados para a tabela `classroom`
INSERT INTO `classroom` (`number`, `description`, `capacity`) VALUES
('A1', 'CONVERSORES', 16),
('A2', 'ELETRÔNICA', 16),
('A3', 'CLP', 16),
('A4', 'AUTOMAÇÃO', 20),
('A5', 'METROLOGIA', 16),
('A6', 'PNEUMÁTICA/HIDRÁULICA', 20),
('COEL', 'OFICINA DE COMANDOS ELÉTRICOS', 16),
('ITEL1', 'OFICINA DE INSTALAÇÕES ELÉTRICAS - G1', 16),
('ITEL2', 'OFICINA DE INSTALAÇÕES ELÉTRICAS - G2', 16),
('TOR', 'OFICINA DE TORNEARIA', 20),
('AJFR', 'OFICINA DE AJUSTAGEM/FRESAGEM', 16),
('CNC', 'OFICINA DE CNC', 16),
('MMC', 'OFICINA DE MANUTENÇÃO MECÂNICA', 16),
('SOLD', 'OFICINA DE SOLDAGEM', 16),
('B2', 'SALA DE AULA', 32),
('B3', 'SALA DE AULA', 32),
('B5', 'SALA DE AULA', 40),
('B6', 'SALA DE AULA', 32),
('B7', 'SALA DE AULA', 32),
('B8', 'LAB. INFORMÁTICA', 20),
('B9', 'LAB. INFORMÁTICA', 16),
('B10', 'LAB. INFORMÁTICA', 16),
('B11', 'LAB. INFORMÁTICA', 40),
('B12', 'LAB. INFORMÁTICA', 40),
('ALI', 'LAB. ALIMENTOS', 16),
('C1', 'SALA DE AULA', 24),
('C2', 'LAB. DE INFORMÁTICA', 32),
('C3', 'SALA DE MODELAGEM VESTUÁRIO', 20),
('C4', 'SALA DE MODELAGEM VESTUÁRIO', 20),
('C5', 'SALA DE AULA', 16),
('VEST', 'OFICINA DE VESTUÁRIO', 20),
('MPESP', 'OFICINA DE MANUTENÇÃO PESPONTO', 16),
('AUTO', 'OFICINA DE MANUTENÇÃO AUTOMOTIVA', 20),
('D1', 'SALA MODELAGEM', 16),
('D2', 'SALA DE MODELAGEM', 20),
('D3', 'SALA DE AULA', 16),
('D4', 'SALA DE CRIAÇÃO', 18),
('CORT1', 'OFICINA DE CORTE - G1', 16),
('CORT2', 'OFICINA DE CORTE - G2', 16),
('PRE', 'OFICINA DE PREPARAÇÃO', 16),
('PESP1', 'OFICINA DE PESPONTO - G1', 16),
('PESP2', 'OFICINA DE PESPONTO - G2', 16),
('PESP3', 'OFICINA DE PESPONTO - G3', 16),
('MONT1', 'OFICINA DE MONTAGEM - G1', 16),
('MONT2', 'OFICINA DE MONTAGEM - G2', 16);

-- Criação da tabela `user`
CREATE TABLE `user` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `cpf_UNIQUE` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Dados para a tabela `user`
INSERT INTO `user` (`name`, `cpf`, `email`, `password`) VALUES
('Livia', '12345680091', 'livia@gmail.com', '12345678'),
('Ana Clara', '67644444444', 'ana@gmail.com', '09876543'),
('Maria Clara', '12345660091', 'maria@gmail.com', '09090909');

-- Criação da tabela `schedule`
CREATE TABLE `schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateStart` date NOT NULL,
  `dateEnd` date NOT NULL,
  `days` varchar(255) NOT NULL,
  `user` char(11) NOT NULL,
  `classroom` char(5) NOT NULL,
  `timeStart` time NOT NULL,
  `timeEnd` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `classroom`(`classroom`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`cpf`),
  CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`classroom`) REFERENCES `classroom` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Inserção de dados fictícios para a tabela `schedule`
INSERT INTO `schedule` (`dateStart`, `dateEnd`, `days`, `user`, `classroom`, `timeStart`, `timeEnd`) VALUES
('2025-03-10', '2025-03-10', 'Segunda, Quarta, Sexta', '12345680091', 'A1', '08:00:00', '10:00:00'),
('2025-03-11', '2025-03-11', 'Terça, Quinta', '67644444444', 'B2', '10:00:00', '12:00:00'),
('2025-03-12', '2025-03-12', 'Segunda a Sexta', '12345660091', 'C1', '14:00:00', '16:00:00');

-- Comando para garantir que o AUTO_INCREMENT da tabela `schedule` está corretamente configurado
ALTER TABLE `schedule` AUTO_INCREMENT = 44;

COMMIT;
