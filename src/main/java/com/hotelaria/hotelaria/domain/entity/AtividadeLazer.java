package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

// CREATE TABLE atividade_lazer
//(
//    id               BIGINT AUTO_INCREMENT NOT NULL,
//    nome             VARCHAR(120) NOT NULL,
//    descricao        VARCHAR(255) NOT NULL,
//    data_hora_inicio DATETIME     NOT NULL,
//    data_hora_fim    DATETIME     NOT NULL,
//    hotel_id         BIGINT       NOT NULL,
//    capacidade       BIGINT       NOT NULL,
//    PRIMARY KEY (id),
//    FOREIGN KEY (hotel_id) REFERENCES hotel (id)
//);

@Entity
public class AtividadeLazer {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String nome;
  private String descricao;
  @Column(name = "data_hora_inicio")
  private LocalDateTime dataHoraInicio;
  @Column(name = "data_hora_fim")
  private LocalDateTime dataHoraFim;
  @ManyToOne
  @JoinColumn(name = "hotel_id")
  private Hotel hotel;
  private Long capacidade;
}
