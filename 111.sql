CREATE database IF NOT EXISTS loja_FelipeMoveis;
USE loja_FelipeMoveis;

CREATE TABLE IF NOT EXISTS cliente(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS cargo(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    cargo VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS produto(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    valor FLOAT NOT NULL
);
CREATE TABLE IF NOT EXISTS funcionario(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    cargo_id BIGINT NOT NULL,
    CONSTRAINT 	fk_funcionario_cargo FOREIGN KEY (cargo_id) references cargo(id),
    nome VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS venda(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    cliente_id BIGINT NOT NULL,
    funcionario_id BIGINT NOT NULL,
    CONSTRAINT fk_funcionario_cliente FOREIGN KEY(funcionario_id) references funcionario(id),
    CONSTRAINT fk_cliente_venda FOREIGN KEY(cliente_id) references cliente(id),
    venda_data DATE NOT NULL
    
);
CREATE TABLE IF NOT EXISTS item_venda(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    venda_id BIGINT NOT NULL,
    produto_id BIGINT NOT NULL,
    CONSTRAINT fk_venda_item FOREIGN KEY(venda_id) references venda(id),
    CONSTRAINT fk_produto_item FOREIGN KEY(produto_id) references produto(id),
	quantidade 	INT NOT NULL,
    preco_unitario FLOAT NOT NULL,
    preco_pago FLOAT NOT NULL,
	desconto FLOAT NOT NULL
);
INSERT INTO  cliente ( nome) VALUE ('Sr. Luiz Miguel Nascimento'),
('Arthur Freitas'),
('Mariana Porto'),
('Mateus Pinto'),
('Eloá Barros'),
('Sr. Diogo Cardoso'),
('Yasmin Souza'),
('Dr. Gustavo Henrique Castro'),
('Isaac Machado'),
('Luiz Gustavo Mendonça');
INSERT INTO cargo (cargo) VALUES('Atendente'), ('Gerente');

INSERT INTO funcionario (nome, cargo_id) VALUES('Dr. Davi Luiz Ferreira','1'),
('Srta. Ana Vitória Vasconcelos','2'),
('Sarah Correia','1'),
('Brenda Casa Grande','2'),
('Maria Luiza Cavalcante','2');

INSERT produto (nome, valor) VALUES
('cama box quean','2000'),
('sapateira','500'),
('guarda roupa','1800'),
('sofa 5 lugares','3500'),
('comoda','800');

INSERT venda (cliente_id, funcionario_id, venda_data) VALUES
('1','1','2026-05-26'),
('2','2','2026-05-10'),
('1','1','2026-05-31'),
('3','1','2026-05-12'),
('4','2','2026-05-14'),
('5','3','2026-05-29'),
('3','2','2026-05-25'),
('2','4','2026-05-30'),
('6','3','2026-05-21'),
('2','3','2026-06-08');

INSERT INTO item_venda(produto_id, quantidade, 
preco_unitario, desconto, preco_pago) VALUES ('1','1','4','2000','320','7680'),
('1','2','1','2000','0','2000'),
('2','3','5','500','0','2500'),
('3','4','2','1800','0','3600'),
('3','5','2','1800','0','3600'),
('1','6','3','2000','300','5700'),
('4','7','5','3500','0','17500'),
(1,'8','2','2000','0','4000'),
(5,'9','5','800','40','3960'),
('10','5','1800','450','8550');
SELECT
	id,
    nome,
    SUM(preco_pago) AS quantidade
    FROM funcionario
    INNER JOIN item_venda ON id
    

