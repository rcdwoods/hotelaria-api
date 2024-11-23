package com.hotelaria.hotelaria.domain.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import java.time.LocalDateTime;

@Entity
public class Manutencao {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  private String descricao;
  private LocalDateTime dataHoraInicio;
  private LocalDateTime dataHoraFim;
}
