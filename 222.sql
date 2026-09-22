CREATE DATABASE IF NOT EXISTS academia_SL;
-- seleciona o banco
USE academia_SL;

CREATE TABLE IF NOT EXISTS usuario(
	id BIGINT primary key auto_increment,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha_hash VARCHAR(150) NOT NULL,
    telefone VARCHAR(30),
    ativo BOOLEAN DEFAULT TRUE,
    ultimo_login DATETIME,
    criado_em TIMESTAMP,
    atualizado_em TIMESTAMP
);
CREATE TABLE IF NOT EXISTS personal(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    usuario_id BIGINT NOT NULL,
    cref VARCHAR(50) NULL,
    especialidade VARCHAR(150) NULL,
    biografia VARCHAR(250) NULL,
    link_rede_social VARCHAR(150) NULL,
    criado_em TIMESTAMP,
    atualizado_em TIMESTAMP,
    CONSTRAINT fk_personal_usuario
	FOREIGN KEY (usuario_id) references usuario(id)
);
CREATE TABLE IF NOT EXISTS aluno(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    usuario_id BIGINT NOT NULL,
    personal_id 	BIGINT NOT NULL,
    CONSTRAINT fk_aluno_usuario FOREIGN KEY (usuario_id) references usuario(id),
    CONSTRAINT fk_aluno_personal FOREIGN KEY (personal_id) references personal(id),
    data_nascimento DATE NOT NULL,
    sexo VARCHAR(9) CHECK(SEXO IN('MASCULINO','FEMININO','OUTRO')) NOT NULL,
    objetivo_principal VARCHAR(200) NULL,
    observacao VARCHAR(256) NULL,
    data_inicio DATE NULL,
    ativo BOOLEAN DEFAULT TRUE,
	criado_em TIMESTAMP,
    atualizado_em TIMESTAMP
    );
CREATE TABLE IF NOT EXISTS treino(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    aluno_id BIGINT NOT NULL,
    personal_id BIGINT NOT NULL,
    CONSTRAINT fk_treino_aluno FOREIGN KEY(aluno_id) references usuario(id),
    CONSTRAINT fk_treino_personal FOREIGN KEY(personal_id) references personal(id),
    nome_treino VARCHAR(150) NOT NULL,
    descricao VARCHAR(250) NULL,
    objetivo VARCHAR(200) NULL,
    data_inicio DATE,
    data_fim DATE,
    ativo BOOLEAN DEFAULT TRUE,
	criado_em TIMESTAMP,
    atualizado_em TIMESTAMP
);
CREATE TABLE IF NOT EXISTS grupo_muscular(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nome_grupo VARCHAR(50) UNIQUE
);
CREATE TABLE IF NOT EXISTS equipamento(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nome_equipamento VARCHAR(50) UNIQUE
);
CREATE TABLE IF NOT EXISTS exercicio(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    grupo_muscular_id BIGINT NOT NULL,
    equipamento_id BIGINT NOT NULL,
    personal_id BIGINT NOT NULL,
    CONSTRAINT fk_exe_grupoMuscular FOREIGN KEY(grupo_muscular_id) references grupo_muscular(id),
	CONSTRAINT fk_exe_equipamento FOREIGN KEY(equipamento_id) references equipamento(id),
    nome_exercicio VARCHAR(150) NOT NULL,
    CONSTRAINT exe_criado_por FOREIGN Key (personal_id)references personal(id),
    instrucao VARCHAR(50),
    ativo BOOLEAN DEFAULT TRUE,
    criado_em TIMESTAMP,
    atualizado_em TIMESTAMP
);
CREATE TABLE IF NOT EXISTS treino_dia(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    treino_id BIGINT NOT NULL,
    exercicio_id BIGINT NOT NULL,
	CONSTRAINT fk_treinoDia_treino FOREIGN KEY (treino_id) references treino(id),
    CONSTRAINT fk_treinoDia_exercicio FOREIGN KEY (exercicio_id) references exercicio(id),
    ordem_treino INT NOT NULL,
    intervalo INT NULL,
    criado_em TIMESTAMP,
    atualizado_em TIMESTAMP
    
);
CREATE TABLE IF NOT EXISTS treino_exercicio(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    treino_dia_id BIGINT NOT NULL,
    exercicio_id BIGINT NOT NULL,
    CONSTRAINT fk_treinoExercicio_treinoDia FOREIGN KEY (treino_dia_id) references treino_dia(id),
    CONSTRAINT fk_treinoExercicio_exercicio FOREIGN KEY (exercicio_id) references exercicio(id),
    ordem INT NOT NULL,
    repeticao INT NOT NULL,
    repeticao_max INT NOT NULL,
    observacao VARCHAR(250) NULL,
    criado_em TIMESTAMP,
    atualizado_em TIMESTAMP
);

INSERT INTO  usuario (nome, email, senha_hash, telefone, criado_em) VALUES ('Marco Aurélio','diogo.professor96@gmail.com','$2a$12$D1CMGMKVsWKaNqvb69iliuLkJdpGJ4V0mudT0fjtDtK3316t6E7xK','92000735','2026/09/22'), 
('Feliperson Antonio vitto navas','marcosouzavitto11@gmail.com','$2a$12$tcZ819.ChnvqQIZnD71c3OUWU3qEqD/RXkAXgENGOkcfTQx9KpDPu','199996767','2026/09/22'), 
('Tom Halland colleman','tomholland@email','$2a$12$Co19J7GlVsGRFrRYgYQqHupafCyonBpEaZLKLIvDNA0exM2N9.Ziy','4188867775','2026/09/22');

INSERT INTO personal (usuario_id, cref, especialidade,biografia, link_rede_social, criado_em) VALUES (1, '676767-G/PR','estetica corporal','não tem','MarcoAurelio_personal','2026/09/22');
SELECT * FROM grupo_muscular;

INSERT INTO aluno(personal_id,usuario_id, data_nascimento, sexo, objetivo_principal, observacao, criado_em, data_inicio, nivel) VALUES ('1','1','2009/10/19','masculino','shaipe','tendao etorado','2026/09/22','2026/09/22','iniciante'),
('1','2','2000/03/30','feminino','não tem','não tem','2026/09/22','2026/09/22','intermediario');

INSERT INTO grupo_muscular (nome_grupo) VALUES ('Peitoral'), 
('Dorsais'),
('Quadríceps e Posteriores'), 
('Deltoides'),
('Bíceps e Tríceps'),
('Abdômen');

INSERT INTO equipamento (grupo_muscular_id, nome_equipamento) VALUES ('1','Banco de Supino'),
('2','Puxada Alta'),
('3','Leg Press'),
('4','Elevação Lateral'),
('5','Máquina de Rosca Articulada'),
('6','Roda Abdominal');
INSERT INTO exercicio (nivel) VALUES ('INICIANTE');
INSERT criado_por

