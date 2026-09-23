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
    sexo VARCHAR(9) CHECK(SEXO IN('masculino','feminino','outro')) NOT NULL,
    nivel VARCHAR(13) CHECK(nivel in('iniciante','intermediario','avancado')),
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
    CONSTRAINT fk_treino_aluno FOREIGN KEY(aluno_id) references aluno(id),
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
    grupo_muscular_id BIGINT NOT NULL,
    CONSTRAINT fk_grupo_muscular FOREIGN KEY(grupo_muscular_id) references grupo_muscular(id),
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
    nivel VARCHAR(13) CHECK(nivel in('facil','intermediario','dificil')),
    CONSTRAINT exe_criado_por FOREIGN Key (personal_id)references personal(id),
    instrucao VARCHAR(250),
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
    nome VARCHAR(100) NOT NULL,
    ordem_treino INT NOT NULL,
    criado_em TIMESTAMP
    
);

CREATE TABLE IF NOT EXISTS treino_exercicio(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    treino_dia_id BIGINT NOT NULL,
    exercicio_id BIGINT NOT NULL,
    CONSTRAINT fk_treinoExercicio_treinoDia FOREIGN KEY (treino_dia_id) references treino_dia(id),
    CONSTRAINT fk_treinoExercicio_exercicio FOREIGN KEY (exercicio_id) references exercicio(id),
    ordem INT NOT NULL DEFAULT 1,
    carga_sugerida DECIMAL(8,2),
    unidade_carga VARCHAR(13) CHECK(unidade_carga IN ('kg', 'lb', 'peso_corporal')),
	descanso INT,
    repeticao INT NOT NULL,
    repeticao_max INT NOT NULL,
    observacao VARCHAR(250) NULL,
    criado_em TIMESTAMP,
    atualizado_em TIMESTAMP
);


INSERT INTO  usuario (nome, email, senha_hash, telefone, criado_em) VALUES ('Marco Aurélio','diogo.professor96@gmail.com','$2a$12$D1CMGMKVsWKaNqvb69iliuLkJdpGJ4V0mudT0fjtDtK3316t6E7xK','92000735','2026-09-22'), 
('Feliperson Antonio vitto navas','marcosouzavitto11@gmail.com','$2a$12$tcZ819.ChnvqQIZnD71c3OUWU3qEqD/RXkAXgENGOkcfTQx9KpDPu','199996767','2026-09-22'), 
('Tom Halland colleman','tomholland@email','$2a$12$Co19J7GlVsGRFrRYgYQqHupafCyonBpEaZLKLIvDNA0exM2N9.Ziy','4188867775','2026-09-22');

INSERT INTO personal (usuario_id, cref, especialidade,biografia, link_rede_social, criado_em) VALUES (1, '676767-G/PR','estetica corporal','não tem','MarcoAurelio_personal','2026-09-22');
SELECT * FROM grupo_muscular;

INSERT INTO aluno(personal_id,usuario_id, data_nascimento, sexo, objetivo_principal, observacao, criado_em, data_inicio, nivel) VALUES ('1','2','2009-10-19','feminino','Melhorar o Fisico','tendao estorado','2026-09-22','2026-09-22','iniciante'),
('1','3','2000-03-30','masculino','não tem','não tem','2026-09-22','2026-09-22','intermediario');

INSERT INTO grupo_muscular (nome_grupo) VALUES ('Peitoral'), 
('Dorsais'),
('Quadríceps e Posteriores'), 
('Deltoides'),
('Bíceps e Tríceps'),
('Abdômen');

INSERT INTO equipamento (grupo_muscular_id, nome_equipamento) VALUES ('1','Banco de Supino'),
('2','Máquina de Pulley'),
('3','Leg Press'),
('4','Elevação Lateral'),
('5','Máquina de Rosca Articulada'),
('6','Roda Abdominal');

INSERT exercicio (grupo_muscular_id, 
equipamento_id, personal_id, nome_exercicio, nivel, instrucao,criado_em) VALUES 
('1','1','1','Crucifixo com Halteres','intermediario','Deite no banco com halteres para cima. Abra os braços em arco largo, 
flexionando levemente os cotovelos, e retorne contraindo o peito.','2026-09-11'),
 
('2','2','1','Puxada Alta','facil','Sente na máquina com as coxas presas e segure a barra. Puxe em direção ao peito levando 
os cotovelos para baixo, e retorne controlando o peso.','2026-09-01'),

('5','5','1','Rosca Inversa','dificil','Sente na máquina com os braços apoiados, segure com palmas 
para baixo e puxe o peso até os ombros. Retorne controlando.','2026-08-10');

INSERT treino (aluno_id, personal_id, nome_treino, descricao, objetivo, data_inicio, data_fim, criado_em) 
VALUES (1,1,'Treino Hipertrofia A/B','acompanhamento profissional para ganho de
 massa muscular','Ganhar mais musculos',
'2026-09-22','2026-12-22','2026-09-22');
INSERT treino (aluno_id, personal_id, nome_treino, descricao, objetivo, data_inicio, data_fim, criado_em) 
VALUES (1,1,'Treino Hipertrofia A/B','acompanhamento profissional para ganho de massa muscular','Ganhar mais musculos',
'2026-09-22','2026-12-22','2026-09-22');

INSERT treino_dia (treino_id, exercicio_id, ordem_treino, nome, criado_em) VALUES 
('1','1','1','Treino A - Peito e Tríceps','2026-09-22'),
('1','3','2','Treino B - Pernas e Ombros','2026-09-23');

INSERT treino_exercicio (treino_dia_id, 
    exercicio_id, carga_sugerida, unidade_carga, repeticao, repeticao_max, descanso , observacao, criado_em) 
    VALUES (1, 3, 3.0, 'kg', 10 ,12 ,1,'Sem observaçao','2026-10-22 20:30:00'),
		   (1, 2, 15.0, 'kg', 10 ,12 ,1,'Sem observaçao','2026-10-22 20:30:00'),
           (2, 1, 30.0, 'kg', 10 ,12 ,1,'Sem observaçao','2026-10-02 20:43:00'),
           (2, 2, 30.0, 'kg', 5 ,10 ,1,'Sem observaçao','2026-10-02 20:43:00');







