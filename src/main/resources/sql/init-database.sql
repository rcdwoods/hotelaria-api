CREATE SCHEMA hotelaria;

CREATE TABLE hotel
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    nome_fantasia VARCHAR(120)          NOT NULL,
    setor         VARCHAR(60)           NOT NULL,
    tamanho       BIGINT                NOT NULL,
    is_central    BOOLEAN               NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE acomodacao
(
    id           BIGINT AUTO_INCREMENT NOT NULL,
    valor_diaria DECIMAL(10, 2)        NOT NULL,
    tipo         VARCHAR(60)           NOT NULL,
    capacidade   BIGINT                NOT NULL,
    hotel_id     BIGINT                NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
);

CREATE TABLE politica_de_uso
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    nome          VARCHAR(60)           NOT NULL,
    descricao     VARCHAR(120)          NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE acomodacao_politica_de_uso
(
    acomodacao_id      BIGINT NOT NULL,
    politica_de_uso_id BIGINT NOT NULL,
    PRIMARY KEY (acomodacao_id, politica_de_uso_id),
    FOREIGN KEY (acomodacao_id) REFERENCES acomodacao (id),
    FOREIGN KEY (politica_de_uso_id) REFERENCES politica_de_uso (id)
);

CREATE TABLE manutencao
(
    id               BIGINT AUTO_INCREMENT NOT NULL,
    descricao        VARCHAR(120)          NOT NULL,
    data_hora_inicio DATETIME              NOT NULL,
    data_hora_fim    DATETIME              NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (acomodacao_id) REFERENCES acomodacao (id)
);

CREATE TABLE acomodacao_manutencao
(
    acomodacao_id BIGINT NOT NULL,
    manutencao_id BIGINT NOT NULL,
    PRIMARY KEY (acomodacao_id, manutencao_id),
    FOREIGN KEY (acomodacao_id) REFERENCES acomodacao (id),
    FOREIGN KEY (manutencao_id) REFERENCES manutencao (id)
);

CREATE TABLE empresa
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    razao_social  VARCHAR(120)          NOT NULL,
    nome_fantasia VARCHAR(120)          NOT NULL,
    cnpj          VARCHAR(18)           NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE contrato_aluguel
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    data_inicio   DATE                  NOT NULL,
    data_fim      DATE                  NOT NULL,
    dia_pagamento BIGINT                NOT NULL,
    empresa_id    BIGINT                NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (empresa_id) REFERENCES empresa (id)
);

CREATE TABLE entrega
(
    id                   BIGINT AUTO_INCREMENT NOT NULL,
    descricao            VARCHAR(120)          NOT NULL,
    data_hora            DATETIME              NOT NULL,
    acomodacao_id        BIGINT                NOT NULL,
    empresa_remetente_id BIGINT                NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (acomodacao_id) REFERENCES acomodacao (id),
    FOREIGN KEY (empresa_remetente_id) REFERENCES empresa (id)
);

CREATE TABLE acomodacao_entrega
(
    acomodacao_id BIGINT NOT NULL,
    entrega_id    BIGINT NOT NULL,
    PRIMARY KEY (acomodacao_id, entrega_id),
    FOREIGN KEY (acomodacao_id) REFERENCES acomodacao (id),
    FOREIGN KEY (entrega_id) REFERENCES entrega (id)
);

CREATE TABLE documento_identificacao
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    tipo          VARCHAR(60)           NOT NULL,
    numero        VARCHAR(30)           NOT NULL,
    PRIMARY KEY (id),
);

CREATE TABLE pessoa
(
    id                         BIGINT AUTO_INCREMENT NOT NULL,
    nome                       VARCHAR(120) NOT NULL,
    cpf                        VARCHAR(14)  NOT NULL,
    data_nascimento            DATE         NOT NULL,
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
    id            BIGINT AUTO_INCREMENT NOT NULL,
    pessoa_id     BIGINT   NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pessoa_id) REFERENCES pessoa (id)
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
    nome VARCHAR(60)          NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE plano_de_saude
(
    id                         BIGINT AUTO_INCREMENT NOT NULL,
    nome                       VARCHAR(60)    NOT NULL,
    cnpj_fornecedor            VARCHAR(18)    NOT NULL,
    valor_mensal               DECIMAL(10, 2) NOT NULL,
    possui_coparticipacao      BOOLEAN        NOT NULL,
    tipo_contrato_beneficiario_id BIGINT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tipo_contrato_beneficiario_id) REFERENCES tipo_contrato_de_trabalho (id),
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