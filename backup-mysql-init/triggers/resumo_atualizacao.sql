CREATE TABLE resumo_atualizacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_schedule INT NOT NULL,
    descricao TEXT,
    periodo_antigo DATETIME,
    periodo_novo DATETIME,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_id INT,
    FOREIGN KEY (id_schedule) REFERENCES schedule(id_schedule)
);
