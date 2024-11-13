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
    hotel_id BIGINT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
);

CREATE TABLE acomodacao
(
    numero       BIGINT AUTO_INCREMENT NOT NULL,
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
    cpf                        VARCHAR(14)  NOT NULL,
    data_nascimento            DATE         NOT NULL,
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
    pessoa_id BIGINT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pessoa_id) REFERENCES pessoa (id)
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

CREATE TABLE contrato_aluguel
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    data_inicio   DATE   NOT NULL,
    data_fim      DATE   NOT NULL,
    dia_pagamento BIGINT NOT NULL,
    empresa_id    BIGINT NOT NULL,
    condominio_id BIGINT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (empresa_id) REFERENCES empresa (id),
    FOREIGN KEY (condominio_id) REFERENCES condominio (id)
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
       ('Hotel Urbano Premium', 'ADULTOS', 2500, TRUE, 'Executivo', 4),
       ('Villa Verde Eco Lodge', 'ADULTOS', 1800, FALSE, 'TRADICIONAL', 5);