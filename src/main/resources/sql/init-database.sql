DROP SCHEMA IF EXISTS hotelaria;
CREATE SCHEMA hotelaria;
USE
hotelaria;

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
--- acredito que devemos mudar essa tabela que tipo e numero sejam unique
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
    email                      VARCHAR(120) NOT NULL UNIQUE,
    sexo                       VARCHAR(30)  NOT NULL,
    documento_identificacao_id BIGINT       NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (documento_identificacao_id) REFERENCES documento_identificacao (id)
);

CREATE TABLE hospede
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    pessoa_id     BIGINT   NOT NULL,
    data_registro DATETIME NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pessoa_id) REFERENCES pessoa (id)
);

CREATE TABLE funcionario
(
    id        BIGINT AUTO_INCREMENT NOT NULL,
    pessoa_id BIGINT       NOT NULL,
    email     VARCHAR(120) NOT NULL UNIQUE,
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
    data_checkin           DATETIME NULL,
    data_checkout          DATETIME NULL,
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
    reserva_id           BIGINT       NOT NULL,
    empresa_remetente_id BIGINT       NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (reserva_id) REFERENCES reserva_acomodacao (id),
    FOREIGN KEY (empresa_remetente_id) REFERENCES empresa (id)
);

CREATE TABLE tipo_contrato_de_trabalho
(
    id   BIGINT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE contrato_de_trabalho
(
    id                           BIGINT AUTO_INCREMENT NOT NULL,
    cargo                        VARCHAR(60)    NOT NULL,
    tipo_contrato_de_trabalho_id BIGINT         NOT NULL,
    data_inicio                  DATE           NOT NULL,
    horas_mes                    BIGINT         NOT NULL,
    salario_mes                  DECIMAL(10, 2) NOT NULL,
    finalizado                   BOOLEAN        NOT NULL,
    funcionario_id               BIGINT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tipo_contrato_de_trabalho_id) REFERENCES tipo_contrato_de_trabalho (id),
    FOREIGN KEY (funcionario_id) REFERENCES funcionario (id)
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
    percentual_de_desconto        DECIMAL(10, 2) NOT NULL,
    tipo_contrato_beneficiario_id BIGINT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tipo_contrato_beneficiario_id) REFERENCES tipo_contrato_de_trabalho (id)
);

CREATE TABLE estoque
(
    id               BIGINT AUTO_INCREMENT NOT NULL,
    capacidade       BIGINT   NOT NULL,
    data_atualizacao DATETIME NOT NULL,
    PRIMARY KEY (id)
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
    id                BIGINT AUTO_INCREMENT NOT NULL,
    nome              VARCHAR(120) NOT NULL,
    hotel_id          BIGINT       NOT NULL,
    estoque_id        BIGINT       NOT NULL,
    tamanho_em_metros BIGINT       NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id),
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
    id                    BIGINT AUTO_INCREMENT NOT NULL,
    data_checkin          DATE   NOT NULL,
    data_checkout         DATE   NOT NULL,
    reserva_acomodacao_id BIGINT NOT NULL,
    estacionamento_id     BIGINT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (reserva_acomodacao_id) REFERENCES reserva_acomodacao (id),
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
    id                      BIGINT AUTO_INCREMENT NOT NULL,
    hotel_id                BIGINT NOT NULL,
    tamanho_em_metros_total BIGINT NOT NULL,
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
    id                BIGINT AUTO_INCREMENT NOT NULL,
    tipo_de_espaco    VARCHAR(60) NOT NULL,
    tipo_de_uso_id    BIGINT      NOT NULL,
    capacidade        BIGINT      NOT NULL,
    tamanho_em_metros BIGINT      NOT NULL,
    espaco_evento_id  BIGINT      NOT NULL,
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

CREATE TABLE requisicao
(
    id              BIGINT       NOT NULL,
    descricao       VARCHAR(120) NOT NULL,
    status          VARCHAR(60)  NOT NULL,
    tipo            VARCHAR(60)  NOT NULL,
    data_abertura   DATETIME     NOT NULL,
    data_fechamento DATETIME NULL,
    funcionario_id  BIGINT       NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (funcionario_id) REFERENCES funcionario (id)
);

CREATE TABLE hospede_requisicao
(
    hospede_id    BIGINT NOT NULL,
    requisicao_id BIGINT NOT NULL,
    PRIMARY KEY (hospede_id, requisicao_id),
    FOREIGN KEY (hospede_id) REFERENCES hospede (id),
    FOREIGN KEY (requisicao_id) REFERENCES requisicao (id)
);

CREATE TABLE academia
(
    id                            BIGINT AUTO_INCREMENT NOT NULL,
    nome                          VARCHAR(120) NOT NULL,
    descricao                     VARCHAR(255) NOT NULL,
    hotel_id                      BIGINT       NOT NULL,
    capacidade                    BIGINT       NOT NULL,
    horario_abertura_dia_semana   TIME         NOT NULL,
    horario_fechamento_dia_semana TIME         NOT NULL,
    horario_abertura_fim_semana   TIME         NOT NULL,
    horario_fechamento_fim_semana TIME         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
);

CREATE TABLE academia_politica_de_uso
(
    academia_id         BIGINT NOT NULL,
    politica_de_uso_ide BIGINT NOT NULL,
    PRIMARY KEY (academia_id, politica_de_uso_ide),
    FOREIGN KEY (academia_id) REFERENCES academia (id),
    FOREIGN KEY (politica_de_uso_ide) REFERENCES politica_de_uso (id)
);

CREATE TABLE veiculo
(
    id         BIGINT AUTO_INCREMENT NOT NULL,
    modelo     VARCHAR(120) NOT NULL,
    marca      VARCHAR(60)  NOT NULL,
    ano_fabricacao YEAR         NOT NULL,
    capacidade BIGINT       NOT NULL,
    tipo       VARCHAR(60)  NOT NULL,
    placa      VARCHAR(20)  NOT NULL UNIQUE,
    hotel_id   BIGINT       NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
);

CREATE TABLE transporte
(
    id                       BIGINT AUTO_INCREMENT NOT NULL,
    tipo                     VARCHAR(60)    NOT NULL,
    valor                    DECIMAL(10, 2) NOT NULL,
    descricao                VARCHAR(255)   NOT NULL,
    hotel_partida_id         BIGINT         NOT NULL,
    reserva_acomodacao_id    BIGINT         NOT NULL,
    horario_partida          DATETIME       NOT NULL,
    horario_esperado_chegada DATETIME       NOT NULL,
    horario_chegada          DATETIME NULL,
    veiculo_id               BIGINT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hotel_partida_id) REFERENCES hotel (id),
    FOREIGN KEY (reserva_acomodacao_id) REFERENCES reserva_acomodacao (id),
    FOREIGN KEY (veiculo_id) REFERENCES veiculo (id)
);

CREATE TABLE biblioteca
(
    id                            BIGINT AUTO_INCREMENT NOT NULL,
    nome                          VARCHAR(120)   NOT NULL,
    capacidade                    BIGINT         NOT NULL,
    metros_quadrados              BIGINT         NOT NULL,
    quantidade_locacao_por_pessoa BIGINT         NOT NULL,
    aceita_evento_literario       BOOLEAN        NOT NULL,
    multa_atraso                  DECIMAL(10, 2) NOT NULL,
    horario_abertura_dia_semana   TIME           NOT NULL,
    horario_fechamento_dia_semana TIME           NOT NULL,
    horario_abertura_fim_semana   TIME           NOT NULL,
    horario_fechamento_fim_semana TIME           NOT NULL,
    hotel_id                      BIGINT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
);

CREATE TABLE biblioteca_politica_de_uso
(
    biblioteca_id      BIGINT NOT NULL,
    politica_de_uso_id BIGINT NOT NULL,
    PRIMARY KEY (biblioteca_id, politica_de_uso_id),
    FOREIGN KEY (biblioteca_id) REFERENCES biblioteca (id),
    FOREIGN KEY (politica_de_uso_id) REFERENCES politica_de_uso (id)
);

CREATE TABLE livro
(
    id                 BIGINT AUTO_INCREMENT NOT NULL,
    titulo             VARCHAR(255) NOT NULL,
    autor              VARCHAR(120) NOT NULL,
    editora            VARCHAR(120) NOT NULL,
    ano_publicacao     INT(4)         NOT NULL,
    quantidade_paginas BIGINT       NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE locacao_livro
(
    livro_id                BIGINT NOT NULL,
    reserva_acomodacao_id   BIGINT NOT NULL,
    data_locacao            DATE   NOT NULL,
    data_esperada_devolucao DATE   NOT NULL,
    data_devolucao          DATE NULL,
    PRIMARY KEY (livro_id, reserva_acomodacao_id),
    FOREIGN KEY (livro_id) REFERENCES livro (id),
    FOREIGN KEY (reserva_acomodacao_id) REFERENCES reserva_acomodacao (id)
);

CREATE TABLE biblioteca_livro
(
    livro_id      BIGINT NOT NULL,
    biblioteca_id BIGINT NOT NULL,
    PRIMARY KEY (livro_id, biblioteca_id),
    FOREIGN KEY (livro_id) REFERENCES livro (id),
    FOREIGN KEY (biblioteca_id) REFERENCES biblioteca (id)
);

CREATE TABLE atividade_lazer
(
    id               BIGINT AUTO_INCREMENT NOT NULL,
    nome             VARCHAR(120) NOT NULL,
    descricao        VARCHAR(255) NOT NULL,
    data_hora_inicio DATETIME     NOT NULL,
    data_hora_fim    DATETIME     NOT NULL,
    hotel_id         BIGINT       NOT NULL,
    capacidade       BIGINT       NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
);

CREATE TABLE inscricao_atividade_lazer
(
    atividade_lazer_id BIGINT NOT NULL,
    hospede_id         BIGINT NOT NULL,
    PRIMARY KEY (atividade_lazer_id, hospede_id),
    FOREIGN KEY (atividade_lazer_id) REFERENCES atividade_lazer (id),
    FOREIGN KEY (hospede_id) REFERENCES hospede (id)
);

INSERT INTO georreferenciamento (latitude, longitude)
VALUES (-23.550520, -46.633308),
       (-22.906847, -43.172897),
       (-15.780148, -47.929170),
       (-12.971431, -38.501400),
       (-25.428356, -49.273251);

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
       ('Hotel das Montanhas', 'FAMILIA', 4000, FALSE, 'RESORT', 5);

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
       (10, 4, 460.00, 'ROYAL_SUITE', 6),
       (1, 5, 170.00, 'STANDARD', 2),
       (2, 5, 180.00, 'STANDARD_COM_VISTA', 2),
       (3, 5, 220.00, 'DELUXE', 3),
       (4, 5, 230.00, 'DELUXE_COM_VISTA', 3),
       (5, 5, 270.00, 'SUITE', 4),
       (6, 5, 280.00, 'SUITE_COM_VISTA', 4),
       (7, 5, 320.00, 'EXECUTIVE', 4),
       (8, 5, 370.00, 'EXECUTIVE_COM_VISTA', 5),
       (9, 5, 420.00, 'PRESIDENTIAL_SUITE', 5),
       (10, 5, 470.00, 'ROYAL_SUITE', 6);

INSERT INTO politica_de_uso (nome, descricao)
VALUES ('Política de Cancelamento', 'Cancelamento gratuito até 24 horas antes do check-in'),
       ('Política de Fumantes', 'Proibido fumar dentro das acomodações'),
       ('Política de Animais', 'Permitido animais de pequeno porte com taxa adicional'),
       ('Política de Silêncio', 'Horário de silêncio entre 22h e 7h'),
       ('Política de Limpeza', 'Limpeza diária incluída na diária'),
       ('Política de Visitantes', 'Visitantes permitidos até 22h'),
       ('Política de Check-in Antecipado', 'Check-in antecipado sujeito à disponibilidade e taxa extra'),
       ('Política de Check-out Tardio', 'Check-out tardio sujeito à disponibilidade e taxa extra'),
       ('Política de Vestimenta Apropriada', 'É obrigatório o uso de roupas e calçados esportivos.'),
       ('Política de Horários Limitados', 'Respeitar os horários de funcionamento da academia.'),
       ('Política de Limpeza dos Equipamentos', 'Higienizar os equipamentos após o uso.'),
       ('Política de Silêncio', 'Manter silêncio para respeitar outros usuários.'),
       ('Política de Prazo de Devolução', 'Os livros devem ser devolvidos em até 7 dias.'),
       ('Política de Não Alimentos', 'Não é permitido consumir alimentos na biblioteca.'),
       ('Política de Acesso Restrito', 'Acesso permitido apenas a hóspedes e funcionários autorizados.');

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

--- os documentos da linha 31 a 34 são cnpjs dos hoteis, e os da 35 a 38 são de associações, governo, etc.
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
       ('RG', '8901234567'),
       ('CPF', '111.222.333-44'),
       ('CNPJ', '03.255.567/0004-96'),
       ('CPF', '333.444.555-66'),
       ('CPF', '444.555.666-77'),
       ('CPF', '555.666.777-88'),
       ('CPF', '666.777.888-99'),
       ('CPF', '777.888.999-00'),
       ('CPF', '888.999.000-11'),
       ('CNPJ', '01.234.567/0001-99'),
       ('CPF', '000.111.222-33'),
       ('CNPJ', '12.345.678/0001-99'),
       ('CNPJ', '23.456.789/0001-88'),
       ('CNPJ', '34.567.890/0001-77'),
       ('CNPJ', '45.678.901/0001-66'),
       ('CNPJ', '56.789.012/0001-55'),
       ('CNPJ', '67.890.123/0001-44'),
       ('CNPJ', '78.901.234/0001-33'),
       ('CNPJ', '89.012.345/0001-22');

INSERT INTO pessoa (nome, data_nascimento, celular, email, sexo, documento_identificacao_id)
VALUES ('João Silva', '1985-03-15', '11987654321', 'joao.silva@gmail.com', 'MASCULINO', 1),
       ('Maria Oliveira', '1992-07-23', '11998765432', 'maria.oliveira@gmail.com', 'FEMININO', 2),
       ('Carlos Souza', '1978-11-05', '11987651234', 'carlos.souza1@gmail.com', 'MASCULINO', 3),
       ('Ana Costa', '1990-02-28', '11987654322', 'ana.costa@gmail.com', 'FEMININO', 4),
       ('Pedro Santos', '1983-05-12', '11987654323', 'pedro.santos@gmail.com', 'MASCULINO', 5),
       ('Julia Mendes', '1995-09-18', '11987654324', 'julia.mendes@gmail.com', 'FEMININO', 6),
       ('Bruno Lima', '1989-08-04', '11987654325', 'bruno.lima@gmail.com', 'MASCULINO', 7),
       ('Renata Araújo', '1982-12-14', '11987654326', 'renata.araujo@gmail.com', 'FEMININO', 8),
       ('Fernando Almeida', '1975-10-27', '11987654327', 'fernando.almeida@gmail.com', 'MASCULINO', 9),
       ('Luiza Rocha', '1997-01-30', '11987654328', 'luiza.rocha@gmail.com', 'FEMININO', 10),
       ('Gabriel Reis', '1981-04-17', '11987654329', 'gabriel.reis@gmail.com', 'MASCULINO', 11),
       ('Tatiana Gomes', '1994-06-09', '11987654330', 'tatiana.gomes@gmail.com', 'FEMININO', 12),
       ('Ricardo Barbosa', '1979-09-20', '11987654331', 'ricardo.barbosa@gmail.com', 'MASCULINO', 13),
       ('Carolina Mello', '1991-03-22', '11987654332', 'carolina.mello@gmail.com', 'FEMININO', 14),
       ('Gustavo Pereira', '1987-07-15', '11987654333', 'gustavo.pereira@gmail.com', 'MASCULINO', 15),
       ('Patricia Silva', '1993-12-29', '11987654334', 'patricia.silva@gmail.com', 'FEMININO', 16),
       ('André Fernandes', '1980-11-01', '11987654335', 'andre.fernandes@gmail.com', 'MASCULINO', 17),
       ('Beatriz Ribeiro', '1996-10-11', '11987654336', 'beatriz.ribeiro@gmail.com', 'FEMININO', 18),
       ('Felipe Matos', '1984-08-08', '11987654337', 'felipe.matos@gmail.com', 'MASCULINO', 19),
       ('Sofia Martins', '1998-02-25', '11987654338', 'sofia.martins@gmail.com', 'FEMININO', 20),
       ('João Silva', '1990-05-12', '123456789', 'joao.silva.2@gmail.com', 'FEMININO', 21),
       ('Maria Oliveira', '1985-08-25', '987654321', 'maria.oliveira.2@gmail.com', 'FEMININO', 22),
       ('Carlos Souza', '1993-02-18', '123123123', 'carlos.souza.2@gmail.com', 'MASCULINO', 23),
       ('Ana Santos', '1998-07-30', '321321321', 'ana.santos@gmail.com', 'FEMININO', 24),
       ('Pedro Lima', '1987-03-05', '555555555', 'pedro.lima@gmail.com', 'MASCULINO', 25),
       ('Fernanda Costa', '1991-11-12', '666666666', 'fernanda.costa@gmail.com', 'FEMININO', 26),
       ('Lucas Almeida', '1994-09-23', '777777777', 'lucas.almeida@gmail.com', 'MASCULINO', 27),
       ('Juliana Martins', '1989-01-15', '888888888', 'juliana.martins@gmail.com', 'FEMININO', 28),
       ('Gabriel Rocha', '1992-06-17', '999999999', 'gabriel.rocha@gmail.com', 'MASCULINO', 29),
       ('Patrícia Mendes', '1986-12-01', '101010101', 'patricia.mendes@gmail.com', 'FEMININO', 30);

INSERT INTO hospede (pessoa_id, data_registro)
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

INSERT INTO funcionario (pessoa_id, email, hotel_id)
VALUES (1, 'joao.silva@hotel.com', 1),
       (22, 'maria.oliveira@hotel.com', 1),
       (23, 'carlos.souza@hotel.com', 2),
       (24, 'ana.santos@hotel.com', 2),
       (25, 'pedro.lima@hotel.com', 3),
       (26, 'fernanda.costa@hotel.com', 3),
       (27, 'lucas.almeida@hotel.com', 4),
       (28, 'juliana.martins@hotel.com', 4),
       (29, 'gabriel.rocha@hotel.com', 1),
       (30, 'patricia.mendes@hotel.com', 4);

INSERT INTO tipo_contrato_de_trabalho (nome)
VALUES ('CLT'),
       ('PJ'),
       ('Estágio');

INSERT INTO contrato_de_trabalho (cargo, tipo_contrato_de_trabalho_id, data_inicio, horas_mes, salario_mes, finalizado,
                                  funcionario_id)
VALUES ('Recepcionista', 1, '2023-01-15', 180, 2500.00, FALSE, 1),
       ('Gerente', 2, '2022-06-01', 200, 5000.00, FALSE, 2),
       ('Camareira', 1, '2023-03-01', 180, 2000.00, FALSE, 3),
       ('Cozinheiro', 1, '2022-12-15', 180, 3000.00, FALSE, 4),
       ('Garçom', 1, '2023-04-01', 180, 2200.00, FALSE, 5),
       ('Segurança', 1, '2023-02-01', 180, 2800.00, FALSE, 6),
       ('Manutenção', 1, '2023-05-01', 180, 2600.00, FALSE, 7),
       ('Marketing', 3, '2022-08-01', 200, 4000.00, FALSE, 8),
       ('Financeiro', 2, '2023-01-10', 200, 4500.00, FALSE, 9),
       ('Limpeza', 1, '2023-03-20', 180, 1800.00, FALSE, 10);

INSERT INTO condominio (hotel_id, nome)
VALUES (1, 'Condomínio Central Plaza'),
       (2, 'Condomínio Pousada dos Ventos'),
       (4, 'Condomínio Hotel Urbano Premium');

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
       (5, 3, 70);

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
       ('2024-11-03', '2025-11-03', 15, 15000.00, 3, 1, 2),
       ('2024-11-04', '2025-11-04', 20, 9000.00, 4, 1, 3),
       ('2024-11-05', '2025-11-05', 25, 3000.00, 5, 2, 3);

INSERT INTO espaco_de_evento (tamanho_em_metros_total, hotel_id)
VALUES (700, 1),
       (500, 2),
       (450, 3),
       (600, 4);

INSERT INTO tipo_de_uso (nome, descricao)
VALUES ('Casamento', 'Eventos de celebração matrimonial'),
       ('Festa de Aniversário', 'Comemorações de aniversários'),
       ('Formatura', 'Celebrações de conclusão de cursos'),
       ('Reunião Corporativa', 'Reuniões de negócios e apresentações'),
       ('Treinamento', 'Espaço para workshops e treinamentos'),
       ('Feira de Exposições', 'Feiras e exposições comerciais'),
       ('Lançamento de Produto', 'Eventos de lançamento de novos produtos'),
       ('Conferência', 'Conferências e seminários'),
       ('Show Musical', 'Apresentações musicais e culturais'),
       ('Palestra', 'Eventos educativos e informativos');

INSERT INTO local_evento (tipo_de_espaco, tipo_de_uso_id, tamanho_em_metros, capacidade, espaco_evento_id)
VALUES ('Salão Principal', 1, 50, 200, 1),
       ('Sala VIP', 2, 60, 50, 1),
       ('Auditório', 3, 75, 300, 2),
       ('Sala de Reunião', 4, 55, 20, 2),
       ('Espaço ao Ar Livre', 5, 120, 150, 3),
       ('Teatro', 7, 100, 400, 3),
       ('Palco Aberto', 9, 80, 100, 4),
       ('Sala de Palestra', 10, 70, 120, 4);

INSERT INTO vale (tipo, descricao, valor, percentual_de_desconto, tipo_contrato_beneficiario_id)
VALUES ('Alimentação', 'Vale para compras em supermercados', 800.00, 3.00, 1),
       ('Alimentação', 'Vale para compras em supermercados', 300.00, 3.00, 3),
       ('Transporte', 'Vale transporte mensal para deslocamento urbano', 300.00, 2.00, 1),
       ('Transporte', 'Vale transporte mensal para deslocamento urbano', 250.00, 2.00, 2),
       ('Transporte', 'Vale transporte mensal para deslocamento urbano', 300.00, 0.00, 3),
       ('Refeição', 'Vale refeição para uso em restaurantes', 600.00, 3.00, 1),
       ('Refeição', 'Vale refeição para uso em restaurantes', 600.00, 3.00, 3);

INSERT INTO estacionamento (tipo, capacidade, valor_diaria, hotel_id)
VALUES ('COBERTO', 50, 25.00, 1),
       ('AR_LIVRE', 100, 15.00, 2),
       ('COBERTO', 100, 15.00, 2),
       ('COBERTO', 20, 50.00, 3),
       ('COBERTO', 30, 20.00, 4),
       ('AR_LIVRE', 70, 15.00, 4);

INSERT INTO reserva_acomodacao (data_esperada_checkin, data_esperada_checkout, data_checkin, data_checkout,
                                numero_acomodacao, hotel_id, hospede_id)
VALUES ('2024-11-01 14:00:00', '2024-11-03 12:00:00', '2024-11-01 15:00:00', '2024-11-03 11:30:00', 1, 1, 1),
       ('2024-11-02 14:00:00', '2024-11-05 12:00:00', '2024-11-02 14:30:00', '2024-11-05 12:00:00', 2, 1, 2),
       ('2024-11-04 14:00:00', '2024-11-06 12:00:00', '2024-11-04 14:15:00', '2024-11-06 14:15:00', 3, 2, 3),
       ('2024-11-05 14:00:00', '2024-11-07 12:00:00', NULL, NULL, 1, 2, 4),
       ('2024-11-06 14:00:00', '2024-11-08 12:00:00', '2024-11-06 14:05:00', '2024-11-06 14:05:00', 2, 3, 5),
       ('2024-11-07 14:00:00', '2024-11-09 12:00:00', NULL, NULL, 1, 3, 6),
       ('2024-11-08 14:00:00', '2024-11-10 12:00:00', '2024-11-08 15:00:00', '2024-11-10 11:45:00', 5, 4, 7),
       ('2024-11-09 14:00:00', '2024-11-11 12:00:00', '2024-11-09 14:45:00', '2024-11-11 14:45:00', 6, 4, 8),
       ('2024-11-10 14:00:00', '2024-11-12 12:00:00', '2024-11-10 15:00:00', '2024-11-12 11:50:00', 6, 1, 9),
       ('2024-11-28 14:00:00', '2024-12-02 12:00:00', NULL, NULL, 1, 1, 10),
       ('2024-11-29 14:00:00', '2024-12-03 12:00:00', NULL, NULL, 2, 1, 11),
       ('2024-11-30 14:00:00', '2024-12-04 12:00:00', NULL, NULL, 3, 1, 12),
       ('2024-12-01 14:00:00', '2024-12-05 12:00:00', NULL, NULL, 4, 2, 13),
       ('2024-12-02 14:00:00', '2024-12-06 12:00:00', NULL, NULL, 5, 2, 14),
       ('2024-12-03 14:00:00', '2024-12-07 12:00:00', NULL, NULL, 6, 2, 15),
       ('2024-12-04 14:00:00', '2024-12-08 12:00:00', NULL, NULL, 7, 3, 16),
       ('2024-12-05 14:00:00', '2024-12-09 12:00:00', NULL, NULL, 8, 1, 17),
       ('2024-12-06 14:00:00', '2024-12-10 12:00:00', NULL, NULL, 9, 1, 18),
       ('2024-12-07 14:00:00', '2024-12-11 12:00:00', NULL, NULL, 10, 4, 19);

INSERT INTO reserva_estacionamento (data_checkin, data_checkout, reserva_acomodacao_id, estacionamento_id)
VALUES ('2024-11-01', '2024-11-03', 1, 1),
       ('2024-11-02', '2024-11-05', 2, 1),
       ('2024-11-04', '2024-11-06', 3, 2),
       ('2024-11-05', '2024-11-07', 4, 3),
       ('2024-11-06', '2024-11-08', 5, 4),
       ('2024-11-07', '2024-11-09', 6, 5),
       ('2024-11-08', '2024-11-10', 7, 6),
       ('2024-11-09', '2024-11-11', 8, 1),
       ('2024-11-10', '2024-11-12', 9, 3),
       ('2024-11-11', '2024-11-13', 10, 6);

INSERT INTO estoque (capacidade, data_atualizacao)
VALUES (2000, '2024-11-01 10:00:00'),
       (2500, '2024-11-01 11:00:00'),
       (1800, '2024-11-01 12:00:00'),
       (2200, '2024-11-01 13:00:00');

INSERT INTO produto (nome, marca)
VALUES ('Arroz', 'Marca A'),
       ('Feijão', 'Marca B'),
       ('Açúcar', 'Marca C'),
       ('Óleo', 'Marca D'),
       ('Macarrão', 'Marca E'),
       ('Farinha', 'Marca F'),
       ('Sal', 'Marca G'),
       ('Pimenta', 'Marca H'),
       ('Café', 'Marca I'),
       ('Chá', 'Marca J'),
       ('Leite', 'Marca K'),
       ('Manteiga', 'Marca L'),
       ('Presunto', 'Marca M'),
       ('Queijo', 'Marca N'),
       ('Tomate', 'Marca O'),
       ('Alface', 'Marca P'),
       ('Cebola', 'Marca Q'),
       ('Alho', 'Marca R'),
       ('Batata', 'Marca S'),
       ('Cenoura', 'Marca T'),
       ('Banana', 'Marca U'),
       ('Maçã', 'Marca V'),
       ('Laranja', 'Marca W'),
       ('Melancia', 'Marca X'),
       ('Uva', 'Marca Y'),
       ('Limão', 'Marca Z'),
       ('Frango', 'Marca AA'),
       ('Carne', 'Marca AB'),
       ('Peixe', 'Marca AC'),
       ('Ovos', 'Marca AD'),
       ('Iogurte', 'Marca AE'),
       ('Suco', 'Marca AF'),
       ('Água', 'Marca AG'),
       ('Refrigerante', 'Marca AH'),
       ('Chocolate', 'Marca AI'),
       ('Biscoitos', 'Marca AJ'),
       ('Pão', 'Marca AK'),
       ('Pizza', 'Marca AL'),
       ('Salgadinhos', 'Marca AM'),
       ('Molho de tomate', 'Marca AN');

INSERT INTO cozinha (nome, tamanho_em_metros, hotel_id, estoque_id)
VALUES ('Cozinha Principal', 70, 1, 1),
       ('Cozinha Gourmet', 50, 2, 2),
       ('Cozinha Principal', 55, 3, 3),
       ('Cozinha Local', 45, 4, 4);

INSERT INTO estoque_produto (produto_id, estoque_id, quantidade)
VALUES (1, 1, 50),
       (2, 1, 60),
       (3, 1, 40),
       (4, 1, 30),
       (5, 1, 20),
       (6, 1, 10),
       (7, 1, 70),
       (8, 1, 80),
       (9, 1, 25),
       (10, 1, 15),
       (11, 2, 100),
       (12, 2, 90),
       (13, 2, 110),
       (14, 2, 120),
       (15, 2, 130),
       (16, 2, 140),
       (17, 2, 150),
       (18, 2, 160),
       (19, 2, 170),
       (20, 2, 180),
       (21, 3, 60),
       (22, 3, 70),
       (23, 3, 80),
       (24, 3, 90),
       (25, 3, 100),
       (26, 3, 110),
       (27, 3, 120),
       (28, 3, 130),
       (29, 3, 140),
       (30, 3, 150),
       (31, 4, 200),
       (32, 4, 190),
       (33, 4, 180),
       (34, 4, 170),
       (35, 4, 160),
       (36, 4, 150),
       (37, 4, 140),
       (38, 4, 130),
       (39, 4, 120),
       (40, 4, 110);

INSERT INTO manutencao (descricao, data_hora_inicio, data_hora_fim)
VALUES ('Troca de encanamento', '2024-11-10 08:00:00', '2024-11-10 12:00:00'),
       ('Revisão elétrica', '2024-11-11 09:00:00', '2024-11-11 15:00:00'),
       ('Pintura externa', '2024-11-12 08:00:00', '2024-11-12 18:00:00'),
       ('Reforma no telhado', '2024-11-13 07:00:00', '2024-11-13 19:00:00'),
       ('Manutenção de ar-condicionado', '2024-11-14 10:00:00', '2024-11-14 14:00:00');

INSERT INTO acomodacao_manutencao (numero_acomodacao, hotel_id, manutencao_id)
VALUES (1, 1, 1),
       (2, 1, 2),
       (1, 2, 3),
       (1, 3, 4),
       (1, 4, 5);

INSERT INTO sala_condominio_manutencao (numero_sala_condominio, condominio_id, manutencao_id)
VALUES (1, 1, 1),
       (2, 1, 2),
       (1, 2, 3),
       (1, 3, 4),
       (1, 3, 5);

INSERT INTO local_evento_manutencao (local_evento_id, manutencao_id)
VALUES (1, 1),
       (2, 2),
       (1, 3),
       (1, 4),
       (1, 5);

INSERT INTO entrega (descricao, data_hora, reserva_id, empresa_remetente_id)
VALUES ('Entrega de almoço', '2024-11-18 10:00:00', 1, 1),
       ('Entrega de alimento', '2024-11-18 14:00:00', 2, 2),
       ('Entrega de café da manhã', '2024-11-19 09:00:00', 3, 3),
       ('Entrega de bebidas', '2024-11-19 16:30:00', 4, 4),
       ('Entrega de presentes', '2024-11-20 11:00:00', 5, 5),
       ('Entrega de itens decorativos', '2024-11-20 15:00:00', 6, 2),
       ('Entrega de eletrônicos', '2024-11-21 08:30:00', 7, 3),
       ('Entrega de materiais de escritório', '2024-11-21 13:00:00', 8, 1),
       ('Entrega de frutas e legumes', '2024-11-22 07:00:00', 9, 4);

INSERT INTO plano_de_saude (nome, cnpj_fornecedor, valor_mensal, possui_coparticipacao, tipo_contrato_beneficiario_id)
VALUES ('Amil Básico', '12.345.678/0001-99', 350.00, FALSE, 2),
       ('Amil Premium', '12.345.678/0001-99', 650.00, TRUE, 1);

INSERT INTO pedido (descricao, valor, data_hora, reserva_acomodacao_id)
VALUES ('Café da manhã', 30.00, '2024-11-01 07:30:00', 1),
       ('Almoço', 50.00, '2024-11-01 12:00:00', 1),
       ('Serviço de quarto', 40.00, '2024-11-01 20:00:00', 1),
       ('Café da manhã', 30.00, '2024-11-02 07:30:00', 2),
       ('Almoço', 50.00, '2024-11-02 12:00:00', 2),
       ('Serviço de quarto', 40.00, '2024-11-02 20:00:00', 2),
       ('Café da manhã', 30.00, '2024-11-04 07:30:00', 3),
       ('Almoço', 50.00, '2024-11-04 12:00:00', 3),
       ('Serviço de quarto', 40.00, '2024-11-04 20:00:00', 3),
       ('Café da manhã', 30.00, '2024-11-05 07:30:00', 4);

INSERT INTO nota_fiscal (numero, data_emissao, valor, documento_emissor_id, documento_destinatario_id)
VALUES ('NF-1001', '2024-11-01', 5000.00, 31, 35),
       ('NF-1002', '2024-11-02', 1500.00, 31, 35),
       ('NF-1003', '2024-11-03', 8000.00, 32, 35),
       ('NF-1004', '2024-11-04', 12000.00, 33, 36),
       ('NF-1005', '2024-11-05', 2500.00, 34, 36),
       ('NF-1006', '2024-11-06', 3000.00, 31, 36),
       ('NF-1007', '2024-11-07', 7000.00, 32, 37),
       ('NF-1008', '2024-11-08', 4500.00, 33, 37),
       ('NF-1009', '2024-11-09', 3500.00, 34, 38),
       ('NF-1010', '2024-11-10', 6200.00, 31, 38);

INSERT INTO pagamento (titulo, descricao, nota_fiscal_id)
VALUES ('Pagamento Governo', 'Pagamento referente a impostos municipais', 1),
       ('Pagamento Associação', 'Pagamento de taxas de associação empresarial', 2),
       ('Pagamento Terceiro', 'Pagamento de serviços de terceiros para manutenção', 3),
       ('Pagamento Fornecedor', 'Pagamento de fornecedores de material', 4),
       ('Pagamento Governo', 'Pagamento referente a impostos estaduais', 5),
       ('Pagamento Associação', 'Pagamento de taxa de associação comercial', 6),
       ('Pagamento Terceiro', 'Pagamento de serviços de segurança terceirizados', 7),
       ('Pagamento Fornecedor', 'Pagamento de fornecedor de tecnologia', 8),
       ('Pagamento Governo', 'Pagamento de contribuições federais', 9),
       ('Pagamento Associação', 'Pagamento de taxas associativas regionais', 10);

INSERT INTO requisicao (id, descricao, status, tipo, data_abertura, data_fechamento, funcionario_id)
VALUES (1, 'Arrumar o ar-condicionado', 'CONCLUIDO', 'MANUTENCAO', '2024-11-20 10:30:00', '2024-11-20 14:00:00', 1),
       (2, 'Reposição de toalhas', 'ABERTO', 'ATENDIMENTO', '2024-11-22 08:15:00', NULL, 2),
       (3, 'Ajustar TV do quarto 305', 'CONCLUIDO', 'MANUTENCAO', '2024-11-21 09:45:00', '2024-11-21 12:30:00', 3),
       (4, 'Entrega de kit higiene', 'CONCLUIDO', 'ATENDIMENTO', '2024-11-22 07:00:00', '2024-11-22 07:45:00', 4),
       (5, 'Limpeza de vidros externos', 'PENDENTE', 'MANUTENCAO', '2024-11-23 09:00:00', NULL, 5),
       (6, 'Verificar aquecimento do chuveiro', 'CONCLUIDO', 'MANUTENCAO', '2024-11-20 15:20:00', '2024-11-20 18:00:00',
        1),
       (7, 'Reabastecimento de minibar', 'ABERTO', 'ATENDIMENTO', '2024-11-21 16:40:00', NULL, 6),
       (8, 'Troca de lâmpada no quarto 102', 'CONCLUIDO', 'MANUTENCAO', '2024-11-19 14:00:00', '2024-11-19 15:30:00',
        3),
       (9, 'Reposição de papel higiênico', 'CONCLUIDO', 'ATENDIMENTO', '2024-11-21 12:10:00', '2024-11-21 12:40:00',
        2),
       (10, 'Reparar vazamento no banheiro', 'ABERTO', 'MANUTENCAO', '2024-11-23 08:00:00', NULL, 7),
       (11, 'Entrega de travesseiro extra', 'CONCLUIDO', 'ATENDIMENTO', '2024-11-20 18:15:00', '2024-11-20 18:45:00',
        4),
       (12, 'Teste no sistema de alarme', 'CONCLUIDO', 'MANUTENCAO', '2024-11-18 09:30:00', '2024-11-18 11:00:00', 5),
       (13, 'Arrumar porta com problema', 'ABERTO', 'MANUTENCAO', '2024-11-22 11:45:00', NULL, 1),
       (14, 'Auxiliar com conexão Wi-Fi', 'CONCLUIDO', 'ATENDIMENTO', '2024-11-22 13:00:00', '2024-11-22 13:30:00',
        4),
       (15, 'Inspeção de extintores', 'CONCLUIDO', 'MANUTENCAO', '2024-11-21 10:00:00', '2024-11-21 11:15:00', 7),
       (16, 'Organizar evento corporativo', 'PENDENTE', 'ORGANIZACAO', '2024-11-22 14:00:00', NULL, 8),
       (17, 'Limpeza especial no quarto 402', 'ABERTO', 'LIMPEZA', '2024-11-23 09:30:00', NULL, 6),
       (18, 'Entrega de roupa de cama', 'CONCLUIDO', 'ATENDIMENTO', '2024-11-22 15:45:00', '2024-11-22 16:15:00', 2),
       (19, 'Trocar cofre do quarto 210', 'CONCLUIDO', 'MANUTENCAO', '2024-11-21 08:10:00', '2024-11-21 10:00:00', 3),
       (20, 'Organizar bagagem para transporte', 'CONCLUIDO', 'ATENDIMENTO', '2024-11-20 16:30:00',
        '2024-11-20 17:15:00', 8),
       (21, 'Reparar janela com infiltração', 'PENDENTE', 'MANUTENCAO', '2024-11-23 08:30:00', NULL, 5),
       (22, 'Desentupir pia no quarto 101', 'CONCLUIDO', 'MANUTENCAO', '2024-11-20 11:00:00', '2024-11-20 13:00:00',
        1),
       (23, 'Limpeza do salão de eventos', 'ABERTO', 'LIMPEZA', '2024-11-23 10:00:00', NULL, 7),
       (24, 'Revisar rede elétrica do quarto', 'CONCLUIDO', 'MANUTENCAO', '2024-11-19 17:00:00', '2024-11-19 19:00:00',
        3),
       (25, 'Entrega de garrafa de água extra', 'ABERTO', 'ATENDIMENTO', '2024-11-22 18:30:00', NULL, 6),
       (26, 'Arrumar cortina da sala de eventos', 'CONCLUIDO', 'MANUTENCAO', '2024-11-21 11:15:00',
        '2024-11-21 12:45:00', 5),
       (27, 'Trocar travesseiro do quarto 405', 'ABERTO', 'ATENDIMENTO', '2024-11-23 07:45:00', NULL, 4),
       (28, 'Revisar sistema de sprinklers', 'PENDENTE', 'MANUTENCAO', '2024-11-22 10:30:00', NULL, 7),
       (29, 'Organizar transporte para aeroporto', 'CONCLUIDO', 'ATENDIMENTO', '2024-11-20 05:30:00',
        '2024-11-20 06:15:00', 8),
       (30, 'Reabastecer café na recepção', 'CONCLUIDO', 'ATENDIMENTO', '2024-11-21 08:20:00', '2024-11-21 08:45:00',
        6);

INSERT INTO hospede_requisicao (hospede_id, requisicao_id)
VALUES (1, 1),
       (2, 3),
       (3, 4),
       (4, 7),
       (5, 9),
       (6, 11),
       (7, 14),
       (8, 18),
       (9, 20),
       (10, 27),
       (11, 29);

INSERT INTO academia (id, nome, descricao, hotel_id, capacidade, horario_abertura_dia_semana,
                      horario_fechamento_dia_semana, horario_abertura_fim_semana, horario_fechamento_fim_semana)
VALUES (1, 'Academia Premium', 'Espaço equipado com aparelhos modernos para treinos intensivos e relaxamento.', 1, 50,
        '06:00:00', '22:00:00', '08:00:00', '20:00:00'),
       (2, 'Academia Wellness', 'Academia focada em bem-estar com aulas de yoga e pilates disponíveis.', 2, 30,
        '07:00:00', '21:00:00', '09:00:00', '18:00:00'),
       (3, 'Fitness Center Elite', 'Área de exercícios com equipamentos de alta tecnologia e ambiente climatizado.', 3,
        40, '05:30:00', '23:00:00', '07:00:00', '22:00:00'),
       (4, 'Espaço de Treinamento Avançado', 'Local para atividades físicas, incluindo musculação e personal trainers.',
        4, 35, '06:00:00', '22:00:00', '08:00:00', '20:00:00');

INSERT INTO academia_politica_de_uso (academia_id, politica_de_uso_ide)
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (2, 1),
       (2, 3),
       (3, 2),
       (3, 3),
       (4, 1),
       (4, 2);

INSERT INTO biblioteca (id, nome, capacidade, metros_quadrados, quantidade_locacao_por_pessoa, aceita_evento_literario,
                        multa_atraso, horario_abertura_dia_semana, horario_fechamento_dia_semana,
                        horario_abertura_fim_semana, horario_fechamento_fim_semana, hotel_id)
VALUES (1, 'Biblioteca Contemporânea', 40, 120, 5, TRUE, 2.50, '08:00:00', '20:00:00', '10:00:00', '18:00:00', 1),
       (2, 'Biblioteca Literária', 30, 90, 3, FALSE, 1.50, '09:00:00', '19:00:00', '11:00:00', '17:00:00', 2);

INSERT INTO biblioteca_politica_de_uso (biblioteca_id, politica_de_uso_id)
VALUES (1, 4),
       (1, 5),
       (2, 4),
       (2, 6);

INSERT INTO livro (id, titulo, autor, editora, ano_publicacao, quantidade_paginas)
VALUES (1, 'O Morro dos Ventos Uivantes', 'Emily Brontë', 'Editora X', 1847, 320),
       (2, 'Dom Casmurro', 'Machado de Assis', 'Editora Y', 1899, 250),
       (3, '1984', 'George Orwell', 'Editora Z', 1949, 328),
       (4, 'Orgulho e Preconceito', 'Jane Austen', 'Editora W', 1813, 416),
       (5, 'A Revolução dos Bichos', 'George Orwell', 'Editora Z', 1945, 152),
       (6, 'O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'Editora V', 1943, 96),
       (7, 'Cem Anos de Solidão', 'Gabriel García Márquez', 'Editora T', 1967, 432),
       (8, 'Crime e Castigo', 'Fiódor Dostoiévski', 'Editora R', 1866, 576),
       (9, 'Senhor dos Anéis: A Sociedade do Anel', 'J.R.R. Tolkien', 'Editora Q', 1954, 423),
       (10, 'O Hobbit', 'J.R.R. Tolkien', 'Editora Q', 1937, 310),
       (11, 'Moby Dick', 'Herman Melville', 'Editora K', 1851, 635),
       (12, 'A Metamorfose', 'Franz Kafka', 'Editora M', 1915, 120),
       (13, 'Memórias Póstumas de Brás Cubas', 'Machado de Assis', 'Editora Y', 1881, 208),
       (14, 'Os Miseráveis', 'Victor Hugo', 'Editora H', 1862, 1488),
       (15, 'Drácula', 'Bram Stoker', 'Editora F', 1897, 418),
       (16, 'A Divina Comédia', 'Dante Alighieri', 'Editora C', 1320, 798),
       (17, 'O Alquimista', 'Paulo Coelho', 'Editora N', 1988, 208),
       (18, 'As Crônicas de Nárnia', 'C.S. Lewis', 'Editora P', 1956, 767),
       (19, 'O Nome da Rosa', 'Umberto Eco', 'Editora O', 1980, 512),
       (20, 'Ilíada', 'Homero', 'Editora L', 1750, 704),
       (21, 'Odisséia', 'Homero', 'Editora L', 1725, 560),
       (22, 'A Guerra dos Mundos', 'H.G. Wells', 'Editora G', 1898, 288),
       (23, 'Anna Kariênina', 'Liev Tolstói', 'Editora S', 1877, 864),
       (24, 'A Máquina do Tempo', 'H.G. Wells', 'Editora G', 1895, 118),
       (25, 'O Processo', 'Franz Kafka', 'Editora M', 1925, 300),
       (26, 'O Grande Gatsby', 'F. Scott Fitzgerald', 'Editora U', 1925, 218),
       (27, 'Jane Eyre', 'Charlotte Brontë', 'Editora J', 1847, 500),
       (28, 'O Código Da Vinci', 'Dan Brown', 'Editora D', 2003, 689),
       (29, 'Inferno', 'Dan Brown', 'Editora D', 2013, 480),
       (30, 'Anjos e Demônios', 'Dan Brown', 'Editora D', 2000, 616);

INSERT INTO locacao_livro (livro_id, reserva_acomodacao_id, data_locacao, data_esperada_devolucao, data_devolucao)
VALUES (1, 1, '2024-11-01', '2024-11-08', '2024-11-07'),
       (2, 2, '2024-11-03', '2024-11-10', '2024-11-09'),
       (3, 3, '2024-11-04', '2024-11-11', '2024-11-11'),
       (4, 4, '2024-11-05', '2024-11-12', '2024-11-10'),
       (5, 5, '2024-11-06', '2024-11-13', '2024-11-13'),
       (6, 6, '2024-11-07', '2024-11-14', NULL),
       (7, 7, '2024-11-08', '2024-11-15', NULL),
       (8, 8, '2024-11-09', '2024-11-16', '2024-11-15'),
       (9, 9, '2024-11-10', '2024-11-17', NULL),
       (10, 10, '2024-11-11', '2024-11-18', '2024-11-18');

INSERT INTO biblioteca_livro (livro_id, biblioteca_id)
VALUES (1, 1),
       (1, 2),
       (2, 1),
       (2, 2),
       (3, 1),
       (3, 2),
       (4, 1),
       (4, 2),
       (5, 1),
       (5, 2),
       (6, 1),
       (6, 2),
       (7, 1),
       (7, 2),
       (8, 1),
       (8, 2),
       (9, 1),
       (9, 2),
       (10, 1),
       (10, 2),
       (11, 1),
       (11, 2),
       (12, 1),
       (12, 2),
       (13, 1),
       (13, 2),
       (14, 1),
       (14, 2),
       (15, 1),
       (15, 2),
       (16, 1),
       (16, 2),
       (17, 1),
       (17, 2),
       (18, 1),
       (18, 2),
       (19, 1),
       (19, 2),
       (20, 1),
       (20, 2),
       (21, 1),
       (21, 2),
       (22, 1),
       (22, 2),
       (23, 1),
       (23, 2),
       (24, 1),
       (24, 2),
       (25, 1),
       (25, 2),
       (26, 1),
       (26, 2),
       (27, 1),
       (27, 2),
       (28, 1),
       (28, 2),
       (29, 1),
       (29, 2),
       (30, 1),
       (30, 2);

INSERT INTO veiculo (id, modelo, marca, ano_fabricacao, capacidade, tipo, placa, hotel_id)
VALUES (1, 'SPRINTER 415', 'MERCEDES-BENZ', 2020, 15, 'VAN', 'ABC1234', 1),
       (2, 'COROLLA', 'TOYOTA', 2022, 4, 'CARRO', 'DEF5678', 1),
       (3, 'CIVIC', 'HONDA', 2021, 4, 'CARRO', 'GHI9012', 2),
       (4, 'DUSTER', 'RENAULT', 2023, 5, 'SUV', 'JKL3456', 2),
       (5, 'MASTER EXECUTIVE', 'RENAULT', 2020, 16, 'VAN', 'MNO7890', 3),
       (6, 'SPIN', 'CHEVROLET', 2021, 7, 'MINIVAN', 'PQR1234', 3),
       (7, 'HILUX', 'TOYOTA', 2022, 5, 'PICKUP', 'STU5678', 4),
       (8, 'FIORINO', 'FIAT', 2019, 2, 'UTILITARIO', 'VWX9012', 4);

INSERT INTO transporte (id, tipo, valor, descricao, hotel_partida_id, reserva_acomodacao_id, horario_partida,
                        horario_esperado_chegada, horario_chegada, veiculo_id)
VALUES (1, 'TRANSFER', 150.00, 'Transporte para o aeroporto com conforto e segurança.', 1, 1, '2024-11-23 08:00:00',
        '2024-11-23 09:30:00', '2024-11-23 09:25:00', 1),
       (2, 'TOUR', 250.00, 'Passeio turístico pela cidade com guia incluso.', 1, 2, '2024-11-23 10:00:00',
        '2024-11-23 14:00:00', '2024-11-23 14:15:00', 2),
       (3, 'TRANSFER', 100.00, 'Viagem rápida até o shopping mais próximo.', 2, 3, '2024-11-23 11:00:00',
        '2024-11-23 11:30:00', '2024-11-23 11:25:00', 3),
       (4, 'TOUR', 200.00, 'Visita guiada a pontos históricos da cidade.', 2, 4, '2024-11-23 13:00:00',
        '2024-11-23 17:00:00', NULL, 4),
       (5, 'TRANSFER', 120.00, 'Deslocamento confortável para a estação de trem.', 3, 5, '2024-11-23 09:00:00',
        '2024-11-23 09:45:00', '2024-11-23 09:40:00', 5),
       (6, 'TOUR', 300.00, 'Excursão a um parque natural nas proximidades.', 3, 6, '2024-11-23 07:00:00',
        '2024-11-23 13:00:00', NULL, 6),
       (7, 'TRANSFER', 80.00, 'Corrida até o centro da cidade.', 4, 7, '2024-11-23 15:00:00', '2024-11-23 15:30:00',
        '2024-11-23 15:20:00', 7),
       (8, 'TOUR', 180.00, 'Passeio até a região vinícola local.', 4, 8, '2024-11-23 16:00:00', '2024-11-23 19:00:00',
        '2024-11-23 18:50:00', 8);

INSERT INTO atividade_lazer (id, nome, descricao, data_hora_inicio, data_hora_fim, hotel_id, capacidade)
VALUES (1, 'Aula de Yoga', 'Sessão de yoga para relaxamento e equilíbrio.', '2024-11-25 08:00:00',
        '2024-11-25 09:30:00', 1, 15),
       (2, 'Workshop de Coquetéis', 'Aprenda a fazer coquetéis com um bartender profissional.', '2024-11-25 19:00:00',
        '2024-11-25 21:00:00', 2, 10),
       (3, 'Caminhada Guiada', 'Passeio pela região com guia explicando curiosidades locais.', '2024-11-26 07:00:00',
        '2024-11-26 09:00:00', 3, 20),
       (4, 'Aula de Dança', 'Aulas de dança de salão para iniciantes.', '2024-11-26 18:00:00', '2024-11-26 20:00:00', 4,
        12),
       (5, 'Oficina de Artesanato', 'Criação de peças artesanais com materiais recicláveis.', '2024-11-27 10:00:00',
        '2024-11-27 12:00:00', 1, 8);

INSERT INTO inscricao_atividade_lazer (atividade_lazer_id, hospede_id)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (2, 4),
       (3, 5),
       (3, 6),
       (4, 7),
       (4, 8),
       (5, 9),
       (5, 10);