CREATE SCHEMA hotelaria;

CREATE TABLE georreferenciamento
(
    id        BIGINT AUTO_INCREMENT NOT NULL,
    latitude  DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE registro_imobiliario
(
    id                         BIGINT AUTO_INCREMENT NOT NULL,
    numero_registro_prefeitura VARCHAR(60) NOT NULL,
    data_registro              DATE        NOT NULL,
    georreferenciamento_id     BIGINT      NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (georreferenciamento_id) REFERENCES georreferenciamento (id)
);

CREATE TABLE hotel
(
    id                      BIGINT AUTO_INCREMENT NOT NULL,
    nome_fantasia           VARCHAR(120) NOT NULL,
    setor                   VARCHAR(60)  NOT NULL,
    tamanho                 BIGINT       NOT NULL,
    is_central              BOOLEAN      NOT NULL,
    categoria               VARCHAR(60)  NOT NULL,
    registro_imobiliario_id BIGINT       NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (registro_imobiliario_id) REFERENCES registro_imobiliario (id)
);

CREATE TABLE condominio
(
    id       BIGINT AUTO_INCREMENT NOT NULL,
    hotel_id BIGINT       NOT NULL,
    nome     VARCHAR(120) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
);

CREATE TABLE sala_condominio
(
    numero           BIGINT NOT NULL,
    condominio_id    BIGINT NOT NULL,
    metros_quadrados BIGINT NOT NULL,
    PRIMARY KEY (numero, condominio_id),
    FOREIGN KEY (condominio_id) REFERENCES condominio (id)
);

CREATE TABLE acomodacao
(
    numero       BIGINT         NOT NULL,
    hotel_id     BIGINT         NOT NULL,
    valor_diaria DECIMAL(10, 2) NOT NULL,
    tipo         VARCHAR(60)    NOT NULL,
    capacidade   BIGINT         NOT NULL,
    PRIMARY KEY (numero, hotel_id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
);

CREATE TABLE documento_identificacao
(
    id     BIGINT AUTO_INCREMENT NOT NULL,
    tipo   VARCHAR(60) NOT NULL,
    numero VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE pessoa
(
    id                         BIGINT AUTO_INCREMENT NOT NULL,
    nome                       VARCHAR(200) NOT NULL,
    data_nascimento            DATE         NOT NULL,
    celular                    VARCHAR(20)  NOT NULL,
    email                      VARCHAR(120) NOT NULL,
    sexo                       VARCHAR(30)  NOT NULL,
    documento_identificacao_id BIGINT       NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (documento_identificacao_id) REFERENCES documento_identificacao (id)
);

CREATE TABLE hospede
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    pessoa_id     BIGINT   NOT NULL,
    registrado_em DATETIME NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pessoa_id) REFERENCES pessoa (id)
);

CREATE TABLE funcionario
(
    id        BIGINT AUTO_INCREMENT NOT NULL,
    pessoa_id BIGINT       NOT NULL,
    email     VARCHAR(120) NOT NULL,
    hotel_id  BIGINT       NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pessoa_id) REFERENCES pessoa (id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
);

CREATE TABLE reserva_acomodacao
(
    id                     BIGINT AUTO_INCREMENT NOT NULL,
    data_esperada_checkin  DATETIME NOT NULL,
    data_esperada_checkout DATETIME NOT NULL,
    data_checkin           DATETIME NOT NULL,
    data_checkout          DATETIME NOT NULL,
    numero_acomodacao      BIGINT   NOT NULL,
    hotel_id               BIGINT   NOT NULL,
    hospede_id             BIGINT   NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (numero_acomodacao, hotel_id) REFERENCES acomodacao (numero, hotel_id),
    FOREIGN KEY (hospede_id) REFERENCES hospede (id)
);

CREATE TABLE pedido
(
    id                    BIGINT AUTO_INCREMENT NOT NULL,
    descricao             VARCHAR(120)   NOT NULL,
    valor                 DECIMAL(10, 2) NOT NULL,
    data_hora             DATETIME       NOT NULL,
    reserva_acomodacao_id BIGINT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (reserva_acomodacao_id) REFERENCES reserva_acomodacao (id)
);

CREATE TABLE politica_de_uso
(
    id        BIGINT AUTO_INCREMENT NOT NULL,
    nome      VARCHAR(60)  NOT NULL,
    descricao VARCHAR(120) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE acomodacao_politica_de_uso
(
    numero_acomodacao  BIGINT NOT NULL,
    hotel_id           BIGINT NOT NULL,
    politica_de_uso_id BIGINT NOT NULL,
    PRIMARY KEY (numero_acomodacao, hotel_id, politica_de_uso_id),
    FOREIGN KEY (numero_acomodacao, hotel_id) REFERENCES acomodacao (numero, hotel_id),
    FOREIGN KEY (politica_de_uso_id) REFERENCES politica_de_uso (id)
);

CREATE TABLE manutencao
(
    id               BIGINT AUTO_INCREMENT NOT NULL,
    descricao        VARCHAR(120) NOT NULL,
    data_hora_inicio DATETIME     NOT NULL,
    data_hora_fim    DATETIME     NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE acomodacao_manutencao
(
    numero_acomodacao BIGINT NOT NULL,
    hotel_id          BIGINT NOT NULL,
    manutencao_id     BIGINT NOT NULL,
    PRIMARY KEY (numero_acomodacao, hotel_id, manutencao_id),
    FOREIGN KEY (numero_acomodacao, hotel_id) REFERENCES acomodacao (numero, hotel_id),
    FOREIGN KEY (manutencao_id) REFERENCES manutencao (id)
);

CREATE TABLE empresa
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    razao_social  VARCHAR(120) NOT NULL,
    nome_fantasia VARCHAR(120) NOT NULL,
    cnpj          VARCHAR(18)  NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE sala_condominio_manutencao
(
    numero_sala_condominio BIGINT NOT NULL,
    condominio_id          BIGINT NOT NULL,
    manutencao_id          BIGINT NOT NULL,
    PRIMARY KEY (numero_sala_condominio, condominio_id, manutencao_id),
    FOREIGN KEY (numero_sala_condominio, condominio_id) REFERENCES sala_condominio (numero, condominio_id),
    FOREIGN KEY (manutencao_id) REFERENCES manutencao (id)
);

CREATE TABLE contrato_aluguel
(
    id                     BIGINT AUTO_INCREMENT NOT NULL,
    data_inicio            DATE           NOT NULL,
    data_fim               DATE           NOT NULL,
    dia_pagamento          BIGINT         NOT NULL,
    empresa_id             BIGINT         NOT NULL,
    numero_sala_condominio BIGINT         NOT NULL,
    valor                  DECIMAL(10, 2) NOT NULL,
    condominio_id          BIGINT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (empresa_id) REFERENCES empresa (id),
    FOREIGN KEY (numero_sala_condominio, condominio_id) REFERENCES sala_condominio (numero, condominio_id)
);

CREATE TABLE entrega
(
    id                   BIGINT AUTO_INCREMENT NOT NULL,
    descricao            VARCHAR(120) NOT NULL,
    data_hora            DATETIME     NOT NULL,
    numero_acomodacao    BIGINT       NOT NULL,
    hotel_id             BIGINT       NOT NULL,
    empresa_remetente_id BIGINT       NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (numero_acomodacao, hotel_id) REFERENCES acomodacao (numero, hotel_id),
    FOREIGN KEY (empresa_remetente_id) REFERENCES empresa (id)
);

CREATE TABLE acomodacao_entrega
(
    numero_acomodacao BIGINT NOT NULL,
    hotel_id          BIGINT NOT NULL,
    entrega_id        BIGINT NOT NULL,
    PRIMARY KEY (numero_acomodacao, hotel_id, entrega_id),
    FOREIGN KEY (numero_acomodacao, hotel_id) REFERENCES acomodacao (numero, hotel_id),
    FOREIGN KEY (entrega_id) REFERENCES entrega (id)
);

CREATE TABLE contrato_de_trabalho
(
    id             BIGINT AUTO_INCREMENT NOT NULL,
    cargo          VARCHAR(60)    NOT NULL,
    tipo           VARCHAR(60)    NOT NULL,
    data_inicio    DATE           NOT NULL,
    horas_mes      BIGINT         NOT NULL,
    salario_mes    DECIMAL(10, 2) NOT NULL,
    finalizado     BOOLEAN        NOT NULL,
    funcionario_id BIGINT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (funcionario_id) REFERENCES funcionario (id)
);

CREATE TABLE tipo_contrato_de_trabalho
(
    id   BIGINT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE plano_de_saude
(
    id                            BIGINT AUTO_INCREMENT NOT NULL,
    nome                          VARCHAR(60)    NOT NULL,
    cnpj_fornecedor               VARCHAR(18)    NOT NULL,
    valor_mensal                  DECIMAL(10, 2) NOT NULL,
    possui_coparticipacao         BOOLEAN        NOT NULL,
    tipo_contrato_beneficiario_id BIGINT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tipo_contrato_beneficiario_id) REFERENCES tipo_contrato_de_trabalho (id)
);

CREATE TABLE vale
(
    id                            BIGINT AUTO_INCREMENT NOT NULL,
    tipo                          VARCHAR(60)    NOT NULL,
    descricao                     VARCHAR(120)   NOT NULL,
    valor                         DECIMAL(10, 2) NOT NULL,
    data_hora                     DATETIME       NOT NULL,
    percentual_de_desconto        DECIMAL(10, 2) NOT NULL,
    tipo_contrato_beneficiario_id BIGINT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tipo_contrato_beneficiario_id) REFERENCES tipo_contrato_de_trabalho (id)
);

CREATE TABLE estoque
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    capacidade    BIGINT   NOT NULL,
    atualizado_em DATETIME NOT NULL,
    hotel_id      BIGINT   NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
);

CREATE TABLE produto
(
    id    BIGINT AUTO_INCREMENT NOT NULL,
    nome  VARCHAR(120) NOT NULL,
    marca VARCHAR(60)  NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE cozinha
(
    id         BIGINT AUTO_INCREMENT NOT NULL,
    nome       VARCHAR(120) NOT NULL,
    estoque_id BIGINT       NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (estoque_id) REFERENCES estoque (id)
);

CREATE TABLE estoque_produto
(
    produto_id BIGINT NOT NULL,
    estoque_id BIGINT NOT NULL,
    quantidade BIGINT NOT NULL,
    PRIMARY KEY (produto_id, estoque_id),
    FOREIGN KEY (produto_id) REFERENCES produto (id),
    FOREIGN KEY (estoque_id) REFERENCES estoque (id)
);

CREATE TABLE estacionamento
(
    id           BIGINT AUTO_INCREMENT NOT NULL,
    tipo         VARCHAR(60)    NOT NULL,
    capacidade   BIGINT         NOT NULL,
    valor_diaria DECIMAL(10, 2) NOT NULL,
    hotel_id     BIGINT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
);

CREATE TABLE reserva_estacionamento
(
    id                BIGINT AUTO_INCREMENT NOT NULL,
    data_checkin      DATE   NOT NULL,
    data_checkout     DATE   NOT NULL,
    hospede_id        BIGINT NOT NULL,
    estacionamento_id BIGINT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hospede_id) REFERENCES hospede (id),
    FOREIGN KEY (estacionamento_id) REFERENCES estacionamento (id)
);

CREATE TABLE nota_fiscal
(
    id                        BIGINT AUTO_INCREMENT NOT NULL,
    numero                    VARCHAR(60)    NOT NULL,
    data_emissao              DATE           NOT NULL,
    valor                     DECIMAL(10, 2) NOT NULL,
    documento_emissor_id      BIGINT         NOT NULL,
    documento_destinatario_id BIGINT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (documento_emissor_id) REFERENCES documento_identificacao (id),
    FOREIGN KEY (documento_destinatario_id) REFERENCES documento_identificacao (id)
);

CREATE TABLE pagamento
(
    id             BIGINT AUTO_INCREMENT NOT NULL,
    titulo         VARCHAR(120) NOT NULL,
    descricao      VARCHAR(120) NOT NULL,
    nota_fiscal_id BIGINT       NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (nota_fiscal_id) REFERENCES nota_fiscal (id)
);

CREATE TABLE espaco_de_evento
(
    id       BIGINT AUTO_INCREMENT NOT NULL,
    hotel_id BIGINT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
);

CREATE TABLE tipo_de_uso
(
    id        BIGINT AUTO_INCREMENT NOT NULL,
    nome      VARCHAR(60)  NOT NULL,
    descricao VARCHAR(120) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE local_evento
(
    id               BIGINT AUTO_INCREMENT NOT NULL,
    tipo_de_espaco   VARCHAR(60) NOT NULL,
    tipo_de_uso_id   BIGINT      NOT NULL,
    capacidade       BIGINT      NOT NULL,
    espaco_evento_id BIGINT      NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (espaco_evento_id) REFERENCES espaco_de_evento (id),
    FOREIGN KEY (tipo_de_uso_id) REFERENCES tipo_de_uso (id)
);

CREATE TABLE local_evento_manutencao
(
    local_evento_id BIGINT NOT NULL,
    manutencao_id   BIGINT NOT NULL,
    PRIMARY KEY (local_evento_id, manutencao_id),
    FOREIGN KEY (local_evento_id) REFERENCES local_evento (id),
    FOREIGN KEY (manutencao_id) REFERENCES manutencao (id)
);

INSERT INTO georreferenciamento (latitude, longitude)
VALUES (-23.550520, -46.633308), -- São Paulo, SP
       (-22.906847, -43.172897), -- Rio de Janeiro, RJ
       (-15.780148, -47.929170), -- Brasília, DF
       (-12.971431, -38.501400), -- Salvador, BA
       (-25.428356, -49.273251); -- Curitiba, PR

INSERT INTO registro_imobiliario (numero_registro_prefeitura, data_registro, georreferenciamento_id)
VALUES ('REG12345', '2022-05-10', 1),
       ('REG67890', '2021-11-23', 2),
       ('REG54321', '2020-07-15', 3),
       ('REG09876', '2019-03-18', 4),
       ('REG11223', '2023-01-25', 5);

INSERT INTO hotel (nome_fantasia, setor, tamanho, is_central, categoria, registro_imobiliario_id)
VALUES ('Hotel Central Plaza', 'FAMILIA', 3000, TRUE, 'TRADICIONAL', 1),
       ('Pousada dos Ventos', 'FAMILIA', 1200, FALSE, 'TRADICIONAL', 2),
       ('Resort Sol e Mar', 'ADULTOS', 5000, FALSE, 'RESORT', 3),
       ('Hotel Urbano Premium', 'ADULTOS', 2500, TRUE, 'POUSADA', 4),
       ('Villa Verde Eco Lodge', 'ADULTOS', 1800, FALSE, 'TRADICIONAL', 5);

INSERT INTO acomodacao (numero, hotel_id, valor_diaria, tipo, capacidade)
VALUES (1, 1, 150.00, 'STANDARD', 2),
       (2, 1, 160.00, 'STANDARD_COM_VISTA', 2),
       (3, 1, 200.00, 'DELUXE', 3),
       (4, 1, 210.00, 'DELUXE_COM_VISTA', 3),
       (5, 1, 250.00, 'SUITE', 4),
       (6, 1, 260.00, 'SUITE_COM_VISTA', 4),
       (7, 1, 300.00, 'EXECUTIVE', 4),
       (8, 1, 350.00, 'EXECUTIVE_COM_VISTA', 5),
       (9, 1, 400.00, 'PRESIDENTIAL_SUITE', 5),
       (10, 1, 450.00, 'ROYAL_SUITE', 6),
       (1, 2, 140.00, 'STANDARD', 2),
       (2, 2, 150.00, 'STANDARD_COM_VISTA', 2),
       (3, 2, 190.00, 'DELUXE', 3),
       (4, 2, 200.00, 'DELUXE_COM_VISTA', 3),
       (5, 2, 240.00, 'SUITE', 4),
       (6, 2, 250.00, 'SUITE_COM_VISTA', 4),
       (7, 2, 290.00, 'EXECUTIVE', 4),
       (8, 2, 340.00, 'EXECUTIVE_COM_VISTA', 5),
       (9, 2, 390.00, 'PRESIDENTIAL_SUITE', 5),
       (10, 2, 440.00, 'ROYAL_SUITE', 6),
       (1, 3, 130.00, 'STANDARD', 2),
       (2, 3, 140.00, 'STANDARD_COM_VISTA', 2),
       (3, 3, 180.00, 'DELUXE', 3),
       (4, 3, 190.00, 'DELUXE_COM_VISTA', 3),
       (5, 3, 230.00, 'SUITE', 4),
       (6, 3, 240.00, 'SUITE_COM_VISTA', 4),
       (7, 3, 280.00, 'EXECUTIVE', 4),
       (8, 3, 330.00, 'EXECUTIVE_COM_VISTA', 5),
       (9, 3, 380.00, 'PRESIDENTIAL_SUITE', 5),
       (10, 3, 430.00, 'ROYAL_SUITE', 6),
       (1, 4, 160.00, 'STANDARD', 2),
       (2, 4, 170.00, 'STANDARD_COM_VISTA', 2),
       (3, 4, 210.00, 'DELUXE', 3),
       (4, 4, 220.00, 'DELUXE_COM_VISTA', 3),
       (5, 4, 260.00, 'SUITE', 4),
       (6, 4, 270.00, 'SUITE_COM_VISTA', 4),
       (7, 4, 310.00, 'EXECUTIVE', 4),
       (8, 4, 360.00, 'EXECUTIVE_COM_VISTA', 5),
       (9, 4, 410.00, 'PRESIDENTIAL_SUITE', 5),
       (10, 4, 460.00, 'ROYAL_SUITE', 6);

INSERT INTO politica_de_uso (nome, descricao)
VALUES ('Política de Cancelamento', 'Cancelamento gratuito até 24 horas antes do check-in'),
       ('Política de Fumantes', 'Proibido fumar dentro das acomodações'),
       ('Política de Animais', 'Permitido animais de pequeno porte com taxa adicional'),
       ('Política de Silêncio', 'Horário de silêncio entre 22h e 7h'),
       ('Política de Limpeza', 'Limpeza diária incluída na diária'),
       ('Política de Visitantes', 'Visitantes permitidos até 22h'),
       ('Política de Check-in Antecipado', 'Check-in antecipado sujeito à disponibilidade e taxa extra'),
       ('Política de Check-out Tardio', 'Check-out tardio sujeito à disponibilidade e taxa extra');

INSERT INTO acomodacao_politica_de_uso (numero_acomodacao, hotel_id, politica_de_uso_id)
VALUES (1, 1, 1),
       (1, 1, 2),
       (1, 1, 3),
       (2, 1, 1),
       (2, 1, 4),
       (3, 1, 5),
       (3, 1, 6),
       (4, 1, 1),
       (4, 1, 2),
       (5, 1, 3),
       (1, 2, 1),
       (1, 2, 2),
       (2, 2, 3),
       (2, 2, 5),
       (3, 2, 6),
       (3, 2, 4),
       (4, 2, 1),
       (4, 2, 2),
       (5, 2, 3),
       (1, 3, 1),
       (1, 3, 2),
       (2, 3, 5),
       (2, 3, 3),
       (3, 3, 4),
       (4, 3, 1),
       (4, 3, 2),
       (5, 3, 3),
       (6, 3, 5),
       (1, 4, 1),
       (1, 4, 3),
       (2, 4, 2),
       (2, 4, 4),
       (3, 4, 5),
       (3, 4, 6),
       (4, 4, 1),
       (4, 4, 3),
       (5, 4, 4),
       (5, 4, 2);

INSERT INTO documento_identificacao (tipo, numero)
VALUES ('PASSAPORTE', 'X12345678'),
       ('RG', '1234567890'),
       ('CPF', '98765432109'),
       ('PASSAPORTE', 'Y98765432'),
       ('RG', '0987654321'),
       ('CPF', '12345678901'),
       ('PASSAPORTE', 'Z87654321'),
       ('RG', '5678901234'),
       ('CPF', '65432109876'),
       ('PASSAPORTE', 'A12345678'),
       ('RG', '2345678901'),
       ('CPF', '34567890123'),
       ('PASSAPORTE', 'B87654321'),
       ('RG', '6789012345'),
       ('CPF', '87654321098'),
       ('PASSAPORTE', 'C12345678'),
       ('RG', '7890123456'),
       ('CPF', '45678901234'),
       ('PASSAPORTE', 'D98765432'),
       ('RG', '8901234567');

INSERT INTO pessoa (nome, data_nascimento, celular, email, sexo, documento_identificacao_id)
VALUES ('João Silva', '1985-03-15', '11987654321', 'joao.silva@example.com', 'MASCULINO', 1),
       ('Maria Oliveira', '1992-07-23', '11998765432', 'maria.oliveira@example.com', 'FEMININO', 2),
       ('Carlos Souza', '1978-11-05', '11987651234', 'carlos.souza@example.com', 'MASCULINO', 3),
       ('Ana Costa', '1990-02-28', '11987654322', 'ana.costa@example.com', 'FEMININO', 4),
       ('Pedro Santos', '1983-05-12', '11987654323', 'pedro.santos@example.com', 'MASCULINO', 5),
       ('Julia Mendes', '1995-09-18', '11987654324', 'julia.mendes@example.com', 'FEMININO', 6),
       ('Bruno Lima', '1989-08-04', '11987654325', 'bruno.lima@example.com', 'MASCULINO', 7),
       ('Renata Araújo', '1982-12-14', '11987654326', 'renata.araujo@example.com', 'FEMININO', 8),
       ('Fernando Almeida', '1975-10-27', '11987654327', 'fernando.almeida@example.com', 'MASCULINO', 9),
       ('Luiza Rocha', '1997-01-30', '11987654328', 'luiza.rocha@example.com', 'FEMININO', 10),
       ('Gabriel Reis', '1981-04-17', '11987654329', 'gabriel.reis@example.com', 'MASCULINO', 11),
       ('Tatiana Gomes', '1994-06-09', '11987654330', 'tatiana.gomes@example.com', 'FEMININO', 12),
       ('Ricardo Barbosa', '1979-09-20', '11987654331', 'ricardo.barbosa@example.com', 'MASCULINO', 13),
       ('Carolina Mello', '1991-03-22', '11987654332', 'carolina.mello@example.com', 'FEMININO', 14),
       ('Gustavo Pereira', '1987-07-15', '11987654333', 'gustavo.pereira@example.com', 'MASCULINO', 15),
       ('Patricia Silva', '1993-12-29', '11987654334', 'patricia.silva@example.com', 'FEMININO', 16),
       ('André Fernandes', '1980-11-01', '11987654335', 'andre.fernandes@example.com', 'MASCULINO', 17),
       ('Beatriz Ribeiro', '1996-10-11', '11987654336', 'beatriz.ribeiro@example.com', 'FEMININO', 18),
       ('Felipe Matos', '1984-08-08', '11987654337', 'felipe.matos@example.com', 'MASCULINO', 19),
       ('Sofia Martins', '1998-02-25', '11987654338', 'sofia.martins@example.com', 'FEMININO', 20);


INSERT INTO hospede (pessoa_id, registrado_em)
VALUES (1, '2024-11-01 14:23:00'),
       (2, '2024-11-01 15:45:00'),
       (3, '2024-11-02 09:15:00'),
       (4, '2024-11-02 10:30:00'),
       (5, '2024-11-02 11:45:00'),
       (6, '2024-11-02 12:30:00'),
       (7, '2024-11-03 08:15:00'),
       (8, '2024-11-03 09:45:00'),
       (9, '2024-11-03 10:00:00'),
       (10, '2024-11-03 11:20:00'),
       (11, '2024-11-04 12:40:00'),
       (12, '2024-11-04 13:50:00'),
       (13, '2024-11-04 15:00:00'),
       (14, '2024-11-05 08:10:00'),
       (15, '2024-11-05 09:20:00'),
       (16, '2024-11-05 10:30:00'),
       (17, '2024-11-05 11:40:00'),
       (18, '2024-11-06 07:30:00'),
       (19, '2024-11-06 08:45:00'),
       (20, '2024-11-06 09:55:00');

INSERT INTO condominio (hotel_id, nome)
VALUES (1, 'Condomínio Central Plaza'),
       (2, 'Condomínio Pousada dos Ventos'),
       (4, 'Condomínio Hotel Urbano Premium'),
       (5, 'Condomínio Villa Verde Eco Lodge');

INSERT INTO sala_condominio (numero, condominio_id, metros_quadrados)
VALUES (1, 1, 50),
       (2, 1, 60),
       (3, 1, 70),
       (4, 1, 80),
       (5, 1, 90),
       (1, 2, 40),
       (2, 2, 50),
       (3, 2, 60),
       (4, 2, 70),
       (5, 2, 80),
       (1, 3, 30),
       (2, 3, 40),
       (3, 3, 50),
       (4, 3, 60),
       (5, 3, 70),
       (1, 4, 20),
       (2, 4, 30),
       (3, 4, 40),
       (4, 4, 50),
       (5, 4, 60);

INSERT INTO empresa (razao_social, nome_fantasia, cnpj)
VALUES ('MC Donalds LTDA', 'MC Donalds', '12345678000101'),
       ('MSC LTDA', 'MSC', '23456789000112'),
       ('Coco Bambu LTDA', 'Coco Bambu', '34567890000123'),
       ('Turismo DC LTDA', 'Turismo DC', '45678901000134'),
       ('Bar do Zé LTDA', 'Bar do Zé', '56789012000145');

INSERT INTO contrato_aluguel (data_inicio, data_fim, dia_pagamento, valor, empresa_id, numero_sala_condominio,
                              condominio_id)
VALUES ('2024-11-01', '2025-11-01', 5, 10000.00, 1, 1, 1),
       ('2024-11-02', '2025-11-02', 10, 11000.00, 2, 2, 1),
       ('2024-11-03', '2025-11-03', 15, 15000.00, 3, 3, 2),
       ('2024-11-04', '2025-11-04', 20, 9000.00, 4, 4, 3),
       ('2024-11-05', '2025-11-05', 25, 3000.00, 5, 5, 4);