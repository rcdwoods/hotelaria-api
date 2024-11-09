package com.hotelaria.hotelaria.domain.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
public class Estacionamento {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE)
  private Long id;
  @Column(name = "valor_vaga")
  private BigDecimal valorVaga;
  private Integer capacidade;
  @Enumerated(EnumType.STRING)
  private TipoEstacionamentoEnum tipo;
  @ManyToOne
  @JoinColumn(name = "hotel_id")
  private Hotel hotel;
}
